import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _swiper() {
    List<Map> imgList = [
      {"url": "https://www.itying.com/images/flutter/slide01.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide02.jpg"},
      {"url": "https://www.itying.com/images/flutter/slide03.jpg"},
    ];
    return Container(
      child: AspectRatio(
        aspectRatio: 2,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return new Image.network(
              imgList[index]['url'],
              fit: BoxFit.fill,
            );
          },
          itemCount: imgList.length,
          pagination: new SwiperPagination(),
          autoplay: true,
        ),
      ),
    );
  }

  // 标题
  Widget _title(String text) {
    return Container(
      height: 32.w,
      margin: EdgeInsets.only(
        left: 10,
      ),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border(
        left: BorderSide(color: Colors.red, width: 10.w),
      )),
      child: Text(
        text,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }

  // 热门商品
  Widget hotGoods() {
    return Container(
      height: 178.w,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  Container(
                    height: 140.w,
                    width: 140.w,
                    child: Image.network(
                      'https://www.itying.com/images/flutter/hot${index + 1}.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: 140.w,
                    child: Text(
                      '第${index + 1}张adfas34dfsdf',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        this._swiper(),
        SizedBox(
          height: 10,
        ),
        this._title('热门推荐'),
        hotGoods(),
        this._title('猜你喜欢'),
      ],
    );
  }
}
