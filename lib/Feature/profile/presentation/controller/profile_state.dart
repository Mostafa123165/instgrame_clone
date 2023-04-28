
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ChangeIconState extends ProfileState {}

class PicImageFromGallerySuccessState extends ProfileState {}

class PicImageFromGalleryLoadingState extends ProfileState {}

class PicImageFromGalleryErrorState extends ProfileState {
  final String message ;

  PicImageFromGalleryErrorState(this.message);
}

class GetEditProfileDataSuccessState extends ProfileState {}

class UpdateEditProfileDateLoadingState extends ProfileState {}

class UpdateEditProfileDateSuccessState extends ProfileState {}

class UpdateEditProfileDateErrorState extends ProfileState {
  final String message ;

  UpdateEditProfileDateErrorState(this.message);
}

class ClearDateUserSuccessState extends ProfileState {}
