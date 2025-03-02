import 'package:get/get.dart';

class HomeLogic extends GetxController {
  var selectedCategory = 'Action'.obs;

  final categories = [
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Crime',
    'Comedy',
    'Documentary',
    'Drama'
  ];

  // ✅ RxList bana diya
  var hollywood = <Map<String, dynamic>>[
    {'title': 'Star Wars: Solo', 'year': '2018', 'image': 'https://upload.wikimedia.org/wikipedia/en/5/54/Solo_A_Star_Wars_Story_poster.jpg', 'rating': 7.2},
    {'title': 'Red Sparrow', 'year': '2018', 'image': 'https://upload.wikimedia.org/wikipedia/en/5/5a/Red_Sparrow.png', 'rating': 6.6},
    {'title': 'Jurassic World', 'year': '2018', 'image': 'https://upload.wikimedia.org/wikipedia/en/c/c6/Jurassic_World_Fallen_Kingdom.png', 'rating': 8.3},
    {'title': 'Avengers: Infinity War', 'year': '2018', 'image': 'https://upload.wikimedia.org/wikipedia/en/4/4d/Avengers_Infinity_War_poster.jpg', 'rating': 8.5},
    {'title': 'Deadpool 2', 'year': '2018', 'image': 'https://upload.wikimedia.org/wikipedia/en/c/cf/Deadpool_2_poster.jpg', 'rating': 8.0},
    {'title': 'Ant-Man and the Wasp', 'year': '2018', 'image': 'https://upload.wikimedia.org/wikipedia/en/2/2c/Ant-Man_and_the_Wasp_poster.jpg', 'rating': 7.1},
    {'title': 'Fantastic Beasts: The Crimes ', 'year': '2018', 'image': 'https://upload.wikimedia.org/wikipedia/en/3/3c/Fantastic_Beasts_-_The_Crimes_of_Grindelwald_Poster.png', 'rating': 6.5},
  ].obs; // ✅ .obs lagaya

  var bollywood = <Map<String, dynamic>>[
    {'title': 'Dangal', 'year': '2016', 'image': 'https://upload.wikimedia.org/wikipedia/en/9/99/Dangal_Poster.jpg', 'rating': 8.4},
    {'title': 'PK', 'year': '2014', 'image': 'https://upload.wikimedia.org/wikipedia/en/c/c3/PK_poster.jpg', 'rating': 8.1},
  ].obs; // ✅ .obs lagaya
}
