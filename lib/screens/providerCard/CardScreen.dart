// import 'package:flutter/material.dart';

// class CardScreen extends StatelessWidget {
//   const CardScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     var args = ModalRoute.of(context)?.settings.arguments;
//     return Scaffold(
//       body: Center(
//         child: Image.network('$args'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_namaa/screens/providerCard/CardProvider.dart';
import 'package:provider/provider.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _CartList(),
          ),
          // const Divider(height: 4, color: Colors.black),
          // _CartTotal()
        ],
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderCart>(
      builder: (context, cart, child) => cart.cartProducts.isEmpty
          ? Center(
              child: Image.asset('asset/images/cart_screen_empty.png'),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1 / 1.5),
              itemCount: cart.cartProducts.length,
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
                              cart.cartProducts[index][2],
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
                          cart.cartProducts[index][0],
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              // color: Colors.grey,
                              fontFamily: 'NotoSerif'),
                        ),
                      ),
                      Text(
                        '${cart.cartProducts[index][1]}' '\$',
                        style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontFamily: 'NotoSerif'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
        //
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 10),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       Image.network(
        //         fit: BoxFit.cover,
        //         cart.cartProducts[index],
        //         // style: const TextStyle(fontSize: 20),
        //       ),
        //       // Text(cart.cartProducts[index].price.toString()),
        //       // if (child != null) child
        //     ],
        //   ),
        // ),
   

// class _CartTotal extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var hugeStyle =
//         Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 48);

//     return SizedBox(
//       height: 200,
//       child: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Consumer<ProviderCart>(
//                 builder: (context, cart, child) =>
//                     Text('\$${cart.totalPrice}', style: hugeStyle)),
//             const SizedBox(width: 24),
//             Selector<ProviderCart, bool>(
//               selector: (_, provider) => provider.isLoading,
//               builder: (context, value, child) {
//                 return Visibility(
//                   visible: value,
//                   replacement: child!,
//                   child: const CircularProgressIndicator(),
//                 );
//               },
//               child: ElevatedButton(
//                   onPressed: () {
//                     Provider.of<ProviderCart>(context, listen: false)
//                         .clearAll();
//                   },
//                   child: const Text("Clear")),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
