import 'package:flutter/material.dart';
import 'package:proj/color.dart';
import 'package:proj/screen/Admin/create_acc_screen.dart';
import 'package:proj/screen/Admin/home_screen.dart';

class ManageAdminScreen extends StatefulWidget {
  final String name;
  final String email;
  const ManageAdminScreen({Key? key, required this.name, required this.email})
      : super(key: key);

  @override
  State<ManageAdminScreen> createState() => _ManageAdminScreenState();
}

class _ManageAdminScreenState extends State<ManageAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "จัดการผู้ดูแล",
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
          color: kPrimaryColor,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomeAdminScreen(
                name: widget.name,
                email: widget.email,
              );
            }));
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                children: <Widget>[
                  Card(
                    color: Colors.white,
                    elevation: 6,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: const Text("มานี มานะ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            // fontWeight: FontWeight.bold
                          )),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 6,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: const Text("แก้วกล้า ชูใจ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            // fontWeight: FontWeight.bold
                          )),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 6,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: const Text("ก้านกล้วย",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            // fontWeight: FontWeight.bold
                          )),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateAccScreen(),
            ),
          );
        },
        // tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
