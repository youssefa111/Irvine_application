import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

enum ContainerCategory {
  reportContiner,
  newsContiner,
}

// #0D8AE3
// #4BB9BC
// #3DC681
LinearGradient linearGradient = LinearGradient(
  colors: [
    HexColor("#0D8AE3"),
    HexColor("#4BB9BC"),
    HexColor("#3DC681"),
  ],
);

Widget myTextFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String validMessage,
  required String labelText,
  required IconData prefixIcon,
  bool obscureText = false,
  required BuildContext context,
}) =>
    Container(
      width: MediaQuery.of(context).size.width * .8,
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) {
          if (value!.isEmpty) {
            return validMessage;
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 12),
          prefixIcon: Icon(prefixIcon),
          border: OutlineInputBorder(),
        ),
      ),
    );

Widget myTextButton({
  required String text,
  required BuildContext context,
  required VoidCallback function,
}) =>
    InkWell(
      onTap: function,
      child: Container(
        width: double.infinity,
        height: 55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: linearGradient, borderRadius: BorderRadius.circular(8)),
        child: Text(
          text,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
