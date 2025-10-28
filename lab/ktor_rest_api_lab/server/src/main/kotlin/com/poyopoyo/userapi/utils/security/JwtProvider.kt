package com.poyopoyo.userapi.utils.security


import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import io.ktor.server.application.*

object JwtProvider {
    private lateinit var algorithm: Algorithm
    lateinit var issuer: String
    lateinit var audience: String
    lateinit var realm: String
    var expiresInMs: Long = 3600000


    fun init(app: Application) {
        val cfg = app.environment.config
        val P = "ktor.security.jwt"
        fun need(k: String) =
            cfg.propertyOrNull("$P.$k")?.getString()
                ?: error("Missing '$P.$k' (check application.conf or -D$P.$k=...)")

        realm = need("realm")
        issuer = need("issuer")
        audience = need("audience")
        expiresInMs = need("expiresInMs").toLong()
        val secret =
            cfg.propertyOrNull("$P.secret")?.getString()
                ?: System.getenv("JWT_SECRET")
                ?: error("Missing '$P.secret' (set env JWT_SECRET or -D$P.secret=...)")


        algorithm = Algorithm.HMAC256(secret)
    }

    val verifier by lazy {
        JWT.require(algorithm).withIssuer(issuer).withAudience(audience).build()
    }

    fun sign(uid: Long, username: String): String =
        JWT.create()
            .withIssuer(issuer)
            .withAudience(audience)
            .withClaim("uid", uid)
            .withClaim("un", username)
            .withExpiresAt(java.util.Date(System.currentTimeMillis() + expiresInMs))
            .sign(algorithm)
}
