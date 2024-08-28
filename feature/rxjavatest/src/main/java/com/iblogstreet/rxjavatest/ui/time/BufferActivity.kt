//
//
//package com.iblogstreet.rxjavatest.ui.time
//
//import android.os.Bundle
//import androidx.appcompat.app.AppCompatActivity
//import io.reactivex.rxjava3.disposables.CompositeDisposable
//
//class BufferActivity : AppCompatActivity() {
//  private val disposables = CompositeDisposable()
//
//  override fun onCreate(savedInstanceState: Bundle?) {
//    super.onCreate(savedInstanceState)
//    setContentView(R.layout.activity_buffer)
//  }
//
//  override fun onDestroy() {
//    super.onDestroy()
//    disposables.dispose()
//  }
//}
