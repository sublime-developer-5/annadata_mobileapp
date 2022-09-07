import 'package:flutter/material.dart';

class SearchBarHomeScreen extends StatefulWidget {
  const SearchBarHomeScreen({Key? key}) : super(key: key);

  @override
  State<SearchBarHomeScreen> createState() => _SearchBarHomeScreenState();
}

class _SearchBarHomeScreenState extends State<SearchBarHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.orange)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.orange)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.green)),
            hintText: 'Search Categories / Commodity',
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            )),
      ),
    );
  }
}
