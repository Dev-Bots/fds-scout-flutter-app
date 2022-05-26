import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width * 1, // <-- Your width
        height: MediaQuery.of(context).size.height * 0.06,
        // width: double.infinity, // <-- match_parent
        // height: double.infinity, // <-- match-parent
        child: Container(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              // shape: StadiumBorder(),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(0),
              ),
              primary: Colors.black,
              onPrimary: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: Text(text),
            onPressed: onClicked,
          ),
        ),
      );
}
