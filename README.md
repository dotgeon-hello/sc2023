# AcousticNote

## Getting Started

Before getting started, you need to have Flutter installed on your machine. You can find the installation instructions [here](https://flutter.dev/docs/get-started/install).

You must also have an OpenAI API Key and Google Cloud Credentials (credentials.json).

1. Please run the following commands to set up the project.

    ```
    flutter pub get
    flutter packages pub run build_runner build --delete-conflicting-outputs
    ```


2. After finishing the above commands, you should set up the .env file in the root directory of the project. The .env file should contain the following information.

    ```
    OPENAI_API_KEY=(Your OpenAI API Key)
    GOOGLECLOUD_CREDENTIALS=(Your Google Cloud Credentials in JSON format)
    ```

    Note that the Google Cloud Credentials should be in JSON format. For example, the following is a sample of Google Cloud Credentials in JSON format.

    ```
    OPENAI_API_KEY=...
    GOOGLECLOUD_CREDENTIALS={"type": "service_account", "project_id": "...", "private_key_id": "...", "private_key": "...", "client_email": "...", "client_id": "...", "auth_uri": "...", "token_uri": "...",  "auth_provider_x509_cert_url": "...", "client_x509_cert_url": "..."}
    ```

3. After setting the environment file, you can run the project on the device using the command below.

    **Important Note: An error relevant SoundStreamPlugin is expected during the building process. In this case, please refer to the Troubleshooting (SoundStreamPlugin) section to solve the problem.**

    In our case, we ran the project on an Android device connected to our mobile phone. The following command is the command we used to run the project on the device.

    ```
    flutter install
    ```

    Alternatively, to build the project into APK, please run the following command.

    ```
    flutter build apk --split-per-abi
    ```

    The APK file will be generated in the following directory: ```build\app\outputs\flutter-apk```

    Pre-built APK files can be found in the [link](https://dotgeon.voltexpixel.com/sc2023_acousticnote_androidbuild).

---

## Troubleshooting (SoundStreamPlugin)

    e: C:\Users\...\AppData\Local\Pub\Cache\hosted\pub.dev\sound_stream-0.3.0\android\src\main\kotlin\vn\casperpas\sound_stream\SoundStreamPlugin.kt: (45, 8): Class 'SoundStreamPlugin' is not abstract and does not implement abstract member public abstract fun onRequestPermissionsResult(p0: Int, p1: Array<(out) String!>, p2: IntArray): Boolean defined in io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener
    e: C:\Users\...\AppData\Local\Pub\Cache\hosted\pub.dev\sound_stream-0.3.0\android\src\main\kotlin\vn\casperpas\sound_stream\SoundStreamPlugin.kt: (182, 5): 'onRequestPermissionsResult' overrides nothing

If you encounter the following error during the building process, please follow the steps below to solve the problem.

1. Open ```%localappdata%\Pub\Cache\hosted\pub.dev\sound_stream-0.3.0\android\src\main\kotlin\vn\casperpas\sound_stream\SoundStreamPlugin.kt``` (Windows) in the text editor.

2. Find the lines with the following code.

    ``
    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>?,
                                            grantResults: IntArray?): Boolean {
    ``

3. Remove the ```?``` in each argument of the function. The code should look like the following.

    ``
    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>,
                                            grantResults: IntArray): Boolean {
    ``

4. Save the file and run the project again. (Step 3)

References:
- https://hash-code.net/flutter/flutter-e-class-soundstreamplugin-is-not-abstract-and-does-not-implement-abstract-member-public-abstract-fun-onrequestpermissionsresult-e-onrequestpermissionsresult-overrides-nothing/
- https://github.com/am15h/tflite_flutter_plugin/issues/195

---

## Notes:

- It is recommended to run the project on a physical device. (The project may not work properly on a virtual device.)
- Please make sure NOT to run the project on a web browser. The project may not work properly on a web browser.
