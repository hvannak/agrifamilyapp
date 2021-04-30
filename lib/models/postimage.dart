
class PostImageModel {
   String? id;
   List<int>? image;
   String post;
   String? date;

  PostImageModel({this.id,required this.post,this.date,this.image});

  factory PostImageModel.fromJson(Map<String, dynamic> json) {
    return PostImageModel(
      id: json['_id'],
      image: json['image'],
      post: json['post'],
      date: json['date']
    );
  }

}