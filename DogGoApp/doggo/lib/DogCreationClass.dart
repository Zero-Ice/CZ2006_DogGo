import 'dart:math';

class DogCreation {
  String name;
  String favFood;
  String birthDate;
  String feedTimings;
  String food;

  DogCreation(String name, String favFood, String birthDate) {
    this.name = name;
    this.favFood = favFood;
    this.birthDate = birthDate;
    this.feedTimings = '';
    this.food = '';
  }

  String get getName {
    return name;
  }

  String get geFavFood {
    return favFood;
  }

  String get getBirthDate {
    return birthDate;
  }

  set setName(String name) {
    this.name = name;
  }

  set setFavFood(String favFood) {
    this.favFood = favFood;
  }

  set setBirthDate(String birthDate) {
    this.birthDate = birthDate;
  }

  String get getFeedTimings {
    return feedTimings;
  }

  String get getFood {
    return food;
  }

  set setTimings(String feedTimings) {
    this.feedTimings = feedTimings;
  }

  set setFood(String food) {
    this.food = food;
  }

  DogCreation.fromMap(Map map) :
        this.name = map['name'],
        this.favFood = map['favFood'],
        this.birthDate= map['birthDate'],
        this.feedTimings = map['feedTimings'],
        this.food = map['food'];

  Map toMap() {
    return {
      'name': this.name,
      'favFood': this.favFood,
      'birthDate': this.birthDate,
      'feedTimings': this.feedTimings,
      'food': this.food,
    };
  }

}