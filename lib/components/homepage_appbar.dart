import 'package:crypto_cedi/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final TextEditingController controller;

  const HomePageAppBar(
      {Key key, @required this.height, @required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    'Crypto Cedi',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Spacer(),
                Text('Dark Mode'),
                Consumer<ThemeNotifier>(
                  builder: (context, notifier, child) => Switch(
                    value: notifier.darkTheme,
                    activeColor: Theme.of(context).accentColor,
                    onChanged: (value) {
                      notifier.toggleTheme();
                    },
                  ),
                ),
              ],
            ),
            SearchTextField(
              controller: controller,
            ),
          ],
        ),
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
          const EdgeInsets.only(left: 15.0, right: 15, top: 5.0, bottom: 0),
      child: TextField(
        controller: controller,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200,
          prefixIcon: Icon(Icons.search, color: Colors.black54),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              controller.clear();
            },
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: 'Search coin name, symbol',
          hintStyle: TextStyle(color: Colors.black54),
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
