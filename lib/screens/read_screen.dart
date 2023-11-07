import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../state/agrument.dart';

class ReadScreeen extends StatelessWidget{
  const ReadScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    final args=ModalRoute.of(context)?.settings.arguments as AgrumentScreenRead;
    return Scaffold(
        appBar: AppBar(
        backgroundColor: const Color(0xFFF44A3E),
          title: Center(
            child: Text('${args.name}'),
    ),
    ),
      body: Center(
          child: CarouselSlider(items: args.links.map<Widget>((e) => Builder(builder: (context){
                return Image.network(e, fit: BoxFit.cover,);
                })).toList(),
                    options: CarouselOptions(
                      autoPlay: false,
                      height: MediaQuery.of(context).size.height,
                      enlargeCenterPage: false,
                      viewportFraction: 1,
                      initialPage: 0,
                      scrollDirection: Axis.vertical
                    )
                )

      ),
    );
  }}