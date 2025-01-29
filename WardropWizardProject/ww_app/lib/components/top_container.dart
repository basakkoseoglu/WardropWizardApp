import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopContainer extends StatelessWidget {
  final String title;
  // final String searchBarTitle;
  const TopContainer({
    super.key,
    required this.title,
    // required this.searchBarTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //title
        Row(
          children: [
            Text(title,
                style: TextStyle(
                  fontSize: 24,
                  color: Color.fromRGBO(185, 3, 43, 0.729),
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                )),
          ],
        ),
        // //search bar
        // Container(
        //   margin: const EdgeInsets.symmetric(vertical: 30.0),
        //   padding: const EdgeInsets.all(15),
        //   decoration: BoxDecoration(
        //     color: Color.fromARGB(255, 216, 139, 139).withOpacity(0.8),
        //     borderRadius: BorderRadius.circular(30.0),
        //   ),
        //   child: Row(children: [
        //     const Icon(
        //       FontAwesomeIcons.magnifyingGlass,
        //       size: 20,
        //       color: Color.fromARGB(255, 255, 255, 255),
        //     ),
        //     const SizedBox(
        //       width: 10,
        //     ),
        //     Text(
        //       searchBarTitle,
        //       style: TextStyle(
        //         color: Color.fromARGB(255, 255, 255, 255),
        //         fontWeight: FontWeight.w400,
        //       ),
        //     )
        //   ]),
        // )
      ],
    );
  }
}
