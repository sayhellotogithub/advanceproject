package com.poyopoyo.userapi.plugins

import com.poyopoyo.userapi.utils.security.JwtProvider
import io.ktor.server.application.*
import io.ktor.server.application.install
import io.ktor.server.auth.Authentication
import io.ktor.server.auth.jwt.*

fun Application.configureSecurity(){
    install(Authentication){
        jwt("auth-jwt") {
            realm = JwtProvider.realm
            verifier(JwtProvider.verifier)
            validate { cred ->
                val id = cred.payload.getClaim("uid")?.asLong()
                if (id != null) JWTPrincipal(cred.payload) else null
            }
        }
    }
}