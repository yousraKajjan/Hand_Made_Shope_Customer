import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_namaa/screens/providerFav/favProvider.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Favourite ❤'),
      ),
      body: const Column(
        children: [
          Expanded(
            child: FavouriteList(),
          ),
        ],
      ),
    );
  }
}

class FavouriteList extends StatelessWidget {
  const FavouriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderFav>(
      builder: (context, fav, child) => fav.favProducts.isEmpty
          ? Center(
              child: Image.asset('asset/images/favorite_screen_empty.png'),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1 / 1.7),
              itemCount: fav.favProducts.length,
              itemBuilder: (context, index) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: double.infinity,
                        height: 200.h,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: Colors.grey.shade100),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.black45,
                              ),
                            ]),
                        child: Center(
                          child: Container(
                            // width: 200.w,
                            // height: 50.h,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.network(
                              fav.favProducts[index][2],
                              // width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 4.h,
                      // ),
                      Center(
                        child: Text(
                          fav.favProducts[index][0],
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              // color: Colors.grey,
                              fontFamily: 'NotoSerif'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                fav.removeProductToFav(
                                    [fav.favProducts[index]]);
                              },
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )),
                          Text(
                            '${fav.favProducts[index][1]}' '\$',
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontFamily: 'NotoSerif'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
