class FoodModel {
  bool status;
  List<Data> data;

  FoodModel({this.status, this.data});

  FoodModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
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
  dynamic id;
  dynamic userId;
  String title;
  String type;
  dynamic price;
  String contactNumber;
  String details;
  String location;
  String packing;
  String servingFor;
  String validDate;
  List<String> images;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
        this.userId,
        this.title,
        this.type,
        this.price,
        this.contactNumber,
        this.details,
        this.location,
        this.packing,
        this.servingFor,
        this.validDate,
        this.images,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    type = json['type'];
    price = json['price'];
    contactNumber = json['contact_number'];
    details = json['details'];
    location = json['location'];
    packing = json['packing'];
    servingFor = json['serving_for'];
    validDate = json['valid_till_date_time'];
    images = json['images'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['type'] = this.type;
    data['price'] = this.price;
    data['contact_number'] = this.contactNumber;
    data['details'] = this.details;
    data['location'] = this.location;
    data['images'] = this.images;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}