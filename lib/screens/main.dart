// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';
import 'dart:core';
import 'package:comicappver2/screens/categoryscreen.dart';
import 'package:comicappver2/screens/chapter_screen.dart';
import 'package:comicappver2/screens/history_screen.dart';
import 'package:comicappver2/screens/login_screen.dart';
import 'package:comicappver2/screens/profile_screen.dart';
import 'package:comicappver2/screens/read_screen.dart';
import 'package:comicappver2/screens/view_love_cate_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'myhomepage.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
      name: 'comicappver2',
      options: Platform.isAndroid || Platform.isIOS
          ? const FirebaseOptions(
              apiKey: 'AIzaSyB6t7FbM6OlhAu-VBmMAS6-2Jlx7M0IhkQ',
              appId: 'IOS KEY',
              messagingSenderId: '277706343592',
              projectId: 'comicapp-57fcd',
              databaseURL:
                  "https://comicapp-57fcd-default-rtdb.asia-southeast1.firebasedatabase.app")
          : const FirebaseOptions(
              apiKey: 'AIzaSyB6t7FbM6OlhAu-VBmMAS6-2Jlx7M0IhkQ',
              appId: '1:277706343592:android:7128182e3b2edd20ecee9d',
              messagingSenderId: '277706343592',
              projectId: 'comicapp-57fcd',
              databaseURL:
                  "https://comicapp-57fcd-default-rtdb.asia-southeast1.firebasedatabase.app"));
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  runApp(ProviderScope(
    child: MyApp(app: app),
  ));
}

class MyApp extends StatefulWidget {
  FirebaseApp app;
  MyApp({super.key, required this.app});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team08 Demo',
      routes: {
        '/chapters':(context)=> ChapterScreen(),
        '/read':(context)=> const ReadScreeen(),
        '/profile':(context)=> ProfileScreen(),
        '/myhome':(context)=> MyHomePage(title: 'Team08 Comic', app: widget.app),
        '/login':(context)=> LoginScreen(),
        '/category':(context)=>CategoryScreen(),
        '/viewLoveCate':(context)=>ViewLoveCate(),
        '/history':(context)=>History(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
      LoginScreen()
      // MyHomePage(
      //   title: 'Team08 Comic',
      //   app: widget.app,
      // ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title, required this.app})
//       : super(key: key);
//
//   final FirebaseApp app;
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late DatabaseReference _bannerRef, _comicRef;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     final FirebaseDatabase database =
//         FirebaseDatabase.instanceFor(app: widget.app);
//     _bannerRef = database.ref().child("Banners");
//     _comicRef = database.ref().child("Comic");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<Comic> comics = <Comic>[];
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF44A3E),
//         title: Text(
//           widget.title,
//           style: const TextStyle(color: Colors.white),
//         ),
//
//         actions: [
//           IconButton(
//               onPressed: (){
//                 showSearch(
//                     context: context,
//                     delegate: CustomSearch(comics));
//           },
//               icon: Icon(Icons.search))
//         ],
//       ),
//       drawer: MyDrawer(),
//       body:
//
//       FutureBuilder<List<String>>(
//         future: getBanners(_bannerRef),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CarouselSlider(
//                     items: snapshot.data!
//                         .map((e) => Builder(
//                               builder: (context) {
//                                 return Image.network(
//                                   e,
//                                   fit: BoxFit.cover,
//                                 );
//                               },
//                             ))
//                         .toList(),
//                     options: CarouselOptions(
//                         autoPlay: true,
//                         enlargeCenterPage: true,
//                         viewportFraction: 1,
//                         initialPage: 0,
//                         height: MediaQuery.of(context).size.height / 3)),
//                 Row(
//                   children: [
//                     Expanded(
//                       flex: 4,
//                       child: Container(
//                           color: const Color(0XFFF44A3E),
//                           child: const Padding(
//                             padding: EdgeInsets.all(8),
//                             child: Text(
//                               "New Comic",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           )),
//                     ),
//                     Expanded(
//                       flex: 1,
//                       child: SizedBox(
//                           child: ElevatedButton.icon(
//                             onPressed: (){
//                               Navigator.pushNamed(context, '/profile');
//                             },
//                             icon: Icon(Icons.person),
//                             label: Text('Pro'),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xC2000000),
//                               shadowColor: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//
//                 FutureBuilder (
//                     future: getComic(_comicRef),
//                     builder: (context, snapshot) {
//                       if (snapshot.hasError) {
//                         return Center(
//                           child: Text("${snapshot.hasError}"),
//                         );
//                       } else if (snapshot.hasData) {
//                             for (var v in snapshot.data!) {
//                               var comic= Comic.fromJson(jsonDecode(jsonEncode(v)));
//                               comics.add(comic);
//                             }
//                           return Expanded(
//                             child: GridView.count(
//                                 crossAxisCount: 2,
//                                 childAspectRatio: 0.8,
//                                 padding: const EdgeInsets.all(4.0),
//                                 mainAxisSpacing: 1.0,
//                                 crossAxisSpacing: 1.0,
//                                 children: comics.map((comic) {
//                                   return GestureDetector(
//                                     onTap: () {
//                                       Navigator.pushNamed(context, '/chapters',arguments: AgrumentScreen(comic.chapters,comic.name));
//                                     },
//                                     child: Card(
//                                         elevation: 12,
//                                         child: Stack(
//                                           fit: StackFit.expand,
//                                           children: [
//                                             Image.network(comic.image.toString(),
//                                                 fit: BoxFit.cover),
//                                             Column(
//                                               mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                               children: [
//                                                 Container(
//                                                     color:
//                                                     const Color(0XAA434343),
//                                                     padding:
//                                                     const EdgeInsets.all(8),
//                                                     child: Row(children: [
//                                                       Expanded(
//                                                         child: Text(
//                                                           comic.name.toString(),
//                                                           style: const TextStyle(
//                                                               color:
//                                                               Colors.white,
//                                                               fontWeight:
//                                                               FontWeight
//                                                                   .bold),
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                         ),
//                                                       ),
//                                                     ]))
//                                               ],
//                                             ),
//                                           ],
//                                         )),
//                                   );
//                                 }).toList()));
//                       }
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     })
//
//               ],
//             );
//           } else if (snapshot.hasError)
//             return Center(
//               child: Text("${snapshot.hasError}"),
//             );
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//
//     );
//   }
//
//   Future<List<dynamic>> getComic(DatabaseReference comicRef){
//     return comicRef.once().then((event) =>
//         (event.snapshot.value as List<dynamic>)
//     );
//   }
//
//
//   Future<List<String>> getBanners(DatabaseReference bannerRef) {
//     return bannerRef.once().then((event) =>
//         (event.snapshot.value as List<dynamic>).cast<String>().toList());
//   }
// }


