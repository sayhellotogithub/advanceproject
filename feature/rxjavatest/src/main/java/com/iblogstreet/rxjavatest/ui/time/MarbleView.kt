/*
 * Copyright (c) 2020 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package com.iblogstreet.rxjavatest.ui.time

import android.content.Context
import android.content.res.Resources
import android.graphics.Color
import android.os.Handler
import androidx.core.content.ContextCompat
import android.util.AttributeSet
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.widget.FrameLayout
import android.widget.LinearLayout
import android.widget.TextView
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.iblogstreet.designsystem.theme.secondaryContainerLight
import com.iblogstreet.rxjavatest.R
import com.iblogstreet.rxjavatest.ui.time.utils.toPx
import io.reactivex.rxjava3.core.Observer
import io.reactivex.rxjava3.disposables.Disposable
import java.util.*

@Composable
fun MarbleView(title: String):Observer<Any> {
    Column {
        Text(
            title,
            fontSize = 14.sp,
            modifier = Modifier.padding(16.dp),
            fontWeight = FontWeight.Bold
        )
        Box(modifier = Modifier.fillMaxWidth())


    }
}

class MarbleView @JvmOverloads constructor(
    context: Context,
    attributeSet: AttributeSet? = null,
    defStyleAttr: Int = 0
) : LinearLayout(context, attributeSet, defStyleAttr), Observer<Any> {

    private val itemWidth by lazy { 30f.toPx(context) }
    private var hasStartedAnimation = false

    private var lastAddedDate = Date()
    private var lastAddedLayout: LinearLayout? = null


    override fun onComplete() {
        onNext("C")
    }

    override fun onSubscribe(d: Disposable) {

    }

    override fun onNext(item: Any) {
        addItem(item)
        startAnimation()
    }

    override fun onError(e: Throwable) {
        onNext("E")
    }

    private fun startAnimation() {
        if (hasStartedAnimation) return
        hasStartedAnimation = true
        post {
            val handler = Handler()
            val runnable = object : Runnable {
                override fun run() {
                    post {
                        val childrenToRemove = mutableListOf<View>()
                        for (i in 0 until marbles.childCount) {
                            val child = marbles.getChildAt(i)
                            marbles.getChildAt(i).translationX = child.translationX - 3
                            if (child.translationX <= -1 * width) {
                                childrenToRemove.add(child)
                            }
                        }
                        childrenToRemove.forEach { marbles.removeView(it) }
                    }
                    handler.postDelayed(this, 25)
                }
            }
            handler.post(runnable)
        }
    }

    private fun addItem(item: Any) {
        post {
            val textView = buildTextView(item)
            val now = Date()
            val layout = if (now.time - 10 <= lastAddedDate.time && lastAddedLayout != null) {
                lastAddedLayout
            } else {
                val layout = buildTextViewContainer()
                marbles.addView(layout)
                lastAddedLayout = layout
                lastAddedDate = now
                layout
            }
            layout?.addView(textView)
        }
    }

    private fun buildTextViewContainer() =
        LinearLayout(context).apply {
            orientation = LinearLayout.VERTICAL
            layoutParams =
                FrameLayout.LayoutParams(LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT)
            x = this@MarbleView.width - itemWidth.toFloat()
        }

    private fun buildTextView(item: Any) =
        TextView(context).apply {
            text = item.toString()
            layoutParams = LinearLayout.LayoutParams(itemWidth, LayoutParams.WRAP_CONTENT)
            gravity = Gravity.CENTER
            setTextColor(Color.WHITE)
            setBackgroundColor(secondaryContainerLight.toArgb())
            textSize = 8f.toPx(context).toFloat()
        }
}
