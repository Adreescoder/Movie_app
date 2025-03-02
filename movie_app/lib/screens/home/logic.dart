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
}
