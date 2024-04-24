import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'register_navigator.dart';

class RegisterScreenViewModel extends ChangeNotifier {
  late RegisterNavigator navigator;
  void register(String email,String password) async {
    try {
      // show loading
      navigator.showLoading();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // MyUser user = MyUser(id: credential.user?.uid, name: nameController.text, email: email);
      // var authuser = Provider.of<AuthUsers>(context,listen: false);
      // authuser.updateUsers(user);
      // await Firebaseutils.addUserToFireStore(user);
      // hide loading
      navigator.hideLoading();
      // show message
      navigator.showMessage("Register Successfully");
      // DialogUlits.showMessage(
      //     context: context,
      //     message: "Register Successfully",
      //     posAction: "OK",
      //     posFunction: () {
      //       Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      //     });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // hide loading
        navigator.hideLoading();
        // show message
        navigator.showMessage("The password provided is too weak.");
        // DialogUlits.showMessage(
        //     context: context,
        //     message: "The password provided is too weak.",
        //     posAction: "Ok",
        //     title: "Error");
      } else if (e.code == 'email-already-in-use') {
        // hide loading
       navigator.hideLoading();
        // show message
        navigator.showMessage("The account already exists for that email.");
        // DialogUlits.showMessage(
        //     context: context,
        //     message: "The account already exists for that email.",
        //     posAction: "Ok",
        //     title: "Error");
      }
    } catch (e) {
      // hide loading
      navigator.hideLoading();
      // show message
      navigator.showMessage("${e}");
      // DialogUlits.showMessage(
      //     context: context, message: "${e}", posAction: "Ok");
    }
  }
}