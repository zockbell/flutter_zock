import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import './detail.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// import 'package:flutter/scheduler.dart';

Dio dio = new Dio();

class MovieList extends StatefulWidget {
  // 固定写法
  MovieList({Key key, @required this.type}) : super(key: key);

  // 电影导航类型
  final String type;

  @override
  _MovieListState createState() {
    return new _MovieListState();
  }
}

// 有状态的控件，必须结合一个状态管理类来进行实现
class _MovieListState extends State<MovieList>
    with AutomaticKeepAliveClientMixin {
  // 默认显示第一页数据
  int page = 1;
  // 每页显示的数据条数
  int pagesize = 20;
  // 电影列表数据,用来挂载到页面（页面渲染）
  var mList = [];
  // 总数据条数，用来计算，实现分页效果
  var total = 0;

  // 这里类似vue里的滚动行为(列表状态保持)
  @override
  bool get wantKeepAlive => true;

  // 控件被创建的时候,会执行initState 生命周期(类似vue中的created(),react中的componentDidMount)
  @override
  void initState() {
    super.initState();
    getList();
  }

  // build 用来渲染当前这个 MovieList 的UI结构
  @override
  Widget build(BuildContext context) {
    // print(widget.type);  // 打印测试
    // return Text('列表' + widget.type + '---${mList.length}');
    return ListView.builder(
        // 如果是用到循环就用  ListView.builder() 方法
        itemCount: mList.length, // 必须指定，这里是循环的次数
        itemBuilder: (BuildContext ctx, int i) {
          // 每次循环，都拿到当前的电影Item项
          var mItem = mList[i];
          return GestureDetector(
            //这个控制是处理事件触发
            onTap: () {
              // print('aaa');
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext ctx) {
                return new MovieDetail(
                  id: mItem['id'],
                  movieTitle: mItem['title'],
                );
              }));
            },
            child: Container(
                height: 200.0,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(bottom: BorderSide(color: Colors.black12))),
                child: Row(children: <Widget>[
                  // 左侧图片
                  Image.network(
                    mItem['images']['large'],
                    width: 150.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),

                  // 右侧文字列表
                  Expanded(
                    child: Container(
                        height: 200.0,
                        padding: EdgeInsets.only(left: 10.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '电影名称：${mItem['title']}',
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text('上映时间: ${mItem['mainland_pubdate']}'),
                            Text('电影类型：${mItem['genres'].join(",")}'),
                            Text('豆瓣评分：${mItem['rating']['average']}分'),
                            Text(
                              '主要演员：${mItem['title']}',
                              // style: TextStyle(fontSize: 10.0),
                            )
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                        )
                    )
                  )
                ])),
          );
        });
  }

  // 获取电影列表异步方法接口
  getList() async {

    // js中模板字符串
    // 数据偏移量的计算公式 (page - 1) * pagesize
    int start = (page - 1) * pagesize;

    var res = await dio.get(
      // 这里的模板字符串，需要注意，如果直接将变量值插入进来，则不需要{}，如果是某个对象的某个属性，则需要{}
      'https://douban.uieee.com/v2/movie/${widget.type}?start=$start&count=$pagesize'
    );

    // 服务器返回的数据
    var result = res.data;
    // print(result);

    // 接下来是将数据挂载到页面中，只要为私有数据赋值，都需要把赋值的操作，放到setState 函数中，否则，页面不会更新
    setState(() {
      // 通过 dio 返回的数据，不能用.去遍历，必须使用 [] 去遍历
      mList = result['subjects'];
      total = result['total:'];
    });
  }
}
