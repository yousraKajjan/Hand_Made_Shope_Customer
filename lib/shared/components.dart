import 'package:flutter/material.dart';
import 'package:project_namaa/shared/constant.dart';
import 'package:toast/toast.dart';

Widget buildTextField({
  TextEditingController? controller,
  String text = '',
  TextInputType? keyboardType,
  String? Function(String?)? validator,
  Widget? suffix,
  bool obscure = false,
  IconData? prefixIcon,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscure,
    validator: validator,
    keyboardType: keyboardType,
    cursorColor: secondaryColor.withOpacity(.8),
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon),
      prefixIconColor: MaterialStateColor.resolveWith((states) =>
          states.contains(MaterialState.focused)
              ? secondaryColor
              : Colors.grey),
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.only(left: 20),
      hintText: text,
      hintStyle: const TextStyle(color: Colors.grey),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide:
              BorderSide(color: secondaryColor.withOpacity(.8), width: 1.8)),
      // border: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(8),
      //   borderSide: BorderSide(color: Colors.grey.withOpacity(.8), width: 1.8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.grey.withOpacity(.8), width: 1.8),
      ),
    ),
  );
}

void message(BuildContext context, String msg, {int longTime = 3}) {
  ToastContext toastContext = ToastContext();
  toastContext.init(context);
  Toast.show(msg, duration: longTime);
}

Widget MyTextField({
  TextEditingController? controller,
  TextInputType? keyboardType,
  String? hintText,
  Widget? label,
  Widget? prefixIcon,
  Widget? suffixIcon,
  Function? onTap,
  String? Function(String?)? validator,
  bool obscureText = false,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      validator: validator,
      onTap: () {
        onTap;
      },
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: label,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(
          // gapPadding: 20.0,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
      onFieldSubmitted: (value) {
        print(value);
      },
    ),
  );
}
