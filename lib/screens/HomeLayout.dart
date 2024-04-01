import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_namaa/cubit/home_layout/homeLayout_provider.dart';
import 'package:provider/provider.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeLayoutProvider(),
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('HomeLayout'),
        //   actions: [
        //     IconButton(
        //         onPressed: () async {
        //           await FirebaseAuth.instance.signOut();
        //           Navigator.of(context).pushReplacementNamed('/');
        //         },
        //         icon: const Icon(Icons.logout))
        //   ],
        // ),
        bottomNavigationBar: Consumer<HomeLayoutProvider>(
          builder: (context, value, child) {
            return BottomNavigationBar(
                onTap: (value) {
                  context.read<HomeLayoutProvider>().changeBottomNav(value);
                },
                currentIndex: value.index,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border), label: 'favourite'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart_outlined), label: 'Card'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_2_outlined), label: 'Profile'),
                ]);
          },
        ),
        body: Consumer<HomeLayoutProvider>(
          builder: (context, value, child) {
            return Center(
              child: context.read<HomeLayoutProvider>().screen[value.index],
            );
          },
          child: const Center(
            child: Text('HomeLyout'),
          ),
        ),
      ),
    );
  }
}
