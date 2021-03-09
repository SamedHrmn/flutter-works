class Motto {
  String? userID, mottoID, name, motto;

  Motto.setMotto({String? userID, String? mottoID, String? name, String? motto}) {
    this.userID = userID;
    this.mottoID = mottoID;
    this.name = name;
    this.motto = motto;
  }

  Motto.fromMap(Map<String, dynamic> map) {
    this.userID = map['userID'];
    this.mottoID = map['mottoID'];
    this.name = map['name'];
    this.motto = map['motto'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['userID'] = this.userID;
    map['mottoID'] = this.mottoID;
    map['name'] = this.name;
    map['motto'] = this.motto;
    return map;
  }
}
