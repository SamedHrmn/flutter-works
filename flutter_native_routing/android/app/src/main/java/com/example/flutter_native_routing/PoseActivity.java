package com.example.flutter_native_routing;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;

public class PoseActivity extends AppCompatActivity {

    private Button buttonToCameraAcitivity;
    private Button buttonToHomeView2;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pose);

        buttonToCameraAcitivity = findViewById(R.id.buttonToCameraActivity);
        buttonToHomeView2 = findViewById(R.id.buttonToHomeView2);

        buttonToCameraAcitivity.setOnClickListener(v -> {
            Intent intent = new Intent(this,CameraActivity.class);
            startActivity(intent);
            System.out.println("intent to CameraActivity");
        });

        buttonToHomeView2.setOnClickListener(v -> {
            Intent intent = new Intent(this, MainActivity.class);
            intent.putExtra("route", "homeView");
            startActivity(intent);
            System.out.println("intent to HomeView");
        });
    }
}