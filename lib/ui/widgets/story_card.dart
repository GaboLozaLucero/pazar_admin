import 'package:admin_project_v1/models/stories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({
    Key? key,
    this.stories,
    required this.function,
  }) : super(key: key);

  final List<Story>? stories;
  final Function function;

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return ListView.builder(
        itemCount: stories?.length,
        itemBuilder: (context, index) {
          if (stories!.isEmpty) {
            return const Center(
              child: Text('Aún no hay historias que contar'),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 18.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  width: 1.0,
                  color: Colors.black,
                ),
                // image: DecorationImage(
                //   image: NetworkImage('${stories?[index].imageUrl}'),
                //   fit: BoxFit.fill,
                // ),
              ),
              height: height * 0.15,
              width: double.infinity,
              child: Stack(fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      '${stories?[index].imageUrl}',
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      alignment: Alignment.bottomRight,
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                      ),
                    ),
                    onPressed: () {
                      function(index);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            '${stories?[index].name}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            '${stories?[index].address}',
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
