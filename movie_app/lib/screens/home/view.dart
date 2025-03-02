import 'package:cached_network_image/cached_network_image.dart';
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topBanner(),
            SizedBox(height: 20),
            // Categories Bar
            Obx(() => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: logic.categories.map((category) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () => logic.selectedCategory.value = category,
                          child: Chip(
                            backgroundColor:
                                logic.selectedCategory.value == category
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

            // Hollywood Movies Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Hollywood",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(height: 20),

            // Hollywood Movies List (Horizontal)
            SizedBox(
              height: 350, // FIXED HEIGHT instead of Expanded
              child: Obx(() => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        logic.hollywood.length > 20
                            ? 20
                            : logic.hollywood.length,
                        (index) {
                          return movieCard(
                            logic.hollywood[index]['title'],
                            logic.hollywood[index]['year'],
                            logic.hollywood[index]['image'],
                            logic.hollywood[index]['rating'],
                          );
                        },
                      ),
                    ),
                  )),
            ),

            SizedBox(height: 10),

            // Bollywood Movies Section (or another category)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Bollywood",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(height: 20),

            // Bollywood Movies List (Horizontal)
            SizedBox(
              height: 350, // FIXED HEIGHT instead of Expanded
              child: Obx(() => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        logic.bollywood.length > 20
                            ? 20
                            : logic.bollywood.length,
                        (index) {
                          return movieCard(
                            logic.bollywood[index]['title'],
                            logic.bollywood[index]['year'],
                            logic.bollywood[index]['image'],
                            logic.bollywood[index]['rating'],
                          );
                        },
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  // Movie Card Widget
  Widget movieCard(String title, String year, String imageUrl, dynamic rating) {
    double parsedRating = (rating is num) ? rating.toDouble() : 0.0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 200,
              width: 130,
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error, color: Colors.red),
            ),
          ),
          SizedBox(height: 10),
          Text(title,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text(year, style: TextStyle(color: Colors.grey)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.yellow, size: 16),
              Text(parsedRating.toString(),
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }

  // Top Banner Movie
  Widget topBanner() {
    return Stack(
      children: [
        SizedBox(
          height: 630,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl:
                'https://upload.wikimedia.org/wikipedia/en/5/54/Solo_A_Star_Wars_Story_poster.jpg',
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                Icon(Icons.error, color: Colors.red),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 20,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Solo: A Star Wars Story',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.8),
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'During an adventure into a dark criminal underworld, Han Solo meets his future co-pilot Chewbacca and Lando Calrissian.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.8),
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Watch action
                    },
                    icon: Icon(Icons.play_arrow),
                    label: Text('Watch'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.redAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(width: 15),
                  OutlinedButton.icon(
                    onPressed: () {
                      // Add to List action
                    },
                    icon: Icon(Icons.add),
                    label: Text('Add to List'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
