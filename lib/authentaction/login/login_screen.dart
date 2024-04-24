// ignore_for_file: use_build_context_synchronously, unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_types_as_parameter_names, non_constant_identifier_names, unnecessary_brace_in_string_interps, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/authentaction/custom_text_form_filed.dart';
import 'package:untitled/authentaction/login/login_navigator.dart';
import 'package:untitled/authentaction/login/login_screen_view_model.dart';
import 'package:untitled/authentaction/register/register_screen.dart';
import 'package:untitled/mytheme.dart';
import 'package:untitled/provider/app_config_provider.dart';

import '../alert_dialog.dart';

class Login extends StatefulWidget {
  static String routeName = "Login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> implements LoginNavigator {

LoginScreenViewModel viewModel = LoginScreenViewModel();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Container(
            color: provider.isDark()
                ? MyTheme.backgrounddark
                : MyTheme.backgroundlight,
            child: Image.asset(
              "assets/images/background.png",
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                "Login",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: MyTheme.whiteColor),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                Form(
                    key: viewModel.formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * .23,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Welcome Back !",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          labelText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          controller: viewModel.emailController,
                          validator: (Text) {
                            if (Text!.trim().isEmpty) {
                              return "Please Enter Email";
                            }
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(viewModel.emailController.text);
                            if (!emailValid) {
                              return "Please enter Vaild email";
                            }
                            return null;
                          },
                        ),
                        CustomTextFormField(
                          obscuretext: true,
                          labelText: "Password",
                          keyboardType: TextInputType.number,
                          controller: viewModel.passwordController,
                          validator: (Text) {
                            if (Text!.trim().isEmpty) {
                              return "Please Enter Password";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Forget Password ?",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                padding:
                                    MaterialStatePropertyAll(EdgeInsets.all(15)),
                              ),
                              onPressed: () {
                                viewModel.login();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(Icons.arrow_right)
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(Register.routeName);
                              },
                              child: Text(
                                "Or Create Account",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontSize: 20),
                              )),
                        ),
                      ],
                    )),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void hideLoading() {
    DialogUlits.hideLoading(context);
  }

  @override
  void showLoading() {
    DialogUlits.showLoading(context: context, message: "Loading");
  }

  @override
  void showMessage(String message) {
    DialogUlits.showMessage(context: context, message: message);
  }
}
