package com.example.movenet_platform

import android.content.Intent
import com.example.movenet_platform.data.Device
import com.example.movenet_platform.ml.ModelType
import com.example.movenet_platform.ml.MoveNet
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.lang.Exception
import java.util.HashMap

class MainActivity:FlutterActivity(){

    private val CHANNEL = "channel"
    lateinit var moveNet:MoveNet

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "loadModel") {
                val args = call.arguments as HashMap<*, *>
                val modelString = args["model"] as String
                val response = loadModel(modelString)
                result.success(response)
            }

            if(call.method == "startNativeCameraActivity"){
                startNativeCameraActivity()
                result.success(true)
            }

        }
    }

    private fun startNativeCameraActivity(){
        val intent = Intent(this,CameraActivity::class.java)
        startActivity(intent)

    }

    private fun loadModel(model: String): Boolean{
        var type:ModelType = ModelType.Lightning

        if(model == "movenet_lightning"){
            type = ModelType.Lightning

        }else if(model == "movenet_thunder"){
            type = ModelType.Thunder
        }

        try {
            moveNet = MoveNet.create(context,Device.CPU,type)
            return  true
        }catch (e:Exception){
            print(e.localizedMessage)
        }
        return false
    }


}