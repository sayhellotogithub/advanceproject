

package com.iblogstreet.rxjavatest.ui.time.utils

import android.content.Context
import android.util.TypedValue



fun Float.toPx(context: Context): Int {
  val displaymetrics = context.resources.displayMetrics
  return TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, this, displaymetrics).toInt()
}
