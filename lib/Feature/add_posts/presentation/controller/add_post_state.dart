
abstract class AddPostState {}

class AddPostInitial extends AddPostState {}

class GetGallerySuccessState extends AddPostState {}

class GetLoadAssetsSuccessState extends AddPostState {}

class AddImageFromOnLongPressSuccessState extends AddPostState {}

class AddImageFromOnTapSuccessState extends AddPostState {}

class RemoveAddPostsSuccessState extends AddPostState {}

class UpdateIndexImageChoiceInAssetsImageState extends AddPostState {}

class UploadImageSuccessState extends AddPostState {}

class UploadImageErrorState extends AddPostState {}

class AddPostSuccessState extends AddPostState {}

class AddPostErrorState extends AddPostState {}

class AddPostLoadingState extends AddPostState {}

class ChangeIsLikeAnimatingState extends AddPostState {}

class ClearState extends AddPostState {}
