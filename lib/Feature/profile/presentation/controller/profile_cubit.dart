
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instgrameclone/Feature/Authorization/presentation/views/login_screen.dart';
import 'package:instgrameclone/Feature/profile/presentation/controller/profile_state.dart';
import 'package:instgrameclone/core/data_app/user.dart';
import 'package:instgrameclone/core/local_data_base/cash_helper.dart';
import 'package:instgrameclone/core/uttils/components.dart';
import 'package:page_transition/page_transition.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context) ;

  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  ScrollController profileController = ScrollController();
  bool showTextFollow = false ;
  void listenController({required double heightScreenWithPixel}) {
    profileController.addListener(() {
      if(profileController.position.pixels > heightScreenWithPixel / 3) {
        showTextFollow = true ;
      }
      else {
        showTextFollow = false ;
      }
    });
  }
  
  bool stateAddStoryBottom = false ;
  void changeAddStoryBottomState() {
    stateAddStoryBottom = !stateAddStoryBottom ;
    emit(ChangeIconState());
  }

  String picImage = '';
  Future<void> pickImageFromDevice({bool fromEditProfile = false}) async{
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(xFile != null ) {
      emit(PicImageFromGalleryLoadingState()) ;
      try {
        Reference ref = storage.ref().child('Images').child('PicUrlImages/${Uri.file(xFile.path).pathSegments.last}');
        UploadTask uploadTask = ref.putData(await xFile.readAsBytes());
        TaskSnapshot snap = await uploadTask;
        !fromEditProfile == true ? picImage = await snap.ref.getDownloadURL() : profileImage = await snap.ref.getDownloadURL() ;
        if(!fromEditProfile) await addPicImageInStories();
        emit(PicImageFromGallerySuccessState()) ;
      }catch (e) {
        emit(PicImageFromGalleryErrorState(e.toString())) ;
      }
    }

  }

  Future<void> addPicImageInStories() async{

    await fireStore.collection('users').doc(UserResult.data!.token).update({
      "stories" : FieldValue.arrayUnion([picImage]) ,
    });
  }


  var nameController = TextEditingController() ;
  var bioController = TextEditingController() ;
  var emailController = TextEditingController() ;
  var phoneController = TextEditingController() ;
  String? profileImage ;
  void getEditProfilesDate() {
    nameController = TextEditingController(text: UserResult.data!.name) ;
    bioController = TextEditingController(text: UserResult.data!.bio) ;
    emailController = TextEditingController(text: UserResult.data!.email) ;
    phoneController = TextEditingController(text: UserResult.data!.phone) ;
    emit(GetEditProfileDataSuccessState()) ;
  }

  Future<void> updateUserData() async{
    emit(UpdateEditProfileDateLoadingState());

    try {
      await fireStore.collection('users').doc(UserResult.data!.token).update({
        "name"  :   nameController.text ,
        "phone" :   phoneController.text ,
        "email" :   emailController.text ,
        "bio"   :   bioController.text ,
        "image" :   profileImage??UserResult.data!.image,
      });
      changeDateProfileInLocalVariable();
      await saveProfileDateInLocalDataBase();
      emit(UpdateEditProfileDateSuccessState());
    }
    catch (e){
      print(e.toString()) ;
      emit(UpdateEditProfileDateErrorState(e.toString()));
    }
  }

  void changeDateProfileInLocalVariable() {
    UserResult.data!.bio = bioController.text ;
    UserResult.data!.name = nameController.text ;
    UserResult.data!.email = emailController.text ;
    UserResult.data!.phone = phoneController.text ;
    UserResult.data!.image = profileImage??UserResult.data!.image ;
  }

  Future<void> saveProfileDateInLocalDataBase() async {
    await CashHelper.saveData(key: 'name', value: nameController.text) ;
    await CashHelper.saveData(key: 'phone', value: phoneController.text) ;
    await CashHelper.saveData(key: 'email', value: emailController.text) ;
    await CashHelper.saveData(key: 'bio', value: bioController.text) ;
    await CashHelper.saveData(key: 'image', value: profileImage??UserResult.data!.image,) ;
  }

  Future<void> signOut(context) async{
    UserResult.data = null ;
    UserResult.hasError = null ;
    CashHelper.clearAllDate();
    emit(ClearDateUserSuccessState());
    Navigator.pushAndRemoveUntil(context, PageTransition(child: const LoginScreen(),type: PageTransitionType.fade) , (route) => false);
  }

  void changeBottomState(var snap) async{
    await FirebaseFirestore.instance.collection('users').doc(UserResult.data!.token).update({
      "bottom" : !snap['bottom'] ,
    });
  }


}
