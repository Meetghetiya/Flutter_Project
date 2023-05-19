// class Apimodel {
//   Apimodel({
//     required this.userId,
//     required this.id,
//     required this.title,
//     required this.body,
//   });

//   Apimodel.fromJson(dynamic json) {
//     userId = json['userId'];
//     id = json['id'];
//     title = json['title'];
//     body = json['body'];
//   }
//   late int userId;
//   late int id;
//   late String title;
//   late String body;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['userId'] = userId;
//     map['id'] = id;
//     map['title'] = title;
//     map['body'] = body;
//     return map;
//   }
// }

class Apimodel {
  Apimodel({
    this.createdAt,
    this.name,
    this.avatar,
    this.material,
    this.rating,
    this.price,
    this.color,
    this.details,
    this.height,
    this.id,
  });

  Apimodel.fromJson(dynamic json) {
    createdAt = json['createdAt'];
    name = json['name'];
    avatar = json['avatar'];
    material = json['material'];
    rating = json['rating'];
    price = json['price'];
    color = json['color'];
    details = json['Details'];
    height = json['height'];
    id = json['id'];
  }
  String createdAt;
  String name;
  String material;
  String avatar;
  String rating;
  int price;
  String color;
  String details;
  String height;
  String id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createdAt'] = createdAt;
    map['name'] = name;
    map['avatar'] = avatar;
    map['material'] = material;
    map['rating'] = rating;
    map['price'] = price;
    map['color'] = color;
    map['Details'] = details;
    map['height'] = height;
    map['id'] = id;
    return map;
  }
}
