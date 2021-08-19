package com.example.movenet_platform

import android.Manifest
import android.app.AlertDialog
import android.app.Dialog
import android.content.Context
import android.content.pm.PackageManager
import android.graphics.*
import android.hardware.camera2.*
import android.media.ImageReader
import android.os.*
import android.util.Log
import android.util.Size
import android.view.SurfaceHolder
import android.view.SurfaceView
import android.view.WindowManager
import android.widget.TextView
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import com.example.movenet_platform.VisualizationUtils.drawBodyKeypoints
import com.example.movenet_platform.data.Device
import com.example.movenet_platform.ml.PoseDetector
import androidx.fragment.app.DialogFragment
import com.example.movenet_platform.ml.ModelType
import com.example.movenet_platform.ml.MoveNet

class CameraActivity: AppCompatActivity() {

    companion object {
        private const val PREVIEW_WIDTH = 640
        private const val PREVIEW_HEIGHT = 480
        private const val FRAGMENT_DIALOG = "dialog"
        private const val TAG = "PoseEstimation"
    }

    private lateinit var surfaceView: SurfaceView

    private lateinit var scoreTextView:TextView

    private lateinit var inferenceTimeTextView: TextView

    private lateinit var modelTextView: TextView

    private lateinit var surfaceHolder: SurfaceHolder

    private var backgroundHandler: Handler? = null

    private var previewSize: Size? = null

    private var backgroundThread: HandlerThread? = null

    private var cameraId: String = ""

    private var previewWidth = 0

    private var previewHeight = 0

    private var cameraDevice: CameraDevice? = null

    private var captureSession: CameraCaptureSession? = null

    private var poseDetector: PoseDetector? = null

    private var device = Device.CPU

    private var modelPos = 2

    private var imageReader: ImageReader? = null

    private val minConfidence = .2f

    private var previewRequestBuilder: CaptureRequest.Builder? = null

