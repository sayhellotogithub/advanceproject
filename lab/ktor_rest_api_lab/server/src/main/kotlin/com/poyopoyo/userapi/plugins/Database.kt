package com.poyopoyo.userapi.plugins

import app.cash.sqldelight.driver.jdbc.sqlite.JdbcSqliteDriver
import com.poyopoyo.userapi.db.AppDatabase
import io.ktor.server.application.Application

object DBHolder {
    lateinit var db: AppDatabase
}

fun Application.configureDatabase() {
    val cfg = environment.config.config("ktor.database")
    val url = cfg.property("jdbcUrl").getString()
    val driver = JdbcSqliteDriver(url)
    DBHolder.db = AppDatabase(driver)
}