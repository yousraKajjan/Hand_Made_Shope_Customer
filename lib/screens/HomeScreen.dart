import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_namaa/cubit/HomeScreen/cubit.dart';
import 'package:project_namaa/cubit/HomeScreen/state.dart';
import 'package:project_namaa/screens/providerFav/favProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<QuerySnapshot<Map<String, dynamic>>?>? initDataProducts() async {
    return await FirebaseFirestore.instance
        .collection("products")
        .orderBy("createdAt", descending: true)
        .get();
    // return null;
  }

  Future<QuerySnapshot<Map<String, dynamic>>?>? initDataCategory() async {
    return await FirebaseFirestore.instance
        .collection("Category")
        .orderBy("createdAt", descending: true)
        .get();
    // return null;
  }

  Future<QuerySnapshot<Map<String, dynamic>>?>? initDataaWithoutOrder() async {
    return await FirebaseFirestore.instance.collection("products").get();
  }

  @override
  void initState() {
    initDataCategory();
    initDataProducts();
    super.initState();
  }

  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeFavouriteCubit(),
      child: BlocConsumer<HomeFavouriteCubit, HomeFavouriteState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('All products'),
              ),
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: FutureBuilder(
                        future: initDataCategory(),
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          if (snap.hasError) {
                            return const Text("Something has error");
                          }
                          if (snap.data == null) {
                            return const Text("Empty data");
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'New Category:',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              SizedBox(
                                height: 200.h,
                                width: double.infinity,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: snap.data?.docs.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () async {
                                        final updatedData =
                                            await Navigator.pushNamed(
                                          context,
                                          '/products Category',
                                          arguments: snap.data!.docs[index]
                                              ["Type Category"],
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 170.h,
                                            height: 170.h,
                                            child: Card(
                                              clipBehavior: Clip.hardEdge,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                              ),
                                              shadowColor: Colors.grey,
                                              elevation: 4,
                                              child: Image.network(
                                                '${snap.data!.docs[index]["imageLink"]}',
                                                width: 140.h,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "${snap.data!.docs[index]["Type Category"]}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'New Products:',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isPressed = !isPressed;
                                      });
                                    },
                                    icon: isPressed
                                        ? const Icon(Icons.arrow_downward_sharp)
                                        : const Icon(Icons.arrow_forward),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ];
                },
                body: FutureBuilder(
                  future: initDataProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Text("Something has error");
                    }
                    if (snapshot.data == null) {
                      return const Text("Empty data");
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.5,
                      ),
                      itemCount:
                          isPressed ? snapshot.data?.docs.length ?? 0 : 2,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/Item Product',
                                arguments: [
                                  snapshot.data!.docs[index]['title'],
                                  snapshot.data!.docs[index]['imageLink'],
                                  snapshot.data!.docs[index]['description'],
                                  snapshot.data!.docs[index]['price'],
                                  snapshot.data!.docs[index]['id'],
                                ]);
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    width: double.infinity,
                                    height: 170.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: Colors.grey.shade100),
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
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Image.network(
                                          '${snapshot.data!.docs[index]["imageLink"]}',
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 4.h,
                                  // ),
                                  Center(
                                    child: Text(
                                      "${snapshot.data!.docs[index]["title"]}",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          // color: Colors.grey,
                                          fontFamily: 'NotoSerif'),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${snapshot.data!.docs[index]["price"]}\$",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontFamily: 'NotoSerif'),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          context
                                              .read<HomeFavouriteCubit>()
                                              .updateFavoriteStatus(
                                                  index,
                                                  snapshot.data!.docs[index]
                                                      ['id'],
                                                  snapshot.data!.docs[index]
                                                      ['isFavourite']);
                                          snapshot.data!.docs[index]
                                                  ['isFavourite']
                                              ? Provider.of<ProviderFav>(
                                                      context,
                                                      listen: false)
                                                  .removeProductToFav([
                                                  snapshot.data!.docs[index]
                                                      ['title'],
                                                  snapshot.data!.docs[index]
                                                      ['price'],
                                                  snapshot.data!.docs[index]
                                                      ['imageLink'],
                                                ])
                                              : Provider.of<ProviderFav>(
                                                      context,
                                                      listen: false)
                                                  .addProductToFav([
                                                  snapshot.data!.docs[index]
                                                      ['title'],
                                                  snapshot.data!.docs[index]
                                                      ['price'],
                                                  snapshot.data!.docs[index]
                                                      ['imageLink'],
                                                ]);
                                        },
                                        icon: snapshot.data!.docs[index]
                                                ['isFavourite']
                                            ? const Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )
                                            : const Icon(
                                                Icons.favorite_border,
                                                color: Colors.red,
                                              ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}
