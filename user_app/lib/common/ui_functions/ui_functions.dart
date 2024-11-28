// import 'package:flutter/material.dart';
// import 'package:sub_notes_app/common/widgets/notes_button.dart';
// import 'package:sub_notes_app/core/config/theme/app_color.dart';

// Future errorPopup({required BuildContext ctx, String? head, String? body}) {
//   return showDialog(
//     context: ctx,
//     builder: (context) => AlertDialog(
//       backgroundColor: AppColors.appLightYellow,
//       title: Text(
//         head ?? "Something went wrong",
//         style: const TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       content: Text(
//         body ?? "Something went wrong",
//         style: const TextStyle(
//           fontSize: 16,
//         ),
//       ),
//       actions: [
//         InkWell(
//           overlayColor: WidgetStateProperty.all(Colors.transparent),
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const NotesBtn(name: 'OK'),
//         )
//       ],
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//     ),
//   );
// }
