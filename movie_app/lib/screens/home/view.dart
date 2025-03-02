import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeLogic logic = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Movie App', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Obx(() => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: logic.categories.map((category) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () => logic.selectedCategory.value = category,
                    child: Chip(
                      backgroundColor: logic.selectedCategory.value == category
                          ? Colors.red
                          : Colors.grey.shade800,
                      label: Text(
                        category,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          )),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                movieCard('Pacific Rim 2', '2018', 'https://example.com/pacific_rim.jpg', 5.8),
                movieCard('Star Wars: Solo', '2018', 'https://example.com/solo.jpg', 7.2),
                movieCard('Red Sparrow', '2018', 'https://example.com/red_sparrow.jpg', 6.6),
                movieCard('Tomb Raider', '2018', 'https://example.com/tomb_raider.jpg', 6.7),
                movieCard('Bad Samaritan', '2018', 'https://example.com/bad_samaritan.jpg', 6.3),
                movieCard('Jurassic World', '2018', 'https://example.com/jurassic_world.jpg', 8.3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget movieCard(String title, String year, String imageUrl, double rating) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(imageUrl, height: 200, width: 130, fit: BoxFit.cover),
          ),
          SizedBox(height: 10),
          Text(title, style: TextStyle(color: Colors.white)),
          Text(year, style: TextStyle(color: Colors.grey)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.yellow, size: 16),
              Text(rating.toString(), style: TextStyle(color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }
}
