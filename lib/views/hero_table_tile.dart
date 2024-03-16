// // Exemplo básico de HeroTableTile - Este código é mais ilustrativo do que funcional neste contexto
// import 'package:flutter/material.dart';
// import '../models/hero_model.dart';

// class HeroTableTile extends StatelessWidget {
//   final HeroModel hero;

//   const HeroTableTile({super.key, required this.hero});

//   @override
//   Widget build(BuildContext context) {
//     return DataRow(cells: [
//       DataCell(Row(
//         children: [
//           Image.network(hero.imageUrl,
//               width: 50, height: 50), // Imagem do herói
//           const SizedBox(width: 8),
//           Text(hero.name,
//               style: const TextStyle(
//                   fontFamily: 'Roboto-Regular',
//                   fontSize: 21,
//                   color: Color(0xFF4E4E4E))),
//         ],
//       )),
//       DataCell(Text(hero.description,
//           style: const TextStyle(
//               fontFamily: 'Roboto-Regular',
//               fontSize: 21,
//               color: Color(0xFF4E4E4E)))),
//       DataCell(Text(hero.series.join(', '),
//           style: const TextStyle(
//               fontFamily: 'Roboto-Regular',
//               fontSize: 21,
//               color: Color(0xFF4E4E4E)))),
//       DataCell(Text(hero.events.join(', '),
//           style: const TextStyle(
//               fontFamily: 'Roboto-Regular',
//               fontSize: 21,
//               color: Color(0xFF4E4E4E)))),
//     ]);
//   }
// }
