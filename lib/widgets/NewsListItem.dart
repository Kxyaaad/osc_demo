import 'package:flutter/material.dart';

class NewsListItem extends StatelessWidget {
  final Map newsList;

  NewsListItem({this.newsList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //TODO
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1
            )
          )
        ),
        child: Column(
          children: [
            Text(newsList['title']),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('@${newsList['author']} ${newsList['pubDate'].toString().split(' ')}'),
                Row(
                  children: [
                    Icon(Icons.comment),
                    Text(newsList['commentCount'].toString()),

                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
