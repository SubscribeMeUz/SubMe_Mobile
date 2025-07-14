import 'package:flutter/material.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;
  final TextStyle? style;

  const ExpandableText({super.key, required this.text, this.trimLines = 3, this.style});

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;
  late String firstHalf;
  late String secondHalf;
  bool showExpandButton = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final textPainter = TextPainter(
        text: TextSpan(text: widget.text, style: DefaultTextStyle.of(context).style),
        maxLines: widget.trimLines,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(maxWidth: MediaQuery.of(context).size.width);

      if (textPainter.didExceedMaxLines) {
        setState(() {
          showExpandButton = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: isExpanded ? null : widget.trimLines,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style:
              widget.style ??
              context.textStyle.sfProRegular.copyWith(
                color: context.colors.whiteColor,
                fontSize: 14,
                height: 22 / 14,
              ),
        ),
        if (showExpandButton || isExpanded == false)
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Text(
              isExpanded ? 'Show less' : 'Show more',
              style: context.textStyle.sfProRegular.copyWith(color: context.colors.primaryColor),
            ),
          ),
      ],
    );
  }
}
