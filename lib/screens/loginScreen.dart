import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_namaa/cubit/singIn/cubit.dart';
import 'package:project_namaa/cubit/singIn/state.dart';
import 'package:project_namaa/shared/Cache_Helper/cache_helper.dart';
import 'package:project_namaa/shared/components.dart';
// import 'package:project_namaa/shared/constant.dart';

class LoginScreen extends StatelessWidget {
  // const LoginScreen({super.key});

  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            message(context, state.error, longTime: 7);
          } else if (state is LoginSuccessState) {
            // sharedPreferences?.setBool('login', true);
            CacheHelper().saveData(key: 'Login', value: true);
            message(context, "Log In Successfully");
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 195, 194, 194),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'asset/images/friendship.png',
                      // width: 150,
                    ),
                    const Text(
                      'Sing-in ',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'NotoSerif'),
                    ),
                    Form(
                      key: context.read<LoginCubit>().formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              '  Email:',
                              style: TextStyle(fontSize: 20),
                            ),
                            MyTextField(
                              controller:
                                  context.read<LoginCubit>().emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This Field is required';
                                }
                                if (!value.contains('@')) {
                                  return 'Enter @ ';
                                }
                                return null;
                              },
                              hintText: 'Enter Your Email',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(Icons.email),
                            ),
                            const Text(
                              'Password',
                              style: TextStyle(fontSize: 20),
                            ),
                            MyTextField(
                              controller:
                                  context.read<LoginCubit>().passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This Field is required';
                                }
                                return null;
                              },
                              obscureText: context.read<LoginCubit>().isobscure,
                              hintText: 'Enter Your password',
                              keyboardType: TextInputType.visiblePassword,
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  context.read<LoginCubit>().isvisblePassword();
                                },
                                icon: context.read<LoginCubit>().isobscure
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.remove_red_eye),
                              ),
                            ),
                            const Text(
                              'Forget Password?',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            state is LoginLoadinState
                                ? const CircularProgressIndicator()
                                : Container(
                                    height: 40.h,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: double.infinity,
                                    // height: 400.h,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 91, 158, 213),
                                      ),
                                      onPressed: () async {
                                        context
                                            .read<LoginCubit>()
                                            .siginIN(context);
                                      },
                                      child: const Text(
                                        'Sign-in',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t Have an account?'),
                                TextButton(
                                  child: const Text('sign-up'),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/sinup');
                                  },
                                ),
                              ],
                            )
                          ],
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
