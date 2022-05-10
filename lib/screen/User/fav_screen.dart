import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:proj/color.dart';
import 'package:proj/screen/User/profile_screen.dart';
import 'package:proj/screen/User/search_screen.dart';

class FavScreen extends StatefulWidget {
  // final int id;
  // final String img;
  // final String name;
  // final String time;
  // final List allremain;

  const FavScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {

  @override
  Widget build(BuildContext context) {
    // var favBloc;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "รายการโปรด",
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
          // remove back button
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              color: kPrimaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
            ),
            IconButton(
                icon: const Icon(Icons.account_circle),
                iconSize: 24,
                color: kPrimaryColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileScreen()),
                  );
                }),
          ],
        ),
        // body: Center(
        //   child: Padding(
        //     padding: const EdgeInsets.all(20.0),
        //     child: Column(
        //         // mainAxisAlignment: MainAxisAlignment.center,
        //         children: <Widget>[
        //           ListView.builder(
        //             // itemCount: favBloc.items.length,
        //             itemBuilder: (context, index) => Padding(
        //               padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        //               child: Container(
        //                 height: 170,
        //                 child: Card(
        //                   color: Colors.white,
        //                   elevation: 6,
        //                   margin: const EdgeInsets.symmetric(vertical: 10),
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       ListTile(
        //                           leading: AvatarView(
        //                             radius: 40,
        //                             borderColor: Colors.white,
        //                             avatarType: AvatarType.RECTANGLE,
        //                             backgroundColor: Colors.red,
        //                             // imagePath: favBloc.items[index].leading,
        //                             placeHolder: Container(
        //                               child: const Icon(
        //                                 Icons.person,
        //                                 size: 50,
        //                               ),
        //                             ),
        //                             errorWidget: Container(
        //                               child: const Icon(
        //                                 Icons.error,
        //                                 size: 50,
        //                               ),
        //                             ),
        //                           ),
        //                           title: const Text('555555',
        //                             // favBloc.items[index].title,
        //                               style: TextStyle(
        //                                   color: accentColor,
        //                                   fontSize: 20,
        //                                   fontWeight: FontWeight.bold)),
        //                           subtitle: Column(
        //                             crossAxisAlignment:
        //                                 CrossAxisAlignment.start,
        //                             children: const <Widget>[
        //                               Text('66666',
        //                                 // favBloc.items[index].title,
        //                                 style: TextStyle(
        //                                     color: timeColor, fontSize: 14),
        //                               ),
        //                               Text(
        //                                 'คงเหลือทั้งหมด : 40',
        //                                 style: TextStyle(
        //                                     color: remainColor,
        //                                     fontSize: 18,
        //                                     fontWeight: FontWeight.bold),
        //                               )
        //                             ],
        //                           ),
        //                           // trailing: Icon(Icons.close),
        //                           onTap: () {
        //                             // Navigator.push(
        //                             //     context,
        //                             //     MaterialPageRoute(
        //                             //         builder: (context) =>
        //                             //             DetailScreen()));
        //                           })
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           )
        //         ]),
        //   ),
        // )
        );
  }
}