import 'package:ct_hunt/widgets/DefaultText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Success extends StatelessWidget {
  static const String routeName = '/success';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DefaultText(value: "Success"),
      ),
      body: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              Image.network(
                'https://png.pngtree.com/png-clipart/20190604/original/pngtree-win-trophies-png-image_965183.jpg',
                width: 500,
                fit: BoxFit.cover,
              ),
              Notice()
            ],
          )
      ),
    );
  }
}

class Notice extends StatefulWidget {
  @override
  _NoticeFormState createState() => _NoticeFormState();
}

class _NoticeFormState extends State<Notice> {
  final _formKey = GlobalKey<FormState>();
  String rating;
  String comment;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          RatingBar.builder(
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
              // model.rating = rating;
            },
          ),
          DefaultText(
            value: 'Commentaire',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            margin: EdgeInsets.only(top: 50),
          ),
          Padding(
            child: TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Commentaire manquant';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Commentaire',
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
          ),
          RaisedButton(
            onPressed: () {
              print('fjv');
              // print(_formKey.currentState);
            },
            child: Icon(
              Icons.send_rounded,
              color: Colors.orange,
              size: 20,
            ),
          )
        ])
    );
  }
}
