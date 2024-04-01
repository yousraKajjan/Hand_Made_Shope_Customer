// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   Future<DocumentSnapshot<Map<String, dynamic>>?>? initName() async {
//     if (FirebaseAuth.instance.currentUser != null) {
//       print(FirebaseAuth.instance.currentUser!.uid);
//       return await FirebaseFirestore.instance
//           .collection("users")
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .get();
//     }
//     return null;
//   }

//   @override
//   void initState() {
//     initName();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           // mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FutureBuilder(
//               future: initName(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const CircularProgressIndicator();
//                 }
//                 if (snapshot.hasError) {
//                   return const Text('SomeThing Has Error');
//                 }
//                 if (snapshot.data == null) {
//                   return const Text('Empty Data');
//                 }
//                 return Padding(
//                   padding: EdgeInsets.all(10.h),
//                   child: Column(
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: Colors.amber,
//                         radius: 35,
//                         child: Text(
//                           " ${snapshot.data?.data()?["name"]}",
//                           style: Theme.of(context)
//                               .textTheme
//                               .titleLarge
//                               ?.copyWith(color: Theme.of(context).primaryColor),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             )
//           ]),
//     );
//   }
// }

// import 'package:creative_shop/screens/contact_us_screen.dart';
// import 'package:creative_shop/screens/login_screen.dart';
// import 'package:creative_shop/shared/component.dart';
// import 'package:creative_shop/shared/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_namaa/screens/about_us_screen.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_namaa/shared/constant.dart';

// import 'about_us_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<DocumentSnapshot<Map<String, dynamic>>?>? initName() async {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser!.uid);
      return await FirebaseFirestore.instance
          .collection("userProfileSingUp")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
    }
    return null;
  }

  @override
  void initState() {
    initName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('/');
              },
              icon: const Icon(Icons.logout))
        ],
        elevation: 8,
        backgroundColor: primaryColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: initName(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return const Text('SomeThing Has Error');
              }
              if (snapshot.data == null) {
                return const Text('Empty Data');
              }

              return CircleAvatar(
                backgroundImage:
                    NetworkImage('${snapshot.data?.data()?["imageLink"]}'),
                backgroundColor: secondaryColor,
              );
            },
          ),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          FutureBuilder(
            future: initName(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return const Text('SomeThing Has Error');
              }
              if (snapshot.data == null) {
                return const Text('Empty Data');
              }
              return Text(
                ' ${snapshot.data?.data()?["email"]}',
                // publicModel.username,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: whiteColor),
              );
            },
          ),
        ]),
        // actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ]),
                      child: Column(
                        children: [
                          buildTab(
                              icon: Icons.history, text: 'Purchase History'),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey.shade200,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ]),
                      child: Column(
                        children: [
                          buildTab(
                              icon: Icons.notifications_none_outlined,
                              text: 'Notifications'),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ]),
                      child: Column(
                        children: [
                          buildTab(
                              icon: Icons.place_outlined,
                              text: 'Delivery Addresses'),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey.shade200,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 60,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              width: double.infinity,
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.settings_outlined,
                                    color: primaryColor,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Settings',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ]),
                      child: Column(
                        children: [
                          buildTab(
                              icon: Icons.info_outline_rounded,
                              text: 'About Us',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AboutUsScreen(),
                                  ),
                                );
                              }),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.grey.shade200,
                          ),
                          buildTab(
                            icon: Icons.call,
                            text: 'Contact Us',
                            // onTap: () => Navigator.of(context).push(
                            // MaterialPageRoute(
                            // builder: (_) => ContactUsScreen(),),),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     buildMessage(context,
            //         image: 'asset/images/logout_icon.png',
            //         title: 'Logout',
            //         subTitle: 'Are you sure you want to logout?',
            //         firstButtonText: 'Logout',
            //         function: () async {
            //           Navigator.of(context).pop();
            //           sharedPreferences?.setBool('login', false);
            //           GoogleSignIn().signOut();
            //           Future.delayed(
            //             const Duration(seconds: 1),
            //             () => Navigator.of(context).pushReplacement(
            //               MaterialPageRoute(
            //                 builder: (_) => const LoginScreen(),
            //               ),
            //             ),
            //           );
            //           selectedInd = 1;
            //         },
            //         secondButtonText: 'Cancel',
            //         secondButtonFunction: () {
            //           Navigator.of(context).pop();
            //         });
            //   },
            //   style: ElevatedButton.styleFrom(
            //       minimumSize: const Size(double.infinity, 60),
            //       backgroundColor: secondaryColor,
            //       shape: const RoundedRectangleBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(8)))),
            //   child: const Text('Logout',
            //       style: TextStyle(fontSize: 24, color: whiteColor)),
            // )
          ],
        ),
      ),
    );
  }
}

Widget buildTab({IconData? icon, String? text, void Function()? onTap}) =>
    InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        child: Row(
          children: [
            Icon(icon, color: primaryColor, size: 25),
            const SizedBox(width: 20),
            Text(
              '$text',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            const Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.grey,
                    size: 18,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
//check