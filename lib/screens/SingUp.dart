import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_namaa/cubit/siginUp/cubit.dart';
import 'package:project_namaa/cubit/siginUp/state.dart';
import 'package:project_namaa/shared/components.dart';

class SingUpScreen extends StatelessWidget {
  const SingUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("SignUp Success"),
              ),
            );
            Navigator.pushNamedAndRemoveUntil(
                context, "/home", ModalRoute.withName('/'));
          }
          if (state is SignUpErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 195, 194, 194),
            // backgroundColor: const Color(0xffEEF1F3),
            appBar: AppBar(
              // backgroundColor: Colors.transparent,
              title: const Text('Sign-Up '),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        context.read<SignUpCubit>().image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(
                                    context.read<SignUpCubit>().image!),
                              )
                            : ClipOval(
                                clipBehavior: Clip.antiAlias,
                                child: Image.asset(
                                  'asset/images/avatar.png',
                                  width: 150.w,
                                ),
                              ),
                        Positioned(
                          bottom: 0.dg,
                          left: 70.dg,
                          child: IconButton(
                            onPressed: () {
                              context.read<SignUpCubit>().SelectImage();
                            },
                            icon: const Icon(
                              Icons.add_a_photo_outlined,
                              size: 40,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // ElevatedButton(
                    //   onPressed: context.read<SignUpCubit>().saveProfile,
                    //   child: const Text('Save Profile'),
                    // ),
                    Form(
                      key: context.read<SignUpCubit>().formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Name',
                            style: TextStyle(fontSize: 20),
                          ),
                          MyTextField(
                            controller:
                                context.read<SignUpCubit>().nameController,
                            prefixIcon: const Icon(Icons.abc_sharp),
                            hintText: 'Enter Your Name',
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This Field is required';
                              }
                              return null;
                            },
                          ),
                          const Text(
                            'Email',
                            style: TextStyle(fontSize: 20),
                          ),
                          MyTextField(
                            controller:
                                context.read<SignUpCubit>().emailController,
                            prefixIcon: const Icon(Icons.email_outlined),
                            hintText: 'Enter Your Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This Field is required';
                              }
                              if (!value.contains('@')) {
                                return 'Enter @ ';
                              }
                              return null;
                            },
                          ),
                          const Text(
                            'Password',
                            style: TextStyle(fontSize: 20),
                          ),
                          MyTextField(
                            controller:
                                context.read<SignUpCubit>().passwordController,
                            obscureText:
                                context.read<SignUpCubit>().isobscurePssword,
                            prefixIcon: const Icon(Icons.password_rounded),
                            suffixIcon: IconButton(
                              onPressed: () {
                                context.read<SignUpCubit>().isvisblePassword();
                              },
                              icon: context.read<SignUpCubit>().isobscurePssword
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.remove_red_eye),
                            ),
                            hintText: 'Enter Your Password',
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This Field is required';
                              }
                              return null;
                            },
                          ),
                          const Text(
                            'confirm password',
                            style: TextStyle(fontSize: 20),
                          ),
                          MyTextField(
                            controller: context
                                .read<SignUpCubit>()
                                .ConfirmPasswordController,
                            obscureText: context
                                .read<SignUpCubit>()
                                .isobscurePsswordConfirm,
                            prefixIcon: const Icon(Icons.password_rounded),
                            suffixIcon: IconButton(
                              onPressed: () {
                                context
                                    .read<SignUpCubit>()
                                    .isvisblePasswordCofirm();
                              },
                              icon: context
                                      .read<SignUpCubit>()
                                      .isobscurePsswordConfirm
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.remove_red_eye),
                            ),
                            hintText: ' confirm password',
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This Field is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const Text(
                            'Your Phone ',
                            style: TextStyle(fontSize: 20),
                          ),
                          MyTextField(
                            controller: context
                                .read<SignUpCubit>()
                                .PhoneNumberController,
                            prefixIcon: const Icon(Icons.numbers),
                            hintText: ' Enter Your Phone Number',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This Field is required';
                              }
                              if (value.length > 10 || value.length < 10) {
                                return 'Your Number Must 10 Numbers';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    ),
                    state is SignUpLoadinState
                        ? const CircularProgressIndicator()
                        : Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: double.infinity,
                            height: 40.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(),
                              onPressed: () async {
                                context
                                    .read<SignUpCubit>()
                                    .formKey
                                    .currentState
                                    ?.validate();
                                context.read<SignUpCubit>().sinup(context);
                              },
                              child: const Text(
                                'Sign-Up',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already Have Account?'),
                        TextButton(
                          child: const Text('Login'),
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                        )
                      ],
                    )
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