    private var previewRequest: CaptureRequest? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_camera)

        window.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)

        requestPermission()
        createPoseEstimator()

        surfaceView = findViewById(R.id.surfaceView)
        scoreTextView = findViewById(R.id.scoreText)
        inferenceTimeTextView = findViewById(R.id.inferenceTimeTextView)
        modelTextView = findViewById(R.id.modelTextView)
        surfaceHolder = surfaceView.holder
    }

    override fun onStart() {
        super.onStart()
        openCamera()
    }

    override fun onResume() {
        super.onResume()
        startBackgroundThread()
    }

    override fun onPause() {
        closeCamera()
        stopBackgroundThread()
        super.onPause()
    }

    override fun onDestroy() {
        super.onDestroy()
        poseDetector?.close()
    }

    private fun createPoseEstimator() {
        closeCamera()
        stopBackgroundThread()
        poseDetector?.close()
        poseDetector = null

        poseDetector = MoveNet.create(this, device,MoveNet.modelType)

        openCamera()
        startBackgroundThread()
    }



    private val stateCallback = object : CameraDevice.StateCallback() {
        override fun onOpened(camera: CameraDevice) {
            this@CameraActivity.cameraDevice = camera
            createCameraPreviewSession()
        }

        override fun onDisconnected(camera: CameraDevice) {
            camera.close()
            cameraDevice = null
        }

        override fun onError(camera: CameraDevice, error: Int) {
            onDisconnected(camera)
        }
    }



    private val requestPermissionLauncher =
        registerForActivityResult(
            ActivityResultContracts.RequestPermission()
        ) { isGranted: Boolean ->
            if (isGranted) {
                // Permission is granted. Continue the action or workflow in your
                // app.
                openCamera()
            } else {

                ErrorDialog.newInstance("App required permission").show(supportFragmentManager, FRAGMENT_DIALOG)
            }
        }

    private fun requestPermission() {
        when (PackageManager.PERMISSION_GRANTED) {
            ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.CAMERA
            ) -> {
                // You can use the API that requires the permission.
                openCamera()
            }
            else -> {
                // You can directly ask for the permission.
                // The registered ActivityResultCallback gets the result of this request.
                requestPermissionLauncher.launch(
                    Manifest.permission.CAMERA
                )
            }
        }
    }

    private var imageAvailableListener = object : ImageReader.OnImageAvailableListener {
        override fun onImageAvailable(imageReader: ImageReader) {
            // We need wait until we have some size from onPreviewSizeChosen
            if (previewWidth == 0 || previewHeight == 0) {
                return
            }

            /*val objects = initFPSNew("Measure fps is-->", frameTime, frameCount)
            frameTime = objects!![0] as Long
            frameCount = objects[1] as Int
            Log.v("FRAME : ",frameCount.toString())*/

            val image = imageReader.acquireLatestImage() ?: return
            val nv21Buffer =
                ImageUtils.yuv420ThreePlanesToNV21(image.planes, previewWidth, previewHeight)
            val imageBitmap = ImageUtils.getBitmap(nv21Buffer!!, previewWidth, previewHeight)

            // Create rotated version for portrait display
            val rotateMatrix = Matrix()
            rotateMatrix.postRotate(90.0f)

            val rotatedBitmap = Bitmap.createBitmap(
                imageBitmap!!, 0, 0, previewWidth, previewHeight,
                rotateMatrix, true
            )
            image.close()

            processImage(rotatedBitmap)
        }
    }

    fun initFPSNew(message: String, startTime: Long, counter: Int): Array<Any?>? {
        var startTime = startTime
        var counter = counter
        val mObjectTime = arrayOfNulls<Any>(2)
        if (startTime == 0L) {
            startTime = System.currentTimeMillis()
            mObjectTime[0] = startTime
            counter += 1
            mObjectTime[1] = counter
        } else {
            val difference = System.currentTimeMillis() - startTime //We wil check count only after 1 second laps
            val seconds = difference / 1000.0
            if (seconds >= 1) {
                counter = 0
                mObjectTime[0] = System.currentTimeMillis()
                mObjectTime[1] = counter
            } else {
                counter++
                mObjectTime[0] = startTime
                mObjectTime[1] = counter
            }
        }
        return mObjectTime
    }



    private fun processImage(bitmap: Bitmap) {
        var score = 0f
        var outputBitmap = bitmap

        // run detect pose
        // draw points and lines on original image
        poseDetector?.estimateSinglePose(bitmap)?.let { person ->
            score = person.score
            if (score > minConfidence) {
                outputBitmap = drawBodyKeypoints(bitmap, person)
            }
        }

        // Draw `bitmap` and `person`
        runOnUiThread {

            val canvas: Canvas = surfaceHolder.lockCanvas()

            val screenWidth: Int
            val screenHeight: Int
            val left: Int
            val top: Int

            if (canvas.height > canvas.width) {
                val ratio = outputBitmap.height.toFloat() / outputBitmap.width
                screenWidth = canvas.width
                left = 0
                screenHeight = (canvas.width * ratio).toInt()
                top = (canvas.height - screenHeight) / 2
            } else {
                val ratio = outputBitmap.width.toFloat() / outputBitmap.height
                screenHeight = canvas.height
                top = 0
                screenWidth = (canvas.height * ratio).toInt()
                left = (canvas.width - screenWidth) / 2
            }
            val right: Int = left + screenWidth
            val bottom: Int = top + screenHeight

            canvas.drawBitmap(
                outputBitmap, Rect(0, 0, outputBitmap.width, outputBitmap.height),
                Rect(left, top, right, bottom), Paint()
            )
            surfaceHolder.unlockCanvasAndPost(canvas)


            scoreTextView.text = String.format("%.2f",score)
            poseDetector?.lastInferenceTimeNanos()?.let {
                inferenceTimeTextView.text =
                    (it * 1.0f / 1_000_000).toString()
            }
            if(MoveNet.modelType == ModelType.Lightning){
                modelTextView.text = "Model: Lightning"
            }else{
                modelTextView.text = "Model: Thunder"
            }

        }



    }

    private fun openCamera() {
        // check if permission is granted or not.
        if (checkPermission(
                Manifest.permission.CAMERA,
                Process.myPid(),
                Process.myUid()
            ) == PackageManager.PERMISSION_GRANTED
        ) {
            setUpCameraOutputs()
            val manager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
            manager.openCamera(cameraId, stateCallback, backgroundHandler)
        }
    }

    private fun closeCamera() {
        captureSession?.close()
        captureSession = null
        cameraDevice?.close()
        cameraDevice = null
        imageReader?.close()
        imageReader = null
    }

    /**
     * Sets up member variables related to camera.
     */
    private fun setUpCameraOutputs() {
        val manager = getSystemService(Context.CAMERA_SERVICE) as CameraManager
        try {
            for (cameraId in manager.cameraIdList) {
                val characteristics = manager.getCameraCharacteristics(cameraId)

                // We don't use a front facing camera in this sample.
                val cameraDirection = characteristics.get(CameraCharacteristics.LENS_FACING)
                if (cameraDirection != null &&
                    cameraDirection == CameraCharacteristics.LENS_FACING_FRONT
                ) {
                    continue
                }

                previewSize = Size(PREVIEW_WIDTH, PREVIEW_HEIGHT)

                imageReader = ImageReader.newInstance(
                    PREVIEW_WIDTH, PREVIEW_HEIGHT,
                    ImageFormat.YUV_420_888, /*maxImages*/ 2
                )

                previewHeight = previewSize!!.height
                previewWidth = previewSize!!.width

                this.cameraId = cameraId

                // We've found a viable camera and finished setting up member variables,
                // so we don't need to iterate through other available cameras.
                return
            }
        } catch (e: CameraAccessException) {
        } catch (e: NullPointerException) {
            // Currently an NPE is thrown when the Camera2API is used but not supported on the
            // device this code runs.
        }
    }

    private fun startBackgroundThread() {
        backgroundThread = HandlerThread("imageAvailableListener").also { it.start() }
        backgroundHandler = Handler(backgroundThread!!.looper)
    }

    private fun stopBackgroundThread() {
        backgroundThread?.quitSafely()
        try {
            backgroundThread?.join()
            backgroundThread = null
            backgroundHandler = null
        } catch (e: InterruptedException) {
            // do nothing
        }
    }


    private fun createCameraPreviewSession() {
        try {
            // We capture images from preview in YUV format.
            imageReader = ImageReader.newInstance(
                previewSize!!.width, previewSize!!.height, ImageFormat.YUV_420_888, 2
            )
            imageReader!!.setOnImageAvailableListener(imageAvailableListener, backgroundHandler)

            // This is the surface we need to record images for processing.
            val recordingSurface = imageReader!!.surface

            // We set up a CaptureRequest.Builder with the output Surface.
            previewRequestBuilder = cameraDevice!!.createCaptureRequest(
                CameraDevice.TEMPLATE_PREVIEW
            )
            previewRequestBuilder!!.addTarget(recordingSurface)

            // Here, we create a CameraCaptureSession for camera preview.
            cameraDevice!!.createCaptureSession(
                listOf(recordingSurface),
                object : CameraCaptureSession.StateCallback() {
                    override fun onConfigured(cameraCaptureSession: CameraCaptureSession) {
                        // The camera is already closed
                        if (cameraDevice == null) return



                        // When the session is ready, we start displaying the preview.
                        captureSession = cameraCaptureSession


                        try {
                            // Auto focus should be continuous for camera preview.
                            previewRequestBuilder!!.set(
                                CaptureRequest.CONTROL_AF_MODE,
                                CaptureRequest.CONTROL_AF_MODE_CONTINUOUS_PICTURE
                            )
                            // Finally, we start displaying the camera preview.
                            previewRequest = previewRequestBuilder!!.build()
                            captureSession!!.setRepeatingRequest(
                                previewRequest!!,
                                null, null
                            )
                        } catch (e: CameraAccessException) {
                            Log.e(TAG, e.toString())
                        }
                    }

                    override fun onConfigureFailed(cameraCaptureSession: CameraCaptureSession) {
                        Toast.makeText(applicationContext, "Failed", Toast.LENGTH_SHORT).show()
                    }
                },
                null
            )
        } catch (e: CameraAccessException) {
            Log.e(TAG, "Error creating camera preview session.", e)
        }
    }
}


class ErrorDialog : DialogFragment() {

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog =
        AlertDialog.Builder(this.context)
            .setMessage(requireArguments().getString(ARG_MESSAGE))
            .setPositiveButton(android.R.string.ok) { _, _ ->
                // do nothing
            }
            .create()

    companion object {

        @JvmStatic
        private val ARG_MESSAGE = "message"

        @JvmStatic
        fun newInstance(message: String): ErrorDialog = ErrorDialog().apply {
            arguments = Bundle().apply { putString(ARG_MESSAGE, message) }
        }
    }
}

