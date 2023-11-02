import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reafy_front/src/components/image_data.dart';

class BookShelfWidget extends StatefulWidget {
  const BookShelfWidget({super.key});

  @override
  State<BookShelfWidget> createState() => _BookShelfWidgetState();
}

class _BookShelfWidgetState extends State<BookShelfWidget> {
  bool isExpanded = false;
  //Widget _buildBookBoxes(){

  //}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
        child: Container(
            width: size.width * 0.78,
            height: size.height * 0.6,
            decoration: BoxDecoration(
                color: Color(0xffAA905F),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10.0,
                    spreadRadius: 10.0,
                    offset: Offset(10, 10),
                  )
                ]),
            child: Padding(
                padding:
                    EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 10),
                child: NestedScrollView(
                    headerSliverBuilder: (context, value) {
                      return [
                        SliverToBoxAdapter(
                            child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: size.width * 0.4,
                                ),
                                Text(
                                  "등록순",
                                ),
                                Text("|"),
                                Text("이름순"),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        )),
                      ];
                    },
                    body: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 100,
                        shrinkWrap: true,
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.75,
                          mainAxisSpacing: 40,
                          crossAxisSpacing: 20,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 10,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Color(0xffd9d9d9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        })))));
  }
}
