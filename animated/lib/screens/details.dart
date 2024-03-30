import 'package:flutter/material.dart';

import 'package:lorem_ipsum/lorem_ipsum.dart';
import '../models/Trip.dart';
import '../shared/heart.dart';

class Details extends StatelessWidget {
  final Trip trip;
  const Details({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'location-img-${trip.img}',
                child: ClipRRect(
                    child: Image.asset(
                  'images/${trip.img}',
                  height: 360,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                )),
              ),
              const SizedBox(height: 30),
              ListTile(
                  title: Text(trip.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.grey[800])),
                  subtitle: Text(
                      '${trip.nights} night stay for only \$${trip.price}',
                      style: const TextStyle(letterSpacing: 1)),
                  trailing: Heart()),
              Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                      loremIpsum(words: 60, paragraphs: 1, initWithLorem: true),
                      style: TextStyle(color: Colors.grey[600], height: 1.4))),
            ],
          ),
        ));
  }
}
