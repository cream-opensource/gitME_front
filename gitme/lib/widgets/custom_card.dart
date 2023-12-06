import 'package:flutter/material.dart';

class DraggableText extends StatefulWidget {
  final String text;

  DraggableText({super.key, required this.text});

  @override
  _DraggableTextState createState() => _DraggableTextState();
}

class _DraggableTextState extends State<DraggableText> {
  Offset position = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        feedback: Text(widget.text),
        child: Text(widget.text),
        onDraggableCanceled: (Velocity velocity, Offset offset) {
          setState(() {
            position = offset;
          });
        },
      ),
    );
  }
}
