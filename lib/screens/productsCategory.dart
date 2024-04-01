import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_namaa/cubit/HomeScreen/cubit.dart';
import 'package:project_namaa/cubit/HomeScreen/state.dart';

class ProductsCategory extends StatefulWidget {
  const ProductsCategory({super.key});

  @override
  State<ProductsCategory> createState() => _ProductsCategoryState();
}

class _ProductsCategoryState extends State<ProductsCategory> {
  Future<QuerySnapshot<Map<String, dynamic>>?>? initCategory() async {
    var args = ModalRoute.of(context)?.settings.arguments;

    return await FirebaseFirestore.instance
        .collection("products")
        .where("title", isEqualTo: "$args")
        .get();
    // return null;
  }

  @override
  void initState() {
    initCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;

    return BlocProvider(
      create: (context) => HomeFavouriteCubit(),
      child: BlocConsumer<HomeFavouriteCubit, HomeFavouriteState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('$args' "  Category"),
            ),
            body: FutureBuilder(
              future: initCategory(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return const Center(child: Text("Something has error"));
                }
                if (snap.data == null) {
                  return const Center(child: Text("Empty data"));
                }
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1 / 1.5,
                  ),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/Item Product',
                            arguments: [
                              snap.data!.docs[index]['title'],
                              snap.data!.docs[index]['imageLink'],
                              snap.data!.docs[index]['description'],
                              snap.data!.docs[index]['price'],
                              snap.data!.docs[index]['id'],
                            ]);
                        // Navigator.pushNamedAndRemoveUntil(
                        //   context,
                        //   '/Item Product',
                        //   arguments: [
                        //     snap.data!.docs[index]['title'],
                        //     snap.data!.docs[index]['imageLink'],
                        //     snap.data!.docs[index]['description'],
                        //     snap.data!.docs[index]['price'],
                        //     snap.data!.docs[index]['id'],
                        //   ],
                        //   // الصفحة التي ترغب في الانتقال إليها
                        //   ModalRoute.withName(
                        //       '/home'), // '/HomePage' هو اسم المسار للصفحة التي تريد البقاء في المكدس
                        // );
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Image.network(
                                      '${snap.data!.docs[index]["imageLink"]}',
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Center(
                                child: Text(
                                  "${snap.data!.docs[index]["title"]}",
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.grey,
                                  ),
                                ),
                              ),
                              // Text(
                              //   "${snap.data!.docs[index]["description"]}",
                              //   style: const TextStyle(
                              //       fontSize: 17,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.grey,
                              //       fontFamily: 'NotoSerif'),
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${snap.data!.docs[index]["price"]}\$",
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                        fontFamily: 'NotoSerif'),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      context
                                          .read<HomeFavouriteCubit>()
                                          .updateFavoriteStatus(
                                              index,
                                              snap.data!.docs[index]['id'],
                                              snap.data!.docs[index]
                                                  ['isFavourite']);
                                    },
                                    icon: snap.data!.docs[index]['isFavourite']
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
                  itemCount: snap.data?.docs.length ?? 0,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
