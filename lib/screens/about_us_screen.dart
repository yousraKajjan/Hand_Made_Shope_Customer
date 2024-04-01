import 'package:flutter/material.dart';

import '../shared/constant.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 8,
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Column(
                children: [
                  Text(
                    'Created by ',
                    style: TextStyle(color: primaryColor, fontSize: 25),
                  ),
                  Text(
                    'Creative Shop Team',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: secondaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Hey there! Have you heard of Creative Shop? It\'s an app that my team of young and passionate creators have put together to showcase our handmade products. We pour our hearts into every item we make and it\'s exciting to see them all in one place on the app.\n\nWe pride ourselves on the fact that everything on Creative Shop is handmade. It\'s important to us to offer unique and high-quality products that you won\'t find in just any store. Which we are sure to catch your eye. We pay attention to every detail and it\'s rewarding to see the end result.\n\nWe love what we do and we hope it shows in our work. Creative Shop offers a wide range of products, from jewelry to home decor, all crafted with care. We\'re thrilled to be able to share our creations with you through the app.\n\nWhat\'s special about our store is the fact that everything is handmade. It\'s a refreshing change from the mass-produced items you find in most stores. The attention to detail and quality are clearly evident in each and every product on the app.\n\nIt\'s been an amazing journey creating and developing Creative Shop and we\'re excited for what\'s to come. We hope you\'ll check it out and love it as much as we do!',
              style: TextStyle(
                  fontFamily: 'poppins', fontSize: 20, color: primaryColor),
            ),
          ]),
        ),
      ),
    );
  }
}
