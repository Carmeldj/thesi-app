import 'package:flutter/material.dart';
import 'package:thesis_app/components/form_input.dart';
import 'package:thesis_app/constants/colors.dart';
import 'package:thesis_app/constants/fonts.dart';
import 'package:thesis_app/controllers/cubit/auth/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_app/views/auth/login.dart';

class Register extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final String emailHintText = 'Enter your email';
  final String passwordHintText = 'Enter your password';
  final String usernameHintText = 'Enter your username';
  final String firstNameHintText = 'Enter your first name';
  final String lastNameHintText = 'Enter your last name';
  final String phoneNumberHintText = 'Enter your phone number';
  final String imageHintText = 'Enter your image URL (optional)';
  final String initialValue = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthLoading) {
                // Show loading indicator
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder:
                      (context) => Center(child: CircularProgressIndicator()),
                );
              } else if (state is AuthSucess) {
                // Navigate to the next screen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false,
                );
              } else if (state is AuthFailure) {
                // Show error message
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 30),
                          FormInput(
                            controller: emailController,
                            hintText: emailHintText,
                          ),
                          SizedBox(height: 30),
                          FormInput(
                            controller: passwordController,
                            hintText: passwordHintText,
                          ),
                          SizedBox(height: 30),

                          FormInput(
                            controller: usernameController,
                            hintText: usernameHintText,
                          ),
                          SizedBox(height: 30),

                          FormInput(
                            controller: firstNameController,
                            hintText: firstNameHintText,
                          ),
                          SizedBox(height: 30),

                          FormInput(
                            controller: lastNameController,
                            hintText: lastNameHintText,
                          ),
                          SizedBox(height: 30),

                          FormInput(
                            controller: phoneNumberController,
                            hintText: phoneNumberHintText,
                          ),
                          SizedBox(height: 30),

                          FormInput(
                            controller: imageController,
                            hintText: imageHintText,
                          ),
                          SizedBox(height: 30),

                          TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().register(
                                  emailController.text,
                                  passwordController.text,
                                  usernameController.text,
                                  firstNameController.text,
                                  lastNameController.text,
                                  imageController.text.isEmpty
                                      ? null
                                      : imageController.text,
                                  phoneNumberController.text.isEmpty
                                      ? null
                                      : phoneNumberController.text,
                                );
                              }
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10),
                                color: primaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(fontSize: textNormal),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
