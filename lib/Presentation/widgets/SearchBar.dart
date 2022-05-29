import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          cursorColor: Colors.grey,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            filled: true,
            fillColor: Colors.grey.shade200,
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none),
            hintText: "Search for Events",
            hintStyle: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
