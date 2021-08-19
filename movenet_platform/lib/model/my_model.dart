/*class Model {
  double? score;
  List<Keypoints>? keypoints;

  Model({this.score, this.keypoints});

  Model.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    if (json['keypoints'] != null) {
      keypoints = List<Keypoints>.of([]);
      json['keypoints'].forEach((v) {
        keypoints!.add(new Keypoints.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['score'] = this.score;
    if (this.keypoints != null) {
      data['keypoints'] = this.keypoints!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Keypoints {
  int? x;
  int? y;
  double? score;
  String? name;

  Keypoints({this.x, this.y, this.score, this.name});

  Keypoints.fromJson(Map<String, dynamic> json) {
    x = json['x'];
    y = json['y'];
    score = json['score'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    data['score'] = this.score;
    data['name'] = this.name;
    return data;
  }
}
*/
