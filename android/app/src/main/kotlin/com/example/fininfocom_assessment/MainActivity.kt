package com.example.fininfocom_assessment

import android.Manifest
import android.annotation.SuppressLint
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.os.Build.VERSION_CODES
import android.os.Bundle
import android.provider.Settings
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val bluetoothChannelName = "bluetooth_channel"

    @RequiresApi(VERSION_CODES.M)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, bluetoothChannelName).setMethodCallHandler { call, result ->
            when (call.method) {
                "enableBluetooth" -> enableBluetooth(result)
                "disableBluetooth" -> disableBluetooth(result)
                else -> result.notImplemented()
            }
        }
    }

    @SuppressLint("MissingPermission")
    @RequiresApi(VERSION_CODES.M)
    private fun disableBluetooth(result: MethodChannel.Result) {
        val REQUEST_DISABLE_BT = 1
        val bluetoothManager: BluetoothManager = getSystemService(BluetoothManager::class.java)
        val bluetoothAdapter: BluetoothAdapter? = bluetoothManager.adapter
        if (bluetoothAdapter == null) {
            Toast.makeText(this,"Bluetooth not supported!",Toast.LENGTH_SHORT).show()
        }
        else{
            if (bluetoothAdapter?.isEnabled == true){
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                    val enableBtIntent = Intent(Settings.ACTION_BLUETOOTH_SETTINGS)
                    startActivityForResult(enableBtIntent, REQUEST_DISABLE_BT)
                }
                else{
                    bluetoothAdapter?.disable()
                    result.success(true)
                    Toast.makeText(this,"Bluetooth Disabled",Toast.LENGTH_SHORT).show()
                }


            }else{
                Toast.makeText(this,"Bluetooth Not Enabled",Toast.LENGTH_SHORT).show()
            }
        }
    }


    @SuppressLint("MissingPermission")
    @RequiresApi(VERSION_CODES.M)
    private fun enableBluetooth(result: MethodChannel.Result) {
        val REQUEST_ENABLE_BT = 1
        val bluetoothManager: BluetoothManager = getSystemService(BluetoothManager::class.java)
        val bluetoothAdapter: BluetoothAdapter? = bluetoothManager.adapter
        if (bluetoothAdapter == null) {
            Toast.makeText(this,"Bluetooth not supported!",Toast.LENGTH_SHORT).show()
        }
        else{
            if (bluetoothAdapter?.isEnabled == false) {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                    val enableBtIntent = Intent(Settings.ACTION_BLUETOOTH_SETTINGS)
                    startActivityForResult(enableBtIntent, REQUEST_ENABLE_BT)

                }else{
                    val enableBtIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
                    startActivityForResult(enableBtIntent, REQUEST_ENABLE_BT)
                }


            }
            else{
                Toast.makeText(this,"Bluetooth Already Enabled",Toast.LENGTH_SHORT).show()
            }
        }
        }

    }











