

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instgrameclone/Feature/Authorization/presentation/controller/Register/register_state.dart';
import 'package:instgrameclone/core/uttils/components.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterBlocInitial());

  static RegisterCubit get(context) => BlocProvider.of(context) ;

  final RoundedLoadingButtonController registerController = RoundedLoadingButtonController();
  final _firebase = FirebaseAuth.instance ;
  final _firebaseFireStore = FirebaseFirestore.instance ;

  bool statePassword = true ;
  void changeStatePassword() {
    statePassword = !statePassword ;
    emit(ChangeStatePasswordState());
  }

  Future registerWithEmailAndPassword({
  required String email,
  required String password,
  required String name,
  required String phone,
  required context
}) async {
    emit(RegisterLoadingState()) ;

    await _firebase.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) async {
     await addUsers(name: name ,phone: phone ,email: email ,uId: value.user!.uid , verifiedEmail: false).then((value) {
     registerController.success();
    showToast(context: context , error: 'تم انشاء الحساب بنجاح' ,toastStates: ToastStates.SUCCESS ) ;
    registerController.reset() ;
    emit(RegisterLoadingState()) ;
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      Navigator.of(context).pop();
    });
     }).catchError((e) {
       registerController.error() ;
       showToast(context: context , error: e.toString() ,toastStates: ToastStates.ERROR ) ;
       emit(RegisterErrorState(message: e.toString()));
       registerController.reset();
       emit(RegisterLoadingState()) ;
     }) ;
   }).catchError((e) {
      registerController.error() ;
      showToast(context: context , error: e.toString() ,toastStates: ToastStates.ERROR ) ;
      emit(RegisterErrorState(message: e.toString()));
      registerController.reset();
      emit(RegisterLoadingState()) ;

    });
  }

  void showToast({required ToastStates toastStates , required context , required String error}) {
    Components().showToast(
        message: error,
        context: context,
        toastState: toastStates);
  }

  Future addUsers({
    required String email,
    required String uId,
    required String name,
    required String phone,
    required bool verifiedEmail ,
}) async {
    _firebaseFireStore.collection('users').doc(uId).set(
      {
        "email": email,
        "name": name,
        "phone": phone,
        "uID" : uId ,
        "verify" : verifiedEmail ,
        "followers" :[],
        "following" :[],
        "posts" :[],
        "stories" :[],
        "cover":"https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/694px-Unknown_person.jpg",
        "image":"https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/694px-Unknown_person.jpg",
        "bio":"write you bio ...",
        "bottom": true ,
      },
    );}
}
