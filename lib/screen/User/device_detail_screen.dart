import 'package:flutter/material.dart';
import 'package:proj/color.dart';
import 'package:proj/model/device_data.dart';
import 'package:proj/model/item_fav.dart';
import 'package:proj/screen/User/search_screen.dart';
import 'package:proj/widget/showTitle.dart';

import '../../components/Loading.dart';
import '../../model/DeviceDetailModel.dart';
import '../../services/DeviceService.dart';
import '../../services/FavoriteService.dart';

class DeviceDetailScreen extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  final String email;

  const DeviceDetailScreen({
    Key? key,
    required this.id,
    required this.image,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  _DeviceDetailScreenState createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  List<Map<String, dynamic>> _allDevice = devices;
  List<Map<String, dynamic>> _favDeviceList = [];
  bool toggle = false;
  bool isLoading = false;
  DeviceDetailModel deviceDetail = DeviceDetailModel(
      id: '', favorite: "0", description: '', accession: '', location: []);

  @override
  void initState() {
    getDeviceDetail();
    super.initState();
  }

  void getDeviceDetail() async {
    setState(() {
      isLoading = true;
    });
    var response = await DeviceDetailService(widget.id);
    setState(() {
      deviceDetail = response;
      if (deviceDetail.favorite == "0") {
        toggle = false;
      } else {
        toggle = true;
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                // Here we changing the icon.
                toggle = !toggle;
              });
              if (toggle == true) {
                await updateFavoriteService(widget.id, "1");
              } else {
                await updateFavoriteService(widget.id, "0");
              }
            },
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
      body: isLoading
          ? LoadingCircle()
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 46,
                    ),
                    Image.asset(
                      widget.image,
                      cacheWidth: 200,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(deviceDetail.id,
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
                                  text: deviceDetail.description,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black))
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'ผู้มีสิทธิ์ยืม : นักศึกษา อาจารย์ บุคลากรมหาวิทยาลัยขอนแก่น',
                            style: Theme.of(context).textTheme.bodyText1, 
                            children: <TextSpan>[
                              TextSpan(
                                  text: deviceDetail.accession,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black))
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'ระยะการยืม : ',
                            style: Theme.of(context).textTheme.bodyText1,
                            children: const <TextSpan>[
                              TextSpan(
                                  text: '1 วัน',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black))
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'สถานที่อื่นที่มีอุปกรณ์นี้ : ',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 15.0,
                      runSpacing: 6.0,
                      children: List.generate(
                        deviceDetail.location.length,
                        (index) {
                          return ActionChip(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchScreen(
                                            name: widget.name,
                                            email: widget.email,
                                            thname: deviceDetail
                                                .location[index].locationName,
                                          )));
                            },
                            labelPadding: const EdgeInsets.all(2.0),
                            avatar: CircleAvatar(
                              backgroundColor: Colors.white70,
                              child: Text(deviceDetail.location[index].count
                                  .toString()),
                            ),
                            label: Text(
                              deviceDetail.location[index].locationName,
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
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
