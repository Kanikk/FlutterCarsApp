import 'package:flutter/material.dart';

List<Color> colors = const [
  Colors.red,
  Colors.blue,
  Colors.amber,
  Colors.black,
];

// ignore: must_be_immutable
class ColorPicker extends StatefulWidget {
  int index;
  final Function(int) onTap;
  ColorPicker({Key? key, required this.index, required this.onTap})
      : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              widget.index = index;
              widget.onTap(index);
              setState(() {});
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 2),
                      color: colors[index]),
                ),
                widget.index == index
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                      )
                    : Container()
              ],
            ),
          );
        },
      ),
    );
  }
}
