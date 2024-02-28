import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/user_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value)
     {
       print(value.user!.uid);
       print(value.user!.email);
       userCreate(name: name,
           email: email,
           password: password,
           confirmPassword: confirmPassword,
           uId: value.user!.uid,
       );
        }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    });
  }


  void userCreate({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String uId,
})
  {
    UserModel userModel = UserModel(
      name: name,
      email: email,
      uId: uId
  );
    FirebaseFirestore.instance.collection("Users")
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
          emit(CreateUserSuccessState());
    })
        .catchError((error){
          CreateUserErrorState(error.toString());
    });
  }

  void userCreateWithPhone({
    required String name,
    required String email,
    required String password,
    required String uId,
    required int age,
    String? phoneNumber
})
  {
    UserModel userModel = UserModel(
      name: name,
      phoneNumber: phoneNumber,
      email: email,
      uId: uId
  );
    FirebaseFirestore.instance.collection("Users")
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
          emit(CreateUserSuccessState());
    })
        .catchError((error){
          CreateUserErrorState(error.toString());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }


}
