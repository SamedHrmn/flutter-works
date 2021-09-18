package com.example.flutter_native_routing;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;

import androidx.appcompat.app.AppCompatActivity;

public class CameraActivity extends AppCompatActivity {

    private Button buttonToHomeView;
    private Button buttonToProfileView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_camera);
        
        buttonToHomeView = findViewById(R.id.buttonToHomeView);
        buttonToProfileView = findViewById(R.id.buttonToProfileView);

        buttonToHomeView.setOnClickListener(v -> {
            Intent intent = new Intent(this, MainActivity.class);
            intent.putExtra("route", "homeView");
            startActivity(intent);
            System.out.println("intent to HomeView");

        });

        buttonToProfileView.setOnClickListener(v -> {
            Intent intent = new Intent(this, MainActivity.class);
            intent.putExtra("route", "profileView");
            startActivity(intent);
            System.out.println("intent to ProfileView");

        });
    }
}