import 'package:evently_c13_online/core/assets/app_assets.dart';
import 'package:evently_c13_online/core/providers/user_provider.dart';
import 'package:evently_c13_online/firebase_helpers/firestore/firestore_helper.dart';
import 'package:evently_c13_online/model/user_dm.dart';
import 'package:evently_c13_online/ui/utils/context_extensions.dart';
import 'package:evently_c13_online/ui/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:icons_plus/icons_plus.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = '/signup';

  SignupScreen({super.key});

  late AppLocalizations appLocalizations;

  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  late UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context)!;
    userProvider = context.userProvider;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.register),
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Image.asset(
              AppAssets.appVerticalLogoImage,
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            TextFormField(
              controller: nameController,
              style: Theme.of(context).textTheme.bodyLarge,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                  prefixIcon: const Icon(EvaIcons.person),
                  hintText: appLocalizations.name),
            ),
            const SizedBox(height: 16),
            TextFormField(
              style: Theme.of(context).textTheme.bodyLarge,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                  prefixIcon: const Icon(EvaIcons.email),
                  hintText: appLocalizations.email),
              controller: emailController,
            ),
            const SizedBox(height: 16),
            TextFormField(
              style: Theme.of(context).textTheme.bodyLarge,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                  prefixIcon: const Icon(EvaIcons.lock),
                  suffixIcon: const Icon(EvaIcons.eye),
                  hintText: appLocalizations.password),
              controller: passwordController,
            ),
            const SizedBox(height: 16),
            TextFormField(
              style: Theme.of(context).textTheme.bodyLarge,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                  prefixIcon: const Icon(EvaIcons.lock),
                  suffixIcon: const Icon(EvaIcons.eye),
                  hintText: appLocalizations.repassword),
            ),
            const SizedBox(height: 32),
            buildRegisterButton(context),
            buildSignInTextRow(context)
          ],
        ),
      ),
    );
  }

  FilledButton buildRegisterButton(BuildContext context) => FilledButton(
      onPressed: () async {
        try {
          showLoading(context);
          final userCredentials =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );
          UserDM newUser = UserDM(
              id: userCredentials.user!.uid,
              name: nameController.text,
              email: emailController.text);
          await createUserInFirestore(newUser);
          userProvider
              .updateCurrentUser(await getUserFromFirestore(newUser.id));
          hideLoading(context);
        } on FirebaseAuthException catch (e) {
          hideLoading(context);
          String message = "Something went wrong please try again later";
          if (e.code == 'weak-password') {
            message = "The password provided is too weak.";
          } else if (e.code == 'email-already-in-use') {
            message = "The account already exists for that email.";
          } else {
            message = e.message ?? message;
          }
          showMessage(context, message, posButtonTitle: "ok", title: "Error");
        }
        // catch (e) {
        //   print(e);
        //   hideLoading(context);
        //   showMessage(context, e.toString(), posButtonTitle: "ok", title: "Error");
        // }
      },
      child: Text(appLocalizations.createAccount));

  Row buildSignInTextRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          appLocalizations.alreadyHaveAccount,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(appLocalizations.login),
        )
      ],
    );
  }
}
