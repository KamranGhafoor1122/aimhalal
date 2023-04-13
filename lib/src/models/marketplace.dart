class MarketPlace {
  bool status;
  List<Data> data;

  MarketPlace({this.status, this.data});

  MarketPlace.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String userId;
  String name;
  String category;
  String price;
  String location;
  String description;
  List<String> images;
  String status;
  String createdDate;

  Data(
      {this.id,
        this.userId,
        this.name,
        this.category,
        this.price,
        this.location,
        this.description,
        this.images,
        this.status,
        this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    category = json['category'];
    price = json['price'];
    location = json['location'];
    description = json['description'];
    images = json['images'].cast<String>();
    status = json['status'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['category'] = this.category;
    data['price'] = this.price;
    data['location'] = this.location;
    data['description'] = this.description;
    data['images'] = this.images;
    data['status'] = this.status;
    data['created_date'] = this.createdDate;
    return data;
  }
}