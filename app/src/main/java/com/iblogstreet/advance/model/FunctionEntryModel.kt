package com.iblogstreet.advance.model

/**
 * @author junwang
 * @date 2024/07/25 0:04
 */
class FunctionEntryModel(
   val entryType: EntryType,
   val title: String? = null
)

enum class EntryType {
    LOGIN,
    PHOTO
}