import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';
import 'login_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterSceenState();
}

class _RegisterSceenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SignUp Page',
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Text(
                    'Register Now',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (!regExForEmail.hasMatch(value!)) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Email'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.length < 8) {
                          return 'Minimum 8 characters required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Password'),
                      ),
                    ),
                  ),
                  Obx(() {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(8.0),
                      height: 60,
                      decoration: BoxDecoration(
                        color: authController.isAuthenticating
                            ? kPrimayColor.shade200
                            : kPrimayColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: authController.isAuthenticating
                          ? const Center(child: CircularProgressIndicator())
                          : MaterialButton(
                              onPressed: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (formKey.currentState!.validate()) {
                                  debugPrint('Ok');
                                  final result = await authController.register(
                                    emailController.text,
                                    passwordController.text,
                                  );
                                  if (!result) {
                                    if (mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Something went wrong'),
                                        backgroundColor: Colors.red,
                                      ));
                                    }
                                  }
                                } else {
                                  debugPrint('Not Ok');
                                }
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        const Text(
                          'Alreay have an account?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.off(() => const LoginScreen());
                            },
                            child: const Text(
                              'Login now',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
