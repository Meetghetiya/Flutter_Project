class cartapi {
  String name;
  String avatar;
  String material;
  String rating;
  String price;
  String color;
  String detail;
  String id;
  String details;

  cartapi(
      {this.name,
      this.avatar,
      this.material,
      this.rating,
      this.price,
      this.color,
      this.detail,
      this.id,
      this.details});

  cartapi.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    material = json['material'];
    rating = json['rating'];
    price = json['price'];
    color = json['color'];
    detail = json['detail'];
    id = json['id'];
    details = json['Details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['material'] = this.material;
    data['rating'] = this.rating;
    data['price'] = this.price;
    data['color'] = this.color;
    data['detail'] = this.detail;
    data['id'] = this.id;
    data['Details'] = this.details;
    return data;
  }
}
