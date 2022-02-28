import 'package:flutter/material.dart';

class ImageTileBuider extends StatelessWidget {
  const ImageTileBuider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            width: 120,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("assets/background_button.png"),
                  fit: BoxFit.cover),
            ),
            child: Text("clickMe") // button text

            ),
        onTap: () {
          print("you clicked me");
        });
  }
}
