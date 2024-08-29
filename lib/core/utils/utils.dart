import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void printDebug(Object? object) {
  if(kDebugMode){
    print(object);
  }
}

void showCustomBottomSheet(BuildContext context,{
  required Widget child,
  bool isScrollControlled = true,
  bool isDismissible = true
}){
  showModalBottomSheet(
      context: context,
      isScrollControlled: isScrollControlled,
      useSafeArea: true,
      enableDrag: true,
      showDragHandle: true,
      isDismissible: isDismissible,
      builder: (context){
        return SafeArea(
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: child,
          ),
        );
      }
  );
}