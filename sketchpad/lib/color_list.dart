import 'package:flutter/material.dart';

class ColorList extends StatefulWidget {
  final List<Color> colors;
  final int index;
  final ValueChanged<int> onChange;

  const ColorList({
    Key key,
    @required this.colors,
    this.index,
    this.onChange,
  }) : super(key: key);

  @override
  _ColorListState createState() => _ColorListState();
}

class _ColorListState extends State<ColorList> {
  int selectedIndex = 0;

  List<Color> get colors => widget.colors;

  @override
  void initState() {
    selectedIndex = widget.index ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(colors.length, (index) {
        return GestureDetector(
          onTap: () => _onChange(index),
          child: _buildItem(index),
        );
      }),
    );
  }

  void _onChange(int index) {
    selectedIndex = index;
    widget.onChange?.call(selectedIndex);
    setState(() {});
  }

  Widget _buildItem(int index) {
    final bool selected = selectedIndex == index;
    final double size = selected ? 50 : 35;
    return Container(
      width: 50,
      height: 50,
      child: Center(
        child: ClipOval(
          child: Container(
            height: size,
            width: size,
            color: colors[index],
          ),
        ),
      ),
    );
  }
}
