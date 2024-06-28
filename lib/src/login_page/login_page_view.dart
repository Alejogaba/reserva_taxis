import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

import '../../constants.dart';
import '../../generated/l10n.dart';

import '../home_page/home_page_view.dart';

import 'package:permission_handler/permission_handler.dart';


class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscureText = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.16),
              titleWidget(),
              const SizedBox(height: 60),
              subtitleWidget(),
              emailInputWidget(),
              passwordInputWidget(),
              loginButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 90),
          child: Text(
            S.current.taxiTitle,
            style: const TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: textColor,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.local_taxi,
              size: 42,
              color: primaryColor,
            ),
            const SizedBox(width: 4),
            Text(
              S.current.managementTitle,
              style: const TextStyle(
                fontSize: 37,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                color: textColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget subtitleWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
      child: Text(
        S.current.loginSubtitle,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: textColor,
        ),
      ),
    );
  }

  Widget emailInputWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
      child: TextFormField(
        controller: emailController,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        maxLength: 50,
        decoration: InputDecoration(
          hintText: S.current.emailHintText,
          hintStyle: const TextStyle(color: hintTextColor),
          prefixIcon: const Icon(Icons.email, color: primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: inputBorderLineColor,
              width: 1.0,
            ),
          ),
          filled: true,
          fillColor: inputFillColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          counterText: '',
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return S.current.emptyFieldError;
          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return S.current.validEmailError;
          }
          return null;
        },
      ),
    );
  }

  Widget passwordInputWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 25, 40),
      child: TextFormField(
        controller: passwordController,
        obscureText: obscureText,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        maxLength: 50,
        decoration: InputDecoration(
          hintText: S.current.passwordHintText,
          hintStyle: const TextStyle(color: hintTextColor),
          prefixIcon: const Icon(Icons.lock, color: primaryColor),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: primaryColor,
            ),
            onPressed: _togglePasswordVisibility,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: inputBorderLineColor,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: inputFillColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          counterText: '',
        ),
        
        validator: (value) {
          if (value == null || value.isEmpty) {
            return S.current.emptyFieldError;
          } else if (value.length < 6) {
            return S.current.shortPasswordError;
          }
          return null;
        },
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  Widget loginButtonWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            Get.to(() => const HomePageView());
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: primaryColor,
          backgroundColor: btnPrimaryBackgroundColor,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          S.current.loginButtonText,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
