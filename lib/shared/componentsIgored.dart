// import 'package:flutter/material.dart';

// Widget defaultButton({
//   bool isUpper = true,
//   double width = double.infinity,
//   double height = 40,
//   Color color = Colors.blue,
//   required Function function,
//   required String text,
//   Color textColor = Colors.white,
//   double fontsize = 20.0,
//   double? radius,
// }) =>
//     TextButton(
//       onPressed: () {
//         function();
//       },
//       child: Text(
//         isUpper ? text.toUpperCase() : text,
//         style: TextStyle(fontSize: fontsize, color: textColor),
//       ),
//     );

// Widget defaultTextField({
//   bool isPass = false,
//   required String labeltext,
//   required TextEditingController controller,
//   required String? Function(String? val)? validator,
//   required TextInputType keyType,
//   required Widget preIcon,
//   Widget? suffIcon,
// }) =>
//     TextFormField(
//       // onTap: () {
//       //   onTap();
//       // },
//       obscureText: isPass,
//       validator: validator,
//       controller: controller,
//       onFieldSubmitted: (value) {
//         print(value);
//       },
//       decoration: InputDecoration(
//         labelText: labeltext,
//         prefixIcon: preIcon,
//         suffixIcon: suffIcon,
//         border: const OutlineInputBorder(),
//       ),
//       keyboardType: keyType,
//     );

// Widget buildTaskItem(Map? model) => Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 50.0,
//             child: Text(
//               '${model!['time']}',
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 24.0,
//               ),
//             ),
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 '${model['title']}',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 24.0,
//                 ),
//               ),
//               Text(
//                 '${model['date']}',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 24.0,
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
