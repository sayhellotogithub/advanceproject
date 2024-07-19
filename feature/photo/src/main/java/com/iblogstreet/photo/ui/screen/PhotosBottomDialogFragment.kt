//package com.iblogstreet.photo.ui.screen
//
//import android.view.LayoutInflater
//import io.reactivex.rxjava3.core.Observable
//import io.reactivex.rxjava3.subjects.PublishSubject
//
///**
// * @author junwang
// * @date 2024/07/19 22:34
// */
//class PhotosBottomDialogFragment : BottomSheetDialogFragment(), PhotosAdapter.PhotoListener {
//
//    private lateinit var viewModel: SharedViewModel
//
//    private val selectedPhotosSubject = PublishSubject.create<Photo>()
//
//    val selectedPhotos: Observable<Photo> = selectedPhotosSubject.hide()
//
//    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
//        return inflater.inflate(R.layout.layout_photo_bottom_sheet, container, false)
//    }
//
//    override fun onActivityCreated(savedInstanceState: Bundle?) {
//        super.onActivityCreated(savedInstanceState)
//
//        val ctx = activity
//        ctx?.let {
//            viewModel = ViewModelProvider(ctx).get(SharedViewModel::class.java)
//        }
//    }
//
//    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
//        super.onViewCreated(view, savedInstanceState)
//
//        photosRecyclerView.layoutManager = GridLayoutManager(context, 3)
//        photosRecyclerView.adapter = PhotosAdapter(PhotoStore.photos, this)
//    }
//
//    override fun onDestroyView() {
//        selectedPhotosSubject.onComplete()
//        super.onDestroyView()
//    }
//
//    override fun photoClicked(photo: Photo) {
//        selectedPhotosSubject.onNext(photo)
//    }
//
//    companion object {
//        const val TAG = "PhotosBottomDialogFragment"
//        fun newInstance(): PhotosBottomDialogFragment {
//            return PhotosBottomDialogFragment()
//        }
//    }
//}