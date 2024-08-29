import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key,
    this.image,
    required this.title,
    this.description,
    this.button,
    this.paddingTop = 128,
    this.horizontal,
    this.titleColor,
    this.descriptionColor,
    this.titleWeight,
    this.titleFontSize,
    this.descriptionWeight,
    this.descriptionFontSize
  });

  final Widget? image;
  final String title;
  final String? description;
  final Widget? button;
  final double? paddingTop;
  final double? horizontal;
  final Color? titleColor;
  final Color? descriptionColor;
  final FontWeight? titleWeight;
  final FontWeight? descriptionWeight;
  final double? titleFontSize;
  final double? descriptionFontSize;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      //physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: horizontal ?? 32),
      children: [
        SizedBox(height: paddingTop,),
        if(image!= null)
        Center(child: image),
        const SizedBox(height: 12,),
        Center(child: Text(title)),
        const SizedBox(height: 12,),
        if(description != null)
        Center(child: Text(description ?? "", textAlign: TextAlign.center)),
        const SizedBox(height: 24,),
        if(button != null)
          button!
      ],
    );
  }
}


