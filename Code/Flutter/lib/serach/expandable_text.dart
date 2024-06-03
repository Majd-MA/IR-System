

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  ExpandableText({
    required this.text,
    this.maxLines = 1,
    Key? key,
    this.textStyle,
  }) : super(key: key);
  final String text;
  final int maxLines;
  final TextStyle? textStyle;

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Text(
        widget.text,
        style: widget.textStyle ,
        maxLines: _isExpanded ? null : widget.maxLines,
        overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
      ),
    );
  }
}
