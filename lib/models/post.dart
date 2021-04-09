
class PostModel {
   String id;
   String category;
   String user;
   String title;
   String description;
   String phone;
   String email;
   String location;
   int price;
   String currency;
   String firstimage;
   String date;

  PostModel({this.id,this.category,this.user,this.title,this.description,this.phone,this.email,this.location,this.price,this.currency,this.firstimage,this.date});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      category: json['category']["title"],
      user: json['user'],
      title: json['title'],
      description: json['description'],
      phone: json['phone'],
      email: json['email'],
      location: json['location'],
      price: json['price'],
      currency: json['currency'],
      firstimage: json['firstimage'],
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