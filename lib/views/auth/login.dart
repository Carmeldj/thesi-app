import 'package:flutter/material.dart';
import 'package:thesis_app/components/form_input.dart';
import 'package:thesis_app/constants/colors.dart';
import 'package:thesis_app/constants/fonts.dart';
import 'package:thesis_app/controllers/cubit/auth/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thesis_app/views/home.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String emailHintText = 'Enter your email';
  final String passwordHintText = 'Enter your password';
  final String initialValue = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            // Show loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(child: CircularProgressIndicator()),
            );
          } else if (state is AuthSucess) {
            // Navigate to the next screen
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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

                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().login(
                            emailController.text,
                            passwordController.text,
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
                            "Login",
                            style: TextStyle(fontSize: textNormal),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
