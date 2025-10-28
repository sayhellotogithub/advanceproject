package com.poyopoyo.userapi.routes

import com.poyopoyo.userapi.data.UserRepository
import com.poyopoyo.userapi.data.dto.LoginReq
import com.poyopoyo.userapi.data.dto.ProfileResp
import com.poyopoyo.userapi.data.dto.RegisterReq
import com.poyopoyo.userapi.data.dto.TokenResp
import com.poyopoyo.userapi.data.dto.UpdatePasswordReq
import com.poyopoyo.userapi.data.dto.UpdateProfileReq
import com.poyopoyo.userapi.utils.PasswordHasher
import com.poyopoyo.userapi.utils.security.JwtProvider
import databases.Users
import io.ktor.server.application.*
import io.ktor.server.request.receive
import io.ktor.server.response.*
import io.ktor.server.routing.*



import io.ktor.server.auth.*
import io.ktor.server.auth.jwt.*
import io.ktor.http.*

private fun Users.toProfile() = ProfileResp(
    id = id,
    username = username,
    email = email,
    role = role,
    status = status,
    displayName = display_name,
    avatarUrl = avatar_url
)

fun Application.userRoutes() {
    routing {
        route("/users") {
            post("/register") {
                val req = call.receive<RegisterReq>()
                val repo = UserRepository()

                if (repo.findByUsernameOrEmail(req.username) != null ||
                    repo.findByUsernameOrEmail(req.email) != null) {
                    call.respond(HttpStatusCode.Conflict, mapOf("message" to "username/email exists"))
                    return@post
                }

                val hashed = PasswordHasher.hash(req.password)
                val id = repo.create(
                    username = req.username,
                    email = req.email,
                    passwordHash = hashed
                )

                call.respond(HttpStatusCode.Created, mapOf("id" to id))
            }

            post("/login") {
                val req = call.receive<LoginReq>()
                val repo = UserRepository()
                val u = repo.findByUsernameOrEmail(req.usernameOrEmail)

                if (u == null || !PasswordHasher.verify(req.password, u.password_hash)) {
                    call.respond(HttpStatusCode.Unauthorized, mapOf("message" to "Invalid credentials"))
                    return@post
                }
                if (u.status == "deleted" || u.status == "suspended") {
                    call.respond(HttpStatusCode.Forbidden, mapOf("message" to "User not allowed"))
                    return@post
                }

                val token = JwtProvider.sign(u.id, u.username)
                call.respond(TokenResp(accessToken = token))
            }

            authenticate("auth-jwt") {
                get("/me") {
                    val principal = call.principal<JWTPrincipal>()!!
                    val uid = principal.payload.getClaim("uid").asLong()
                    val repo = UserRepository()
                    val u = repo.findById(uid)
                    if (u == null) {
                        call.respond(HttpStatusCode.NotFound)
                    } else {
                        call.respond(u.toProfile())
                    }
                }

                put("/{id}") {
                    val id = call.parameters["id"]?.toLongOrNull()
                    if (id == null) {
                        call.respond(HttpStatusCode.BadRequest)
                        return@put
                    }
                    val req = call.receive<UpdateProfileReq>()
                    val repo = UserRepository()
                    repo.updateProfile(id, req.displayName, req.avatarUrl)
                    call.respond(HttpStatusCode.OK)
                }

                put("/{id}/password") {
                    val id = call.parameters["id"]?.toLongOrNull()
                    if (id == null) { call.respond(HttpStatusCode.BadRequest); return@put }

                    val req = call.receive<UpdatePasswordReq>()
                    val repo = UserRepository()
                    val u = repo.findById(id)
                    if (u == null) { call.respond(HttpStatusCode.NotFound); return@put }

                    if (!PasswordHasher.verify(req.oldPassword, u.password_hash)) {
                        call.respond(HttpStatusCode.Unauthorized, mapOf("message" to "Old password wrong"))
                        return@put
                    }
                    repo.updatePassword(id, PasswordHasher.hash(req.newPassword))
                    call.respond(HttpStatusCode.OK)
                }

                delete("/{id}") {
                    val id = call.parameters["id"]?.toLongOrNull()
                    if (id == null) { call.respond(HttpStatusCode.BadRequest); return@delete }
                    val repo = UserRepository()
                    repo.softDelete(id)
                    call.respond(HttpStatusCode.OK)
                }

                // 管理员分页列出（演示：未做角色校验，实际需判断 role == admin）
                get {
                    val limit = call.request.queryParameters["limit"]?.toLongOrNull() ?: 20
                    val offset = call.request.queryParameters["offset"]?.toLongOrNull() ?: 0
                    val repo = UserRepository()
                    val list = repo.paged(limit, offset).map { it.toProfile() }
                    call.respond(list)
                }
            }
        }
    }
}
