class DogCreation {
  String name;
  String favFood;
  String birthDate;

  DogCreation(String name,String favFood,String birthDate) {
    this.name = name;
    this.favFood=favFood;
    this.birthDate=birthDate;
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

  DogCreation.fromMap(Map map) :
        this.name = map['name'],
        this.favFood = map['favFood'],
        this.birthDate= map['birthDate'];

  Map toMap(){
    return {
      'name': this.name,
      'favFood': this.favFood,
      'birthDate': this.birthDate,
    };
  }

}