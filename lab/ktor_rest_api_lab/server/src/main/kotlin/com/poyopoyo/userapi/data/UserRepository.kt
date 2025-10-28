package com.poyopoyo.userapi.data

import com.poyopoyo.userapi.db.AppDatabase
import com.poyopoyo.userapi.plugins.DBHolder
import databases.Users

data class UserEntity(
    val id: Long,
    val username: String,
    val email: String,
    val passwordHash: String,
    val role: String,
    val status: String,
    val displayName: String?,
    val avatarUrl: String?
)

class UserRepository(
    private val db: AppDatabase = DBHolder.db
) {
    private val q get() = db.userQueries

    fun findByUsernameOrEmail(key: String): Users? =
        q.selectByUsernameOrEmail(key, key).executeAsOneOrNull()

    fun findById(id: Long): Users? =
        q.selectById(id).executeAsOneOrNull()

    fun create(
        username: String,
        email: String,
        passwordHash: String,
        role: String? = "user",
        status: String? = "active",
        displayName: String? = null,
        avatarUrl: String? = null
    ): Long {
        q.insertUser(username, email, passwordHash, role, status, displayName, avatarUrl)
        return q.selectByUsername(username).executeAsOne().id
    }

    fun updateProfile(id: Long, displayName: String?, avatarUrl: String?) {
        q.updateProfile(displayName, avatarUrl, id)
    }

    fun updatePassword(id: Long, passwordHash: String) {
        q.updatePassword(passwordHash, id)
    }

    fun softDelete(id: Long) {
        q.softDelete(id)
    }

    fun paged(limit: Long, offset: Long) =
        q.pagedList(limit, offset).executeAsList()
}
