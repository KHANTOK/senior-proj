import 'package:flutter/material.dart';
import 'package:proj/color.dart';

class choiceChipWidget extends StatefulWidget {
  final List<String> reportList;

  choiceChipWidget(this.reportList);

  @override
  _choiceChipWidgetState createState() => new _choiceChipWidgetState();
}

class _choiceChipWidgetState extends State<choiceChipWidget> {
  String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: const TextStyle(
              color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Colors.grey,
          // Color(0xffededed),
          selectedColor: kPrimaryColor,
          // Color(0xffffc107),
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 5.0,
      children: _buildChoiceList(),
    );
  }
}