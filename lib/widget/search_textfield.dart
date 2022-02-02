import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Material(
            elevation: 1.5,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
            child: SizedBox(
              height: 50,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: 'Search for articles',
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.search, color: Colors.white, size: 32),
        )
      ],
    );
  }
}
