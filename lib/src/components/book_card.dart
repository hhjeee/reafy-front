import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reafy_front/src/models/book.dart';
import 'package:reafy_front/src/pages/book/bookdetail.dart';

class BookCard extends StatelessWidget {
  final Book book;

  BookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => BookDetailPage(book: book));
      },
      child: Card(
          color: Color(0xffF4F4F4),
          shadowColor: Color(0xffe6e6e6),
          elevation: 0,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 88,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(book.coverImageUrl!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        book.title,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xff333333),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        book.author!.length > 20
                            ? '${book.author!.substring(0, 20)}...' // 최대 20자로 제한
                            : book.author!,
                        overflow: TextOverflow.ellipsis, // 길이 초과 시 '...'로 표시

                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff6A6A6A),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
