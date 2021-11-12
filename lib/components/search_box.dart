import 'package:flutter/material.dart';

Container searchBox(TextEditingController searchController) {
  return Container(
    height: 40.0,
    margin: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(20.0),
      ),
      color: Colors.grey.withOpacity(0.4),
    ),
    child: TextField(
      controller: searchController,
      decoration: const InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(Icons.search),
        hintText: "검색",
      ),
    ),
  );
}
