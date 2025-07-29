plugins {
    alias(libs.plugins.iblog.android.feature)
    alias(libs.plugins.iblog.android.library.jacoco)
    alias(libs.plugins.iblog.android.library.compose)
    alias(libs.plugins.iblog.hilt)
}

android {
    namespace = "com.iblogstreet.login"
}

dependencies {
    implementation(libs.androidx.appcompat)
    compileOnly(projects.feature.photoExpose)
    implementation(projects.domain)

    testImplementation(libs.mockk)
    testImplementation(libs.mockk.agent.jvm)
    testImplementation(libs.kotlinx.coroutines.test)
    testImplementation(libs.junit)
}
tasks.withType<Test>().configureEach {
    useJUnitPlatform() // JUnit5 を使ってる場合のみ
    jvmArgs = listOf("--add-opens=java.base/java.lang=ALL-UNNAMED")
    jacoco {
        isEnabled = false // 🔧 MockK使うテストだけ無効化したい場合は条件分岐で
    }
}