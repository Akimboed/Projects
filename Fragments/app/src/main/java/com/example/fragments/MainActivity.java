package com.example.fragments;

import static android.text.TextUtils.replace;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentManager;

import android.annotation.SuppressLint;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Button btnperson = findViewById(R.id.personalBtn);
        Button btnprofession = findViewById(R.id.professionBtn);

//Code for the personal information button
        btnperson.setOnClickListener(new View.OnClickListener() {
            @SuppressLint("CommitTransaction")
            @Override
            public void onClick(View v) {
                FragmentManager fragmentManager = getSupportFragmentManager();
                fragmentManager.beginTransaction();

                fragmentManager.beginTransaction().replace(R.id.fragmentContainerView2,
                        personalFragment.class, null).setReorderingAllowed(true).addToBackStack("name").commit();
            }
        });
        btnprofession.setOnClickListener(new View.OnClickListener() {
            @SuppressLint("CommitTransaction")
            @Override
            public void onClick(View v) {
                FragmentManager fragmentManager = getSupportFragmentManager();
                fragmentManager.beginTransaction();

                fragmentManager.beginTransaction().replace(R.id.fragmentContainerView2,
                        professionalFragment.class, null)
                        .setReorderingAllowed(true)
                        .addToBackStack("name")
                        .commit();
            }
        });
    }
}