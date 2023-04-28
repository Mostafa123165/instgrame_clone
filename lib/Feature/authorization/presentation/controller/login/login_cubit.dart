import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:instgrameclone/Feature/Authorization/data/entities.dart';
import 'package:instgrameclone/Feature/Authorization/data/model/user_model.dart';
import 'package:instgrameclone/Feature/Authorization/presentation/controller/login/login_state.dart';
import 'package:instgrameclone/core/data_app/user.dart';
import 'package:instgrameclone/core/local_data_base/cash_helper.dart';
import 'package:instgrameclone/core/uttils/constants.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool statePassword = true ;
  void changeStatePassword() {
    statePassword = !statePassword ;
    emit(ChangeStatePasswordState());
  }


  final FirebaseAuth _firebase = FirebaseAuth.instance;

  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  final _firebaseFireStore = FirebaseFirestore.instance;

  final RoundedLoadingButtonController loginController =
      RoundedLoadingButtonController();

  Future signWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      final UserCredential userCredential = await _firebase.signInWithEmailAndPassword(email: email, password: password);
      await afterSuccessLogin(null,fromEmailAndPassword: true,userId: userCredential.user!.uid.toString(),);
      loginController.success();
      emit(LoginSuccessState());
      loginController.reset();
    } on FirebaseAuthException catch (e) {
      loginController.error();
      emit(LoginErrorState(message: _determineLoginError(e)));
      loginController.reset();
    }
  }

  String _determineLoginError(FirebaseAuthException e) {
    if (e.code == 'user-not-found') {
      return 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      return 'Wrong password provided for that user.';
    } else if (e.code == 'invalid-email') {
      return 'Wrong password provided for that user.';
    }
    return 'Sorry , found Error...please login in another time.';
  }

  Future signWithFacebook() async {
    LoginResult loginResult = await _facebookAuth.login(permissions: ['email', 'public_profile']);

    if (loginResult.status == LoginStatus.success) {
      final accessToken = loginResult.accessToken!.token;

      final faceCredential = FacebookAuthProvider.credential(accessToken);
      await _firebase.signInWithCredential(faceCredential).then((value) async {
        await afterSuccessLogin(value);
        emit(LoginSuccessState());
      }).catchError((e) {
        emit(LoginErrorState(message: _determineLoginError(e)));
      });
    } else if (loginResult.status == LoginStatus.failed) {
      emit(LoginErrorState(message: 'Problem occurred,please try again later'));
    }
  }

  Future addUsers({
    required String email,
    required String uId,
    required String name,
    required String phone,
    required String image,
    required bool verifiedEmail,
  }) async {
    _firebaseFireStore.collection('users').doc(uId).set(
      {
        "email": email,
        "name": name,
        "phone": phone,
        "uID": uId,
        "verify": verifiedEmail,
        "followers": [],
        "following": [],
        "stories": [],
        "posts": [],
        "cover": "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/694px-Unknown_person.jpg",
        "image": image,
        "bio": "write you bio ...",
        "bottom": true ,
      },
    );
  }

  Future afterSuccessLogin(var value, {bool fromEmailAndPassword = false ,  String userId = ''}) async {
    if(fromEmailAndPassword) {
      UserResult.data = await getDateUserFromStorage(userId: userId) ;
      saveInLocalDatabase(
          userEntities: UserEntities(
              token:UserResult.data!.token.toString(),
              image:UserResult.data!.image.toString(),
              bio: 'write your bio...',
              cover: AppConstants.image,
              email:UserResult.data!.email.toString(),
              name:UserResult.data!.name.toString(),
              phone:UserResult.data!.phone.toString(),
              verify: true));
    }
    else {
      UserResult.data = UserEntities(
          token: value.user!.uid.toString(),
          image: value.user!.photoURL.toString(),
          bio: 'write your bio...',
          cover: AppConstants.image,
          email: value.user!.email.toString(),
          name: value.user!.displayName.toString(),
          phone: value.user!.phoneNumber.toString(),
          verify: true);
      await addUsers(
          email: value.user!.email.toString(),
          uId: value.user!.uid.toString(),
          name: value.user!.displayName.toString(),
          phone: value.user!.phoneNumber.toString(),
          verifiedEmail: true,
          image: value.user!.photoURL.toString());
      saveInLocalDatabase(
          userEntities: UserEntities(
              token: value.user!.uid.toString(),
              image: value.user!.photoURL.toString(),
              bio: 'write your bio...',
              cover: AppConstants.image,
              email: value.user!.email.toString(),
              name: value.user!.displayName.toString(),
              phone: value.user!.phoneNumber.toString(),
              verify: true));
    }

  }

  Future saveInLocalDatabase({required UserEntities userEntities}) async {
    await CashHelper.saveData(key: 'name', value: userEntities.name);
    await CashHelper.saveData(key: 'email', value: userEntities.email);
    await CashHelper.saveData(key: 'phone', value: userEntities.phone);
    await CashHelper.saveData(key: 'token', value: userEntities.token);
    await CashHelper.saveData(key: 'cover', value: userEntities.cover);
    await CashHelper.saveData(key: 'image', value: userEntities.image);
    await CashHelper.saveData(key: 'bio', value: userEntities.bio);
    await CashHelper.saveData(key: 'verify', value: userEntities.verify);
  }

  Future<UserEntities?> getDateUserFromStorage({required String userId }) async{
    UserEntities? userEntities ;
    await _firebaseFireStore.collection('users').doc(userId).get().then((value) => {
      print(value.data()),
      userEntities = UserModel.fromJson(value.data() ?? {}),
    });

    return userEntities ;

  }
}
