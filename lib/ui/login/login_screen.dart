import 'package:evently_c13_online/core/assets/app_assets.dart';
import 'package:evently_c13_online/firebase_helpers/firestore/firestore_helper.dart';
import 'package:evently_c13_online/model/user_dm.dart';
import 'package:evently_c13_online/ui/home_screen/home_screen.dart';
import 'package:evently_c13_online/ui/shared_widgets/custom_button.dart';
import 'package:evently_c13_online/ui/shared_widgets/language_switch.dart';
import 'package:evently_c13_online/ui/signup_screen/signup_screen.dart';
import 'package:evently_c13_online/ui/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/loginScreen";

  LoginScreen({super.key});

  late AppLocalizations appLocalizations;

  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Image.asset(
                AppAssets.appVerticalLogoImage,
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              buildEmailTextField(context),
              const SizedBox(height: 16),
              buildPasswordTextField(context),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(appLocalizations.forgetPassword),
                  )
                ],
              ),
              const SizedBox(height: 16),
              buildLoginButton(context),
              const SizedBox(height: 16),
              buildSignUpRow(context),
              const SizedBox(height: 16),
              buildORText(context),
              const SizedBox(height: 16),
              buildGoogleSignInButton(context),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LanguageSwitch(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPasswordTextField(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyLarge,
      cursorColor: Theme.of(context).primaryColor,
      controller: passwordController,
      decoration: InputDecoration(
          prefixIcon: const Icon(EvaIcons.lock),
          suffixIcon: const Icon(EvaIcons.eye),
          hintText: appLocalizations.password),
      validator: (password) {
        if (password == null || password.isEmpty) {
          return "Please enter a valid password";
        } else if (password.length < 6) {
          return "Password is too weak atleast should 6 charchters";
        }
        return null;
      },
    );
  }

  TextFormField buildEmailTextField(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyLarge,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
          prefixIcon: const Icon(EvaIcons.email),
          hintText: appLocalizations.email),
      controller: emailController,
      validator: (email) {
        if (email == null || email.isEmpty) {
          return "Please enter email";
        }
        final bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email);
        if (!emailValid) {
          return "The email address is badly formatted";
        }
        return null;
      },
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return CustomButton(
        onClick: () async {
          if (!formKey.currentState!.validate()) return;
          try {
            showLoading(context);
            UserCredential credential =
                await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
            UserDM.currentUser =
                await getUserFromFirestore(credential.user!.uid);
            hideLoading(context);
            Navigator.pushNamed(context, HomeScreen.routeName);
          } on FirebaseAuthException catch (e) {
            hideLoading(context);
            print("108- exception: ${e}");
            showMessage(context,
                e.message ?? "Something went wrong please try again later",
                posButtonTitle: "ok");
          }
        },
        title: appLocalizations.login);
  }

  Row buildSignUpRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          appLocalizations.dontHaveAccount,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, SignupScreen.routeName);
          },
          child: Text(appLocalizations.signup),
        )
      ],
    );
  }

  Padding buildORText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "or",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }

  FilledButton buildGoogleSignInButton(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      style: FilledButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Brand(Brands.google),
          const SizedBox(width: 8),
          Text(appLocalizations.googleLogin),
        ],
      ),
    );
  }
}
