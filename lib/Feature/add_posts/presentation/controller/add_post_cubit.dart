import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgrameclone/Feature/add_posts/data/model/Information_about_image_in_post.dart';
import 'package:instgrameclone/Feature/add_posts/data/model/post_info.dart';
import 'package:instgrameclone/Feature/add_posts/presentation/controller/add_post_state.dart';
import 'package:instgrameclone/Feature/profile/presentation/views/profile_view.dart';
import 'package:instgrameclone/core/data_app/user.dart';
import 'package:instgrameclone/core/uttils/components.dart';
import 'package:instgrameclone/core/widgets/toast_widget.dart';
import 'package:photo_manager/photo_manager.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitial());

  static AddPostCubit get(context) => BlocProvider.of(context);

  FirebaseStorage storage = FirebaseStorage.instance;

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  AssetPathEntity? _path;

  List<InformationAboutImageInPost> imagesInAssets = [];

  List<InformationAboutChoiceImageInPost> choiceImages = [];

  List<File> imagesAsFile = [];

  int _page = 0;
  final int _sizePerPage = 30;

  Future<void> getAllImageInGallery() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!ps.hasAccess) {
    } else {
      final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.image,
      );
      _path = paths.first;
      final List<AssetEntity> entities = await _path!.getAssetListPaged(
        page: _page,
        size: _sizePerPage,
      );
      for (int i = 0; i < entities.length; i++) {
        final File? file = await entities[i].file;
        String res =
            file.toString().substring(7, file.toString().length - 1).toString();
        imagesAsFile.add(file!);
        imagesInAssets.add(InformationAboutImageInPost(
            file: res, choice: false, numOfChoice: 0, indexInListChoice: 0));
      }

      emit(GetGallerySuccessState());
    }
  }

  Future<void> loadMoreAsset() async {
    _page = _page + 1;
    final List<AssetEntity> entities =
        await _path!.getAssetListPaged(page: _page, size: _sizePerPage);
    for (int i = 0; i < entities.length; i++) {
      final File? file = await entities[i].file;
      String res =
          file.toString().substring(7, file.toString().length - 1).toString();
      imagesInAssets.add(InformationAboutImageInPost(
          file: res, choice: false, numOfChoice: 0, indexInListChoice: 0));
      imagesAsFile.add(file!);
    }
    emit(GetLoadAssetsSuccessState());
  }


  void clear() {
    for (int i = 0; i < choiceImages.length; i++) {
      imagesInAssets[choiceImages[i].indexInAssets].choice = false;
    }
    choiceImages.clear() ;
    longPress = false ;
    emit(ClearState());
  }

  bool longPress = false;
  bool isLikeAnimating = false ;
  String idPost = '' ;
  void changeIsLikeAnimating({required bool state , required String idPost}) {
    isLikeAnimating = state ;
    this.idPost = idPost;
    emit(ChangeIsLikeAnimatingState());
  }

  void onLongPress({required int index, required context}) {
    if (!longPress) {
      for (int i = 0; i < choiceImages.length; i++) {
        imagesInAssets[choiceImages[i].indexInAssets].choice = false;
      }
      choiceImages.clear();
      print(choiceImages.length);
    }
    longPress = true;
    if (choiceImages.length < 10) {
      choiceImages.add(InformationAboutChoiceImageInPost(
          file: imagesInAssets[index].file, indexInAssets: index));
      imagesInAssets[index].numOfChoice = choiceImages.length;
      imagesInAssets[index].choice = true;
    } else {
      showToastWidget(
          message: 'The limit is 10 photos or videos',
          context: context,
          toastState: ToastStates.ERROR);
    }
    emit(AddImageFromOnLongPressSuccessState());
  }

  void onTap({required int index, required context}) {
    if (choiceImages.length < 10 || imagesInAssets[index].choice) {
      if (longPress) {
        if (imagesInAssets[index].choice) {
          imagesInAssets[index].choice = false;
          choiceImages.removeAt(imagesInAssets[index].indexInListChoice);
          updateIndexImageChoiceInAssetsImage();
        } else {
          choiceImages.add(InformationAboutChoiceImageInPost(
              file: imagesInAssets[index].file, indexInAssets: index));
          imagesInAssets[index].indexInListChoice = choiceImages.length - 1;
          imagesInAssets[index].choice = true;
        }
      } else {
        for (int i = 0; i < choiceImages.length; i++) {
          imagesInAssets[choiceImages[i].indexInAssets].choice = false;
        }
        choiceImages.clear();
        imagesInAssets[index].choice = !imagesInAssets[index].choice;
        choiceImages.add(InformationAboutChoiceImageInPost(
            file: imagesInAssets[index].file, indexInAssets: index));
      }
    } else {
      showToastWidget(
          message: 'The limit is 10 photos or videos',
          context: context,
          toastState: ToastStates.ERROR);
    }
    emit(AddImageFromOnTapSuccessState());
  }

  void updateIndexImageChoiceInAssetsImage() {
    for (int index = 0; index < choiceImages.length; index++) {
      imagesInAssets[choiceImages[index].indexInAssets].indexInListChoice =
          index;
    }
    emit(UpdateIndexImageChoiceInAssetsImageState());
  }

  void remove() {
    imagesInAssets.clear();
    _page = 0;
    longPress = false;
    choiceImages.clear();
    emit(RemoveAddPostsSuccessState());
  }

  void uploadPost({required String description}) async {
    emit(AddPostLoadingState());
    List<String> urlImages = [];
    for (int i = 0; i < choiceImages.length; i++) {
      print(choiceImages[i].indexInAssets);
      String urlImage = await uploadImage(file: imagesAsFile[choiceImages[i].indexInAssets]);
      urlImages.add(urlImage);
    }
    DocumentReference<Map<String, dynamic>> res = await fireStore.collection('posts').add(PostInfo.toMap(PostInfo(
        description: description,
        images: urlImages,
        uIdPostOwner: UserResult.data!.token,
        uIdPost: '',
        likes: [] ,
        comments: [],
        ownerUId: UserResult.data!.token,
        ownerName: UserResult.data!.name,
        dataTime: DateTime.now().toString())));
    await fireStore.collection('users').doc(UserResult.data!.token).update({
      "posts" : FieldValue.arrayUnion([{"image":urlImages[0]},{"postId" : res.id}]),
    },);
    emit(AddPostSuccessState());
  }

  Future<String> uploadImage({required File file}) async {
    Reference ref = storage
        .ref()
        .child('Images')
        .child('images_posts/${Uri.file(file.path).pathSegments.last}');
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snap = await uploadTask;
    return snap.ref.getDownloadURL();
  }

  Future<String> likePost({required String postId,required String userUid,required List likes , bool fromOnTapDouble = false }) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(userUid) && !fromOnTapDouble) {
        // if the likes list contains the user userUid, we need to remove it
        await fireStore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([userUid])
        });
      } else {
        // else we need to add userUid to the likes array
        await fireStore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([userUid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> addOrRemoveFollow({required List following, required String ownerPostId , required String postId}) async{
    idPost = postId ;
    if(following.contains(ownerPostId)) {
      await fireStore.collection('users').doc(ownerPostId).update({
        'followers' : FieldValue.arrayRemove([UserResult.data!.token]),
      });
      await fireStore.collection('users').doc(UserResult.data!.token).update({
        'following' : FieldValue.arrayRemove([ownerPostId]),
      });
    }
    else {
      await fireStore.collection('users').doc(ownerPostId).update({
        'followers' : FieldValue.arrayUnion([UserResult.data!.token]),
      });
      await fireStore.collection('users').doc(UserResult.data!.token).update({
        'following' : FieldValue.arrayUnion([ownerPostId]),
      });

    }
    emit(ChangeIsLikeAnimatingState());
  }

}
