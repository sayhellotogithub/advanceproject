package com.iblogstreet.photo.ui.screen

import android.content.Context
import android.graphics.Bitmap
import android.graphics.drawable.BitmapDrawable
import android.util.Log
import android.widget.ImageView
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.core.Single
import io.reactivex.rxjava3.disposables.CompositeDisposable
import io.reactivex.rxjava3.kotlin.addTo
import io.reactivex.rxjava3.subjects.BehaviorSubject
import java.io.File
import java.io.FileOutputStream
import java.io.IOException
import java.io.OutputStream

/**
 * @author junwang
 * @date 2024/07/19 22:35
 */
class SharedViewModel : ViewModel() {

    private val selectedPhotos = MutableLiveData<List<Photo>>()
    private val disposables = CompositeDisposable()
    private val imagesSubject: BehaviorSubject<MutableList<Photo>>
            = BehaviorSubject.createDefault(mutableListOf())

    init {
        imagesSubject.subscribe { photos ->
            selectedPhotos.value = photos
        }.addTo(disposables)
    }

    override fun onCleared() {
        disposables.dispose()

        super.onCleared()
    }

    fun getSelectedPhotos(): LiveData<List<Photo>> {
        return selectedPhotos
    }

    fun subscribeSelectedPhotos(selectedPhotos: Observable<Photo>) {
        selectedPhotos
            .doOnComplete {

                Log.v("SharedViewModel", "Completed selecting photos")
            }
            .subscribe { photo ->
                imagesSubject.value?.add(photo)
                imagesSubject.onNext(imagesSubject.value ?: mutableListOf())
            }
            .addTo(disposables)
    }

    fun clearPhotos() {
        imagesSubject.value?.clear()
        imagesSubject.onNext(imagesSubject.value!!)
    }

    fun saveBitmapFromImageView(imageView: ImageView, context: Context): Single<String> {
        return Single.create { observer ->
            val tmpImg = "${System.currentTimeMillis()}.png"

            val os: OutputStream?

            val collagesDirectory = File(context.getExternalFilesDir(null), "collages")
            if (!collagesDirectory.exists()) {
                collagesDirectory.mkdirs()
            }

            val file = File(collagesDirectory, tmpImg)

            try {
                os = FileOutputStream(file)
                val bitmap = (imageView.drawable as BitmapDrawable).bitmap
                bitmap.compress(Bitmap.CompressFormat.PNG, 100, os)
                os.flush()
                os.close()
                observer.onSuccess(tmpImg)
            } catch (e: IOException) {
                observer.onError(e)
            }
        }
    }
}