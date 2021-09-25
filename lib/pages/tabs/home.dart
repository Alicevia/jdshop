import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_jdshop/model/ProductModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import '../../config/config.dart';
import '../../model/FocusModel.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    getSwiperList();
    getGuessLikeList();
    getHotRecList();
  }

  // 轮播图
  List swiperList = [];
  void getSwiperList() async {
    var api = 'http://jd.itying.com/api/focus';
    var res = await Dio().get(api);
    var list = FocusModel.fromJSON(res.data);
    setState(() {
      this.swiperList = list.result;
    });
  }

  Widget _swiper() {
    return Container(
      child: AspectRatio(
        aspectRatio: 2,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            String pic = this.swiperList[index].pic;
            return new Image.network(
              "http://jd.itying.com/${pic.replaceAll('\\', '/')}",
              fit: BoxFit.fill,
            );
          },
          itemCount: this.swiperList.length,
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

  List guessLikeList = [];
  getGuessLikeList() async {
    var api = '${Config.domain}api/plist?is_hot=1';
    var res = await Dio().get(api);
    var list = ProductModel.fromJson(res.data);
    setState(() {
      guessLikeList = list.result;
    });
  }

  // 猜你喜欢
  Widget guessLike() {
    if (guessLikeList.length > 0) {
      return Container(
        height: 178.w,
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: guessLikeList.length,
            itemBuilder: (context, index) {
              String sPic = guessLikeList[index].sPic;
              sPic = Config.domain + sPic.replaceAll('\\', '/');
              return Container(
                margin: EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    Container(
                      height: 140.w,
                      width: 140.w,
                      child: Image.network(
                        sPic,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: 140.w,
                      child: Text(
                        '￥${guessLikeList[index].price}',
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              );
            }),
      );
    } else {
      return Text('正在加载中');
    }
  }

  List hotRecList = [];
  void getHotRecList() async {
    var api = '${Config.domain}api/plist?is_best=1';
    var result = await Dio().get(api);
    var list = ProductModel.fromJson(result.data);
    setState(() {
      hotRecList = list.result;
    });
  }

  Widget hotRecommend() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
          runSpacing: 10,
          spacing: 10,
          children: hotRecList.map((item) {
            String sPic = Config.domain + item.sPic.replaceAll('\\', '/');
            return hotRecommendItem(sPic, item);
          }).toList()),
    );
  }

  Widget hotRecommendItem(sPic, item) {
    return Container(
      width: (1.sw - 30) / 2,
      height: 493.w,
      decoration: BoxDecoration(
          border:
              Border.all(color: Color.fromRGBO(233, 233, 233, .9), width: 1)),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    sPic,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.w),
                child: Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '￥${item.price}',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
              Text(
                '￥${item.oldPrice}',
                style: TextStyle(
                    color: Colors.black54,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 14),
              ),
            ],
          ),
          // child: Stack(
          //   children: [
          //     Align(
          //       alignment: Alignment.centerLeft,
          //       child: Text(
          //         '￥${item.price}',
          //         style: TextStyle(color: Colors.red, fontSize: 16),
          //       ),
          //     ),
          //     Align(
          //       alignment: Alignment.centerRight,
          //       child: Text(
          //         '￥${item.oldPrice}',
          //         style: TextStyle(
          //             color: Colors.black54,
          //             decoration: TextDecoration.lineThrough,
          //             fontSize: 14),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
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
        this._title('猜你喜欢'),
        guessLike(),
        this._title('热门推荐'),
        hotRecommend()
      ],
    );
  }
}
