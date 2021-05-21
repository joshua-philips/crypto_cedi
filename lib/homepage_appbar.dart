import 'package:flutter/material.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final TextEditingController controller;

  const HomePageAppBar(
      {Key key, @required this.height, @required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Crypto Cedi',
            style: TextStyle(fontSize: 30),
          ),
          SearchTextField(
            controller: controller,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;

  const SearchTextField({Key key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15, top: 10.0, bottom: 0),
      child: TextField(
        controller: controller,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200,
          suffixIcon: Icon(Icons.search),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: 'Search',
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        ),
        enableSuggestions: true,
      ),
    );
  }
}
