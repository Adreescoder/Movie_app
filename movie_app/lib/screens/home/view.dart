import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';



class MovieController extends GetxController {
  var trendingMovies = [].obs;
  var topRatedMovies = [].obs;
  final String apiKey = "YOUR_TMDB_API_KEY";

  Future<void> fetchMovies() async {
    try {
      var trendingResponse = await Dio().get("https://api.themoviedb.org/3/trending/movie/week?api_key=$apiKey");
      var topRatedResponse = await Dio().get("https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey");

      trendingMovies.value = trendingResponse.data['results'];
      topRatedMovies.value = topRatedResponse.data['results'];
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void onInit() {
    fetchMovies();
    super.onInit();
  }
}



class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final MovieController controller = Get.put(MovieController());

  static List<Widget> _pages = <Widget>[
    HomeScreen(),
    Center(child: Text("Search Screen", style: TextStyle(color: Colors.white))),
    Center(child: Text("Profile Screen", style: TextStyle(color: Colors.white))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final MovieController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Netflix Clone"), backgroundColor: Colors.black),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle("Trending Movies"),
            MovieList(controller.trendingMovies),
            SectionTitle("Top Rated Movies"),
            MovieList(controller.topRatedMovies),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(title, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}

class MovieList extends StatelessWidget {
  final RxList movies;
  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return movies.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            var movie = movies[index];
            return GestureDetector(
              onTap: () {
                Get.to(() => MovieDetailScreen(movie));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://image.tmdb.org/t/p/w500" + movie['poster_path'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

class MovieDetailScreen extends StatelessWidget {
  final dynamic movie;
  MovieDetailScreen(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie['title']), backgroundColor: Colors.black),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network("https://image.tmdb.org/t/p/w500" + movie['backdrop_path']),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(movie['overview'], style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
