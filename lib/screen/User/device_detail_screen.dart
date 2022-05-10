import 'package:flutter/material.dart';
import 'package:proj/color.dart';
import 'package:proj/model/device_data.dart';
import 'package:proj/model/item_fav.dart';
import 'package:proj/screen/User/search_screen.dart';
import 'package:proj/widget/showTitle.dart';

class DeviceDetailScreen extends StatefulWidget {
  final int id;
  final String img;
  final String name;
  final String borrower;
  final String time;
  final List allremain;
  final List re_faculty;

  const DeviceDetailScreen(
      {Key? key,
      required this.id,
      required this.img,
      required this.name,
      required this.borrower,
      required this.time,
      required this.allremain,
      required this.re_faculty})
      : super(key: key);

  @override
  _DeviceDetailScreenState createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  List<Map<String, dynamic>> _allDevice = devices;
  List<Map<String, dynamic>> _favDeviceList = [];
  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    // var favBloc = List.of(FavoriteBloc());

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: showTitle(),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
          color: kPrimaryColor,
          //iconSize: 24,
          onPressed: () {
            Navigator.pop(context)
                // push(context,
                //     MaterialPageRoute(builder: (context) => FirstScreen()))
                ;
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              ItemModel itemModel = new ItemModel(
                leading: widget.img,
                title: widget.name,
                subTitle: widget.time,
              );

              // favBloc.addItems(itemModel);
              print(widget.name);

              setState(() {
                // Here we changing the icon.
                toggle = !toggle;
                // _favDeviceList.add(_allDevice[index]);
              });
            },
            // onPressed: () {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => FavScreen()));
            // },
            icon: toggle
                ? const Icon(
                    Icons.favorite,
                    color: kPrimaryColor,
                  )
                : const Icon(
                    Icons.favorite_border,
                    color: kPrimaryColor,
                  ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 46,
              ),
              Image.asset(
                widget.img,
                cacheWidth: 200,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(widget.name,
                  style: const TextStyle(
                      color: accentColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'รายละเอียด : ',
                      style: Theme.of(context).textTheme.bodyText1,
                      // style:
                      // TextStyle(
                      //     color: kPrimaryColor,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            text: widget.name,
                            style: const TextStyle(fontSize: 16, color: Colors.black))
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'ผู้มีสิทธิ์ยืม : ',
                      style: Theme.of(context).textTheme.bodyText1,
                      // TextStyle(
                      //     color: kPrimaryColor,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                            text: widget.borrower,
                            style: const TextStyle(fontSize: 16, color: Colors.black))
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'ระยะการยืม : ',
                      style: Theme.of(context).textTheme.bodyText1,
                      // TextStyle(
                      //   color: kPrimaryColor,
                      //   fontWeight: FontWeight.bold,
                      //   fontSize: 16,
                      // ),
                      children: <TextSpan>[
                        TextSpan(
                            text: widget.time + ' วัน',
                            style: const TextStyle(fontSize: 16, color: Colors.black))
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'สถานที่อื่นที่มีอุปกรณ์นี้ : ',
                      style: Theme.of(context).textTheme.bodyText1,
                      // TextStyle(
                      //     color: kPrimaryColor,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 16),
                      // children: <TextSpan>[
                      //   TextSpan(text: widget.name, style: TextStyle(fontSize: 16))
                      // ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                  spacing: 15.0,
                  runSpacing: 6.0,
                  children: List.generate(
                    widget.allremain.length,
                    (index) {
                      return ActionChip(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SearchScreen()));
                        },
                        labelPadding: const EdgeInsets.all(2.0),
                        avatar: CircleAvatar(
                          backgroundColor: Colors.white70,
                          child: Text(widget.allremain[index]),
                        ),
                        label: Text(
                          widget.re_faculty[index],
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        backgroundColor: Colors.white,
                        elevation: 6.0,
                        shadowColor: kPrimaryColor,
                        // Colors.grey[60],
                        padding: const EdgeInsets.all(8.0),
                      );
                    },
                  ))
              // chipList(),
              // SizedBox(
              //   child: AppsButton.button(
              //       label: "เพิ่มในรายการโปรด",
              //       onPressed: () {
              //         Navigator.push(context,
              //             MaterialPageRoute(builder: (context) => FavScreen()));
              //       }),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}