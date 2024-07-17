package com.iblogstreet.photo.exposeimpl

import android.content.Context
import com.iblogstreet.photo.PhotoMainActivity
import com.iblogstreet.photo.expose.PhotoExpose
import javax.inject.Inject

/**
 * @author junwang
 * @date 2024/07/15 23:57
 */
class PhotoExposeImpl @Inject constructor() : PhotoExpose {
    override fun startPhotoActivity(context: Context) {
        PhotoMainActivity.start(context)
    }
}