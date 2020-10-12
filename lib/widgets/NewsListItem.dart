import 'package:flutter/material.dart';
import 'package:osc_demo/Pages/news_detail_page.dart';

class NewsListItem extends StatelessWidget {
  final Map newsList;

  NewsListItem({this.newsList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //TODO
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> NewsDetailPage(id: newsList['id'],)));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(

            children: [
              Text(
                newsList['title'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                maxLines: 2,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '@${newsList['author']} ${newsList['pubDate'].toString().split(' ')}',
                  style: TextStyle(color: Colors.grey),),
                  Row(
                    children: [
                      Icon(Icons.comment),
                      Text(newsList['commentCount'].toString(), style: TextStyle(color: Colors.grey, fontSize: 14),),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
