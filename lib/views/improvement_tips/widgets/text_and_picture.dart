import 'package:fitness_care/consts/imports.dart';

Widget textAndPicture({
  required String topic,
  required String heading1,
  required String heading1Detail,
  required String tipOrExample1,
  bool? tipBool1 = false,
  required String heading2,
  required String heading2Detail,
  required String tipOrExample2,
  bool? tipBool2 = false,
  ImageProvider? topicImage,
  ImageProvider? postImage1,
  ImageProvider? preImage2,
  ImageProvider? postImage,
}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (topicImage != null)
          Image(
            image: topicImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 150,
          ),
        const SizedBox(height: 8),
        Text(
          topic,
          style: const TextStyle(fontSize: 25,
              fontWeight: FontWeight.bold,

          ),
        ).centered(),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.circle, size: 10).paddingOnly(top: 8),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading1,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    heading1Detail,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ).paddingOnly(right: 10),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            if (postImage1 != null)
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: Image(
                  image: postImage1,
                  fit: BoxFit.cover,
                  width: 150,
                  height: 300,
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),

        // Example and tips  (1)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.circle, size: 9).paddingOnly(top: 8),
            const SizedBox(width: 8),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: tipBool1 ?? false ? "Tip: " : "Examples: ",
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: tipOrExample1,
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (preImage2 != null)
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: Image(
                  image: preImage2,
                  fit: BoxFit.cover,
                  width: 150,
                  height: 300,
                ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.circle, size: 10).paddingOnly(top: 8),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          heading2,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    heading1Detail,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ).paddingOnly(left: 10),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Example and tips  (2)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.circle, size: 9).paddingOnly(top: 8),
            const SizedBox(width: 8),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: tipBool2 ?? false ? "Tip: " : "Examples: ",
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: tipOrExample2,
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (postImage != null) ...[
          const SizedBox(height: 16),
          Image(
            image: postImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 150,
          ),
        ],
        const SizedBox(height: 10),
        const Divider(color: textFieldGrey, indent: 30, endIndent: 30),
        const SizedBox(height: 10),
      ],
    ),
  );
}
