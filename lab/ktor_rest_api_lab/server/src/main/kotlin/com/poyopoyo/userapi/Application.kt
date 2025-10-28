package com.poyopoyo.userapi

import com.poyopoyo.userapi.plugins.configureCallLogging
import com.poyopoyo.userapi.plugins.configureDatabase
import com.poyopoyo.userapi.plugins.configureRouting
import com.poyopoyo.userapi.plugins.configureSecurity
import com.poyopoyo.userapi.plugins.configureSerialization
import com.poyopoyo.userapi.routes.userRoutes
import com.poyopoyo.userapi.utils.security.JwtProvider
import io.ktor.server.application.Application
import io.ktor.server.engine.embeddedServer
import io.ktor.server.netty.Netty
import io.ktor.server.config.HoconApplicationConfig
import com.typesafe.config.ConfigFactory
import io.ktor.server.engine.applicationEnvironment


fun main() {
    val env = applicationEnvironment {

        config = HoconApplicationConfig(ConfigFactory.load()) // ← application.conf を明示ロード
//        module(Application::module)
//        connector { port = 8080 }
    }
    embeddedServer(Netty, environment = env).start( true)
//    embeddedServer(Netty, port = 8080, module = Application::module).start(wait = true)
//    embeddedServer(Netty, port = 8080, module = Application::module).start(wait = true)
}

fun Application.module() {
    JwtProvider.init(this)
    configureSerialization()
    configureRouting()
    userRoutes()
    configureSecurity()
    configureDatabase()
    configureCallLogging()

}