import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/authentaction/login/login_navigator.dart';
import '../../firebase_utils.dart';

class LoginScreenViewModel extends ChangeNotifier {

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
   late LoginNavigator navigator;
  void login() async {
    if (formkey.currentState!.validate() == true) {
      // show loading
      navigator.showLoading();
      try {
        final credential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // var user = await Firebaseutils.readUserFromFirestore(
        //     credential.user?.uid ?? "");
        // if (user == null) {
        //   return;
        // }
        // var authuser = Provider.of<AuthUsers>(context,listen: false);
        // authuser.updateUsers(user);
        // hide loading
        navigator.hideLoading();
        // show message
        navigator.showMessage("Login Successfully");
        // DialogUlits.showMessage(
        //     context: context,
        //     message: "Login Successfully",
        //     posAction: "OK",
        //     posFunction: () {
        //       Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        //     });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
// hide loading
        navigator.hideLoading();
          // show message
          navigator.showMessage("The supplied auth credential is incorrect, malformed or has expired.");
          // DialogUlits.showMessage(
          //     context: context,
          //     message:
          //     "The supplied auth credential is incorrect, malformed or has expired.",
          //     posAction: "Ok",
          //     title: "Error");
        }
      } catch (e) {
        // hide loading
        navigator.hideLoading();
        // show message
        navigator.showMessage("$e");
        // DialogUlits.showMessage(
        //     context: context, message: "${e}", posAction: "Ok");
      }
    }
  }
}