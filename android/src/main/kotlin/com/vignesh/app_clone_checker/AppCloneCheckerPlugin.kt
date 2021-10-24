package com.vignesh.app_clone_checker

import android.app.Activity
import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** AppCloneCheckerPlugin */
class AppCloneCheckerPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private val dualAppId999 = "999"
    private val dot = '.'
    private var myActivity: Activity? = null


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "app_clone_checker")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {

            AppConstants.getPlatformVersion -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }

            AppConstants.checkDeviceCloned -> {
                val resultMap = mutableMapOf<String, String>()

                var isValidApp = true
                val applicationID = call.argument<String>(AppConstants.applicationID)
                        ?: "" //"com.vignesh.app_clone_checker"

                if (applicationID.isBlank() || applicationID.isEmpty()) {
                    resultMap[AppConstants.responseResultKey] = AppConstants.failureID
                    resultMap[AppConstants.responseMessageKey] = AppConstants.failureAppIdMessage
                    result.success(resultMap.toMap())
                    return
                }

                val appPackageDotCount = applicationID.count { it == '.' }

                myActivity?.let {

                    val path: String = it.filesDir.path
                    if (path.contains(dualAppId999)) {
                        ///"Cloned App"
                        isValidApp = false
                    } else {
                        val count: Int = getDotCount(path, appPackageDotCount)
                        if (count > appPackageDotCount) {
                            ///"Cloned App"
                            isValidApp = false
                        }
                    }

                }


                if (myActivity != null && isValidApp) {
                    resultMap[AppConstants.responseResultKey] = AppConstants.successID
                    resultMap[AppConstants.responseMessageKey] = AppConstants.successMessage
                    result.success(resultMap.toMap())
                } else {
                    resultMap[AppConstants.responseResultKey] = AppConstants.failureID
                    resultMap[AppConstants.responseMessageKey] = AppConstants.failureMessage
                    result.success(resultMap.toMap())
                }

            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun getDotCount(path: String, appPackageDotCount: Int): Int {
        var count = 0
        for (element in path) {
            if (count > appPackageDotCount) {
                break
            }
            if (element == dot) {
                count++
            }
        }
        return count
    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.myActivity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        this.myActivity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        this.myActivity = binding.activity
    }

    override fun onDetachedFromActivity() {
        this.myActivity = null
    }
}
