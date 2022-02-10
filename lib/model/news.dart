import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  final String? title;
  final String? description;
  final String? urlToImage;
  final Timestamp? publishedAt;
  final String? content;
  final String? url;
  final String? author;
  final String? name;
  final String? category;
  News({
    this.name,
    this.category,
    this.title,
    this.author,
    this.description,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'author': author,
      'content': content,
      'url': url,
      'name': name,
      'category': category
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      description: map['description'] ?? '',
      urlToImage: map['urlToImage'] ?? '',
      name: map['name'] ?? '',
      category: map['category'],
      publishedAt:
          Timestamp.fromDate(DateTime.parse((map['publishedAt'] ?? ''))),
      content: map['content'] ?? '',
      url: map['url'],
    );
  }

  factory News.fromSnapshot(Map<String, dynamic> map) {
    return News(
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      description: map['description'] ?? '',
      urlToImage: map['urlToImage'] ?? '',
      publishedAt: map['publishedAt'] ?? '',
      name: map['name'] ?? '',
      category: map['category'],
      content: map['content'] ?? '',
      url: map['url'],
    );
  }
}
