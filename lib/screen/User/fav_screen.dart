import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:proj/color.dart';
import 'package:proj/screen/User/profile_screen.dart';
import 'package:proj/screen/User/search_screen.dart';

import '../../components/Loading.dart';
import '../../model/DeviceModel.dart';
import '../../services/FavoriteService.dart';
import 'device_detail_screen.dart';

class FavScreen extends StatefulWidget {
  final String name;
  final String email;
  const FavScreen({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  List<DeviceModel> devices = [];
  bool isLoading = false;
  @override
  void initState() {
    getFavorite();
    super.initState();
  }

  void getFavorite() async {
    setState(() {
      isLoading = true;
    });
    var response = await FavoriteService();
    setState(() {
      devices = response;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                MaterialPageRoute(
                    builder: (context) => SearchScreen(
                          name: widget.name,
                          email: widget.email,
                        )),
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
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                            name: widget.name,
                            email: widget.email,
                          )),
                );
              }),
        ],
      ),
      body: isLoading
          ? LoadingCircle()
          : SingleChildScrollView(
              child: Column(
              children: [
                for (var i = 0; i < devices.length; i++)
                  cardItem(
                      devices[i].image,
                      devices[i].id,
                      devices[i].totalAvailable.toString(),
                      devices[i].duration),
              ],
            )),
    );
  }

  Widget cardItem(
      String img, String name, String totalAvailable, String duration) {
    double sizeName = MediaQuery.of(context).size.width * 0.05;
    double sizeDuration = MediaQuery.of(context).size.width * 0.04;
    double sizeTotal = MediaQuery.of(context).size.width * 0.045;
    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 7),
            blurRadius: 10,
            spreadRadius: 2,
            color: Color.fromARGB(197, 199, 199, 199),
          )
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DeviceDetailScreen(
                        id: name,
                        image: img,
                        name: widget.name,
                        email: widget.email,
                      )));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.2,
              child: AvatarView(
                radius: 40,
                borderColor: Colors.white,
                avatarType: AvatarType.RECTANGLE,
                backgroundColor: Colors.red,
                imagePath: img,
                placeHolder: const Icon(
                  Icons.person,
                  size: 50,
                ),
                errorWidget: const Icon(
                  Icons.error,
                  size: 50,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        color: accentColor,
                        fontSize: sizeName,
                        fontWeight: FontWeight.bold)),
                Text(
                  'ระยะการยืม : ' + duration,
                  style: TextStyle(color: timeColor, fontSize: sizeDuration),
                ),
                Text(
                  'คงเหลือทั้งหมด : ' + totalAvailable.toString(),
                  style: TextStyle(
                      color: remainColor,
                      fontSize: sizeTotal,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
