package com.example.flutter_native_routing;

import android.content.Intent;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity implements MethodChannel.MethodCallHandler {
    
    public static MethodChannel methodChannel;


    @Override
    protected void onNewIntent(@NonNull Intent intent) {
        super.onNewIntent(intent);

        FlutterEngine engine = getFlutterEngine();
        String stringExtra = intent.getStringExtra("route");

        if(stringExtra.equals("profileView")){
            engine.getNavigationChannel().pushRoute("profileView");
        }else if(stringExtra.equals("homeView")){
            engine.getNavigationChannel().pushRoute("homeView");
        }

    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        methodChannel = new MethodChannel(flutterEngine.getDartExecutor(), "channel");
        methodChannel.setMethodCallHandler(this);
        
    }

    void intentTo(String to) {
        Class destination = null;

        if (to.equals("poseActivity")) {
            destination = PoseActivity.class;
        } else if (to.equals("cameraActivity")) {
            destination = CameraActivity.class;
        }

        Intent intent = new Intent(this, destination);
        startActivity(intent);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if (call.method.equals("intentTo")) {
            intentTo((String) call.arguments);
            result.success(true);
        }
    }
}
