import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';

class InfoDetailPage extends StatelessWidget {
  final String title;

  const InfoDetailPage({super.key, required this.title});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kGreyLightColor,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            """Lorem ipsum dolor sit amet, consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.""",
            textAlign: TextAlign.left,
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, color: kGreyColor),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            """Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.""",
            textAlign: TextAlign.left,
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, color: kGreyColor),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            """Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.""",
            textAlign: TextAlign.left,
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, color: kGreyColor),
          )
        ],
      ),
    );
  }
}
