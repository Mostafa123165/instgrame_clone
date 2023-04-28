import 'package:flutter/material.dart';
import 'package:instgrameclone/Feature/Authorization/presentation/views/widgets/login_body_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
              child: LoginBodyWidget()
          ),
        ),
      ),
    );
  }
}
