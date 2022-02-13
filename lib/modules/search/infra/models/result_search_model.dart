import 'dart:convert';

import 'package:github_search/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch{
  late String title;
  late String img;
  late String content;

  ResultSearchModel({required this.title, required this.img, required this.content}) : super(title: '', img: '', content: '');

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'content': content,
      'img': img,
    };
  }

  static ResultSearchModel fromMap(Map<String, dynamic> map) {
    return ResultSearchModel(
        title: map['title'] ?? '',
        img: map['img'] ?? '',
        content: map['content'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
}