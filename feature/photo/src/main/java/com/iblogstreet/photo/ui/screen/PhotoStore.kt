package com.iblogstreet.photo.ui.screen

import android.graphics.drawable.ColorDrawable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.toArgb

/**
 * @author junwang
 * @date 2024/07/19 22:26
 */
object PhotoStore {
    val photos: List<Photo> by lazy {
        val photos = mutableListOf<Photo>()

        photos.add(Photo(ColorDrawable(Color.Red.toArgb())))
        photos.add(Photo(ColorDrawable(Color.Blue.toArgb())))
        photos.add(Photo(ColorDrawable(Color.Gray.toArgb())))
        photos.add(Photo(ColorDrawable(Color.Black.toArgb())))
        photos.add(Photo(ColorDrawable(Color.Magenta.toArgb())))

        photos
    }
}