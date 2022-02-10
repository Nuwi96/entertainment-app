import 'package:education_app/ui/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieView extends StatefulWidget {
  final data;

  const MovieView({Key key, this.data}) : super(key: key);

  @override
  _MovieViewState createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        backgroundColor: Color(0xff00008B),
      ),
      body: Container(
        // child: Center(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: ListTile(
                  //leading: Icon(Icons.music_note),
                  title: Text(
                      (null != widget.data['title'])
                          ? widget.data['title']
                          : 'No Title Available',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w300)),
                ),
                elevation: 8,
                shadowColor: Colors.lightBlueAccent,
                margin: EdgeInsets.all(5),
              ),
              (null != widget.data['image'])
                  ? Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget.data['image']),
                  ),
                ),
              )
                  : Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://media.istockphoto.com/vectors/no-image-available-icon-vector-id1216251206?k=20&m=1216251206&s=612x612&w=0&h=BANco7qp0Ofqkod-ODPsbZVqVok7R5qUSznMN0AsMx8='),
                  ),
                ),
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                shadowColor: Colors.lightBlueAccent,
                child: Column(
                  children: [
                    Text(
                        (null != widget.data['popularity'])
                            ? ('Popularity :' + widget.data['popularity'])
                            : 'No Popularity Available',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w900)),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        widget.data['description'],
                        style: TextStyle(
                            fontSize: 15, color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // ),
        ),
      ),
    );
  }
}
