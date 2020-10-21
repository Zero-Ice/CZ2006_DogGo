class HotlineCreation{
  String name;
  String hotline;

  HotlineCreation(String name, String hotline) {
    this.name = name;
    this.hotline = hotline;
  }

  String get getName {
    return name;
  }

  String get getHotline {
    return hotline;
  }

  set setName(String name) {
    this.name = name;
  }

  set setHotline(String hotline) {
    this.hotline = hotline;
  }

  HotlineCreation.fromMap(Map map) :
        this.name = map['name'],
        this.hotline = map['hotline'];

  Map toMap(){
    return {
      'name': this.name,
      'hotline': this.hotline,
    };
  }

}