plugins {
    alias(libs.plugins.kotlin.jvm)
    alias(libs.plugins.kotlin.serialization)
    alias(libs.plugins.ktor)
}

application {
    mainClass.set("io.ktor.server.netty.EngineMain")
}

kotlin {
    jvmToolchain(17)
}

dependencies {
//    implementation(projects.domain)
//    implementation(projects.common.util)
    implementation(projects.data.db)

    implementation(libs.ktor.server.core)
    implementation(libs.ktor.server.netty)
    implementation(libs.ktor.server.content.negotiation)
    implementation(libs.ktor.serialization.kotlinx.json)
    implementation(libs.ktor.server.status.pages)
    implementation(libs.ktor.server.call.logging)
    implementation(libs.ktor.server.auth)
    implementation(libs.ktor.server.auth.jwt)
    implementation(libs.ktor.server.resources)

    // SQLDelight (SQLite JDBC)
    implementation(libs.sqldelight.driver.jdbc)

    //BCrypt
    implementation(libs.crypt)
    // Logging
    implementation(libs.logback)

    testImplementation(kotlin("test"))
    testImplementation(libs.ktor.server.test.host)
}

ktor {
    fatJar {
        archiveFileName.set("ktor-user-api-all.jar")
    }
}

