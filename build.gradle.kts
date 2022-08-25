import com.liewjuntung.enum_generator.EnumGeneratorPluginExtension
import java.io.FileInputStream
import java.util.*

plugins {
    id("com.liewjuntung.enum_generator") version "0.1.1"
}

/*
    Set group id for Nexus and Sonarqube analysis
    Calculate version from android/local.properties. Versions in this file gets
    modified after running "flutter build"" with the version in pubspec.yaml.
    By working this way we only deal with version in flutter affecting both android and ios.
*/
group = "com.netvirta"
//val androidLocalProperties = Properties()
//androidLocalProperties.load(FileInputStream("${project.rootDir.absolutePath}/android/local.properties"))
//version = when (project.hasProperty("publishFeatureVersion")) {
//    false -> androidLocalProperties.getProperty("flutter.versionName") + "." +
//            androidLocalProperties.getProperty("flutter.versionCode")
//    true -> project.property("publishFeatureVersion").toString()
//}

if (!project.hasProperty("releaseVersion") ||
        (project.hasProperty("releaseVersion") && project.property("releaseVersion") == true)) {
    version = version.toString().plus("-SNAPSHOT")
}

configure<EnumGeneratorPluginExtension> {
    jsonPath = ".dart_tool/build/generated/mobile_knowledge_sharing_app/lib/mobilesdk.method.gen.json"
    kotlinOutputPackageName = "com.netvirta.mobile_knowledge_sharing_app"
    kotlinOutputPath = "android/app/src/main/kotlin/"
    swiftOutputPath = "ios/Runner/"
}
