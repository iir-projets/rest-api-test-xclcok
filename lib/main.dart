import 'package:flutter/material.dart';
import 'package:atelier4_m_elhammoui_iir5g2/Post.dart';
import 'package:atelier4_m_elhammoui_iir5g2/PostRepository.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'Rest Api',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title:'Rest Api'),
    );
  }
}
class MyHomePage extends StatefulWidget{
  MyHomePage({Key? key,required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage>{
  final PostRepository _postRepository = PostRepository();
  late Future<List<Post>> _posts;
  @override
  void initState(){
    super.initState();
    _posts = _postRepository.fetchPosts();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Post>>(
        future: _posts,
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text(snapshot.data![index].title),
                  subtitle: Text(snapshot.data![index].body),
                );
              },
            );
          }else if(snapshot.hasError){
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}