// ignore_for_file: use_build_context_synchronously, unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_types_as_parameter_names, non_constant_identifier_names, unnecessary_brace_in_string_interps, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/authentaction/alert_dialog.dart';
import 'package:untitled/authentaction/custom_text_form_filed.dart';
import 'package:untitled/authentaction/register/register_navigator.dart';
import 'package:untitled/authentaction/register/register_screen_view_model.dart';
import 'package:untitled/mytheme.dart';
import 'package:untitled/provider/app_config_provider.dart';


class Register extends StatefulWidget {
  static String routeName = "Register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> implements RegisterNavigator {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController PasswordController = TextEditingController();

  TextEditingController confimPasswordController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  RegisterScreenViewModel viewModel = RegisterScreenViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return
      ChangeNotifierProvider(
        create: (context)=>viewModel,
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
                  "Create Account",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: MyTheme.whiteColor),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: true,
              ),
              body: SingleChildScrollView(
                child: Column(children: [
                  Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * .23,
                          ),
                          CustomTextFormField(
                            labelText: "User Name",
                            controller: nameController,
                            validator: (Text) {
                              if (Text!.trim().isEmpty) {
                                return "Please Enter Name";
                              }
                              return null;
                            },
                          ),
                          CustomTextFormField(
                            labelText: "Email",
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (Text) {
                              if (Text!.trim().isEmpty) {
                                return "Please Enter Email";
                              }
                              bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(emailController.text);
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
                            controller: PasswordController,
                            validator: (Text) {
                              if (Text!.trim().isEmpty) {
                                return "Please Enter Password";
                              }
                              if (Text.length < 6) {
                                return "Enter at least 6 numbers";
                              }
                              return null;
                            },
                          ),
                          CustomTextFormField(
                            obscuretext: true,
                            labelText: "Confrim Password",
                            keyboardType: TextInputType.number,
                            controller: confimPasswordController,
                            validator: (Text) {
                              if (Text!.trim().isEmpty) {
                                return "Please Enter Confim Password";
                              }
                              if (Text != PasswordController.text) {
                                return "Confrim Password dosen't match your Password";
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(15)),
                                ),
                                onPressed: () {
                                  register();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Create Account",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(Icons.arrow_right)
                                  ],
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

  void register() async {
    if (formkey.currentState!.validate() == true) {
      viewModel.register(emailController.text, PasswordController.text);
    }
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
