import 'package:flutter/cupertino.dart';

/**
  Used to pages or scaffolds animated when loading on navigating 
  used in Review page and Password edit page
 */
Route CreateRoute(Widget pageToDisplay) {
  return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => pageToDisplay,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}
