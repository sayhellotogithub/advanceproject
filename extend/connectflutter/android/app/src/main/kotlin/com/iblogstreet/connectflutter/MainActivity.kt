package com.iblogstreet.connectflutter

import android.content.ComponentName
import android.content.pm.PackageManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.iblogstreet.connectflutter.dynamic_icon/icon"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "changeIcon") {
                val aliasName = call.argument<String>("aliasName")
                if (aliasName != null) {
                    changeIcon(aliasName)
                    result.success("Icon changed to $aliasName")
                } else {
                    result.error("INVALID_ARGUMENT", "Alias Name is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun changeIcon(aliasName: String) {
        try {
            val packageManager = packageManager
            val packageName = packageName

            val activityToEnable = when (aliasName) {
                "one" -> "$packageName.MainActivity.IconOne"
                "two" -> "$packageName.MainActivity.IconTwo"
                else -> "$packageName.MainActivity.Default"
            }
            packageManager.setComponentEnabledSetting(
                ComponentName(this, activityToEnable),
                PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
                PackageManager.DONT_KILL_APP
            )

            // 次に他のエイリアスを無効化
            val aliasList = listOf(
                "$packageName.MainActivity.Default",
                "$packageName.MainActivity.IconOne",
                "$packageName.MainActivity.IconTwo"
            )

            for (alias in aliasList) {
                if (alias != activityToEnable) {
                    packageManager.setComponentEnabledSetting(
                        ComponentName(packageName, alias),
                        PackageManager.COMPONENT_ENABLED_STATE_DISABLED,
                        PackageManager.DONT_KILL_APP
                    )
                }
            }


        } catch (e: Exception) {
            e.printStackTrace()
        }


    }

}
