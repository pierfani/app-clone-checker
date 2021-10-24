# App Clone Checker

A new Flutter plugin. - To Detect App Cloning 

## Usage

**Note:** Only works with **Android**

```sh
$ await AppCloneChecker.appOriginality("com.vignesh.app_clone_checker")
```

### Success Response
```sh
{
    "result" : "Success",
    "message" : "Valid App"
}
```

### Failure Response
```sh
{
    "result" : "Failure",
    "message" : "Cloned / In-Valid App" / "Application ID Not Passed"
}
```

This project is hosted in [PubDev](https://pub.dev/packages/app_clone_checker/)

Inspired from [ProAndroidDev](https://proandroiddev.com/preventing-android-app-cloning-e3194269bcfa) & [StackOverflow](https://stackoverflow.com/questions/48900083/preventing-an-android-app-being-cloned-by-an-app-cloner/67353578#67353578)


This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

