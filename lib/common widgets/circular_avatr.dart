import 'package:fitness_care/consts/imports.dart';

Widget circularProfile({
  required String image,
  required String name,
  bool isNetworkImage = false, // Add this parameter
}) {
  return Column(
    children: [
      SizedBox(
        height: 120,
        width: 120,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: isNetworkImage ? NetworkImage(image) : AssetImage(image) as ImageProvider,
        ),
      ),
      name.text.size(30).fontFamily(bebasNeue).black.make(),
    ],
  );
}
