package com.iblogstreet.advance.util

import com.iblogstreet.advance.model.EntryType
import com.iblogstreet.advance.model.FunctionEntryModel

/**
 * @author junwang
 * @date 2024/07/24 23:52
 */
class data_util {
    companion object {
        val photos = mutableListOf<String>("1", "2", "3", "4", "5", "1", "2", "3", "4", "5")
        val entryTypeList = mutableListOf<FunctionEntryModel>(
            FunctionEntryModel(entryType = EntryType.PHOTO, title = "photo"),
            FunctionEntryModel(entryType = EntryType.LOGIN, title = "login")
        )
    }
}