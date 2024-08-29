// import 'package:flutter/material.dart';
// import 'package:innoscripta/widgets/raw_button.dart';
// import 'package:intl/intl.dart';
//
// class InputDateTime extends FormField{
//   InputDateTime({
//     super.key,
//     super.validator,
//     required BuildContext buildContext,
//     required DateTime? value,
//     required ValueChanged<DateTime> onSelect,
//     final String? hintText,
//     final Color? backgroundColor,
//     final String? format,
//     final DateTime? firstDate,
//     final DateTime? lastDate,
//     final DateTime? initialDate,
//     final bool showBorder = false,
//   }): super(
//   builder: (context){
//     return RawButton(
//         color: Colors.transparent,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             border: showBorder ? Border.all(width: 1) : null,
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           height: 52,
//           child: Row(
//             children: [
//               Expanded(
//                 child: FittedBox(
//                   fit: BoxFit.scaleDown,
//                   alignment: Alignment.centerLeft,
//                   child: Text(value != null ? DateFormat("dd-MM-yyyy").format(value) : hintText ?? "Select",
//                     style: Theme.of(buildContext).te,),
//                 ),
//               ),
//               const SizedBox(width: 12,),
//               Icon(Icons.calendar_today, size: 24),
//             ],
//           ),
//         ),
//         onTap: () {
//           showDatePicker(
//             context: buildContext,
//             initialDate: initialDate ?? DateTime.now(),
//             firstDate: firstDate ?? DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
//             lastDate: lastDate ?? DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 90),
//           ).then((selectedDate) {
//             if (selectedDate != null) {
//               DateTime selectedDateTime = DateTime(
//                   selectedDate.year,
//                   selectedDate.month,
//                   selectedDate.day,
//                   selectedDate.hour,
//                   00, 00
//               );
//               onSelect(selectedDateTime);
//             }
//           });
//         }
//     );
//   });
// }
