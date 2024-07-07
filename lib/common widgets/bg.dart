import 'dart:ui';
import 'package:fitness_care/consts/imports.dart';


Widget bgWidget({Widget? child, String? background}) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(background ?? bg),
        fit: BoxFit.fill,
      ),
    ),
      child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Adjust sigmaX and sigmaY for blur intensity
      child: Container(
       color: Colors.black.withOpacity(0), // Adjust opacity as needed
         child: child,
      ),
     ),
  );
}
