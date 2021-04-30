
import 'dart:typed_data';

class PostModel {
   String? id;
   String category;
   String? user;
   String title;
   String description;
   String phone;
   String email;
   String location;
   int price;
   String currency;
   Uint8List firstimage;
   String? date;

  PostModel({this.id,required this.category,this.user,required this.title,required this.description,required this.phone,required this.email,required this.location,required this.price,required this.currency,required this.firstimage,this.date});

  factory PostModel.fromJson(Map<String, dynamic> json,Uint8List image) {
    return PostModel(
      id: json['_id'],
      category: json['category']["title"],
      user: json['user'],
      title: json['title'],
      description: json['description'],
      phone: json['phone'],
      email: json['email'],
      location: json['location'],
      price: json['price'],
      currency: json['currency'],
      firstimage: image,
      date: json['date']
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'category':category,
    'user': user,
    'title': title,
    'description': description,
    'phone': phone,
    'email': email,
    'location': location,
    'price': price,
    'currency': currency,
    'firstimage': firstimage,
    'date': date
  };

}