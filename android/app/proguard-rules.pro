# Keep Flutter-related classes
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep Agora RTC Engine classes
-keep class io.agora.** { *; }
-dontwarn io.agora.**

# Keep Firebase and Firestore classes
-keep class com.google.firebase.** { *; }
-keep class com.google.firestore.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.firestore.**

# Keep all native methods
-keepclasseswithmembers class * {
    native <methods>;
}

# Keep all annotations
-keepattributes *Annotation*

# Keep all serializable classes
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Keep all enum values
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Keep the main entry point
-keep class com.example.myapp.MainActivity {
    public static void main(java.lang.String[]);
}

# Keep line numbers for debugging
-renamesourcefileattribute SourceFile
-keepattributes SourceFile,LineNumberTable
