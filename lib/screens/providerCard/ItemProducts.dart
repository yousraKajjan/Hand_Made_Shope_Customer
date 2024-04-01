import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_namaa/screens/providerCard/CardProvider.dart';
import 'package:provider/provider.dart';

class ItemProduct extends StatefulWidget {
  const ItemProduct({super.key});

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  Future<QuerySnapshot<Map<String, dynamic>>?>?
      initDataProductsForItem() async {
    return await FirebaseFirestore.instance.collection("products").get();
    // return null;
  }

  Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    // var item = Provider.of<ProviderCart>(context, listen: false).itemsCard;
    final List<dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;

    String title = arguments[0];
    String imageLink = arguments[1];
    String description = arguments[2];
    String price = arguments[3];
    String id = arguments[4];
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: initDataProductsForItem(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.hasError) return const Text("Something has error");
            if (snapshot.data == null) {
              return const Text("Empty data");
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 350.h,
                    child: Image.network(
                      imageLink,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    description,
                    style:
                        const TextStyle(fontFamily: 'NotoSerif', fontSize: 25),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$price' '\$',
                    style: const TextStyle(fontSize: 30, color: Colors.orange),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Color?',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      colorContainer(Colors.blue),
                      const SizedBox(width: 10),
                      colorContainer(Colors.amber),
                      const SizedBox(width: 10),
                      colorContainer(Colors.red),
                      const SizedBox(width: 10),
                      colorContainer(Colors.pink),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  // const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 197, 229, 115),
                    ),
                    width: double.infinity,
                    height: 50.h,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 2,
                            color: Colors.orange,
                            // onPressed: () {
                            //   var provider = Provider.of<ProviderCart>(context,
                            //       listen: false);
                            //   dynamic product = {
                            //     'id': id,
                            //     'title': title,
                            //     'price': price,
                            //     'imageLink': imageLink
                            //   };

                            //   if (provider.isProductInCart(product[0])) {
                            //     // عرض رسالة إلى المستخدم تفيد بأن المنتج موجود بالفعل
                            //     print('المنتج موجود بالفعل في السلة');
                            //   } else {
                            //     provider.addProductToCart(
                            //         [title, price, imageLink]);
                            //     Navigator.pushNamed(context, '/Card Screen');
                            //   }
                            // },

                            onPressed: () {
                              Provider.of<ProviderCart>(context, listen: false)
                                  .addProductToCart([title, price, imageLink]);

                              Navigator.pushNamed(
                                context,
                                '/Card Screen',
                              );
                            },
                            child: Text(
                              'Add To Cart',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget colorContainer(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: selectedColor == color ? Colors.black : Colors.transparent,
            width: 2.0,
          ),
        ),
        width: 50,
        height: 50,
      ),
    );
  }
}
