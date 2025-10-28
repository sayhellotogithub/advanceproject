plugins {
    alias(libs.plugins.kotlin.jvm)
    alias(libs.plugins.sqldelight)
}

kotlin {
    jvmToolchain(17)
}

dependencies {
//    implementation(projects.domain)
    implementation(libs.sqldelight.driver.jdbc)
    implementation(libs.sqldelight.primitive.adapters)
}

sqldelight {
    databases {
        create("AppDatabase") {
            packageName.set("com.poyopoyo.userapi.db")
            schemaOutputDirectory.set(file("src/main/sqldelight/databases"))
            srcDirs.setFrom(files("src/main/sqldelight"))
        }
    }
}
