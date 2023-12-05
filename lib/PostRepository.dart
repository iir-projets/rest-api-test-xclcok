import 'dart:math';

import 'package:atelier4_m_elhammoui_iir5g2/Post.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PostRepository{
  Future<List<Post>> fetchPosts() async {
    final response=
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if(response.statusCode==200){
      List<dynamic> jsonPosts = json.decode(response.body);
      List<Post> posts = jsonPosts.map((json) => Post.fromJson(json)).toList();
      return posts;
  }else{
    throw Exception('Failed to load posts');
  }
  }
Future<void> deletePost(int id) async{
final response = await http
.delete (Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));
if(response.statusCode != 200){
  throw Exception('Failed to delete post');
}
}
Future<Post> addPost(Post post) async{
  final response = await http.post(Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  headers: <String,String>{
    'Content-Type':'application/json; charset=UTF-8',
  },
  body: jsonEncode(<String,dynamic>{
    'title':post.title,
    'body':post.body,
  }),
  );
  if(response.statusCode == 201){
    return Post.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to create post');
  }
}
Future<Post> updatePost(Post post) async{
  final response = await http.put(Uri.parse('https://jsonplaceholder.typicode.com/posts/${post.id}'),
  headers: <String,String>{
    'Content-Type':'application/json; charset=UTF-8',
  },
  body: jsonEncode(<String,dynamic>{
    'id':post.id,
    'title':post.title,
    'body':post.body,
  }),
  );
  if(response.statusCode == 200){
    return Post.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to update post');
  }
}
}