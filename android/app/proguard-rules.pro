# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Google ML Kit Commons
-keep class com.google.mlkit.common.** { *; }
-keep class com.google.android.gms.tasks.** { *; }

# Google ML Kit Pose Detection
-keep class com.google.mlkit.vision.pose.** { *; }

# TFLite Flutter
-keep class org.tensorflow.lite.** { *; }
-dontwarn org.tensorflow.lite.**
-dontwarn org.tensorflow.lite.gpu.**

# javax.lang.model warnings (Annotation processing)
-dontwarn javax.lang.model.**
-dontwarn javax.annotation.**
-keep class javax.annotation.** { *; }

# Ignore warnings for missing classes referenced by libraries if they are not used at runtime
-dontwarn com.google.errorprone.annotations.**
-dontwarn org.checkerframework.**

# Flutter Play Store Deferred Components
-dontwarn com.google.android.play.core.**
