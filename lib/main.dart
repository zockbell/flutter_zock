// 导入相关的控件
import 'dart:io';

import 'package:flutter/material.dart';
import './views/list.dart';

// 入口函数
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'zock电影',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 在flutter中，每个控件都是类
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          // 顶部状态栏
          appBar: AppBar(
            title: Text('zock电影'),
            centerTitle: true,
            // 右侧行为按钮
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.search),
                  tooltip: '搜索电影',
                  onPressed: () {
                    // Implement navigation to shopping cart page here...
                    print('Shopping cart opened.');
                  })
            ],
          ),

          // 侧边栏
          drawer: Drawer(
            child: ListView(
                // padding用于解决刘海屏的间隙
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  // 这里是数组，是并列的意思，这里是头像区域
                  UserAccountsDrawerHeader(
                    accountEmail: Text('my9080@foxmail.com'),
                    accountName: Text('zock'),
                    currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://avatars1.githubusercontent.com/u/13690267?s=460&v=4')),
                    // 美化当前控件
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(
                        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1563300962473&di=f79ea7f69c8ee0118a700cff2768b545&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F052679fe95a4ed3a6a0d0d46af25051224602148e95c-DsVY1k_fw658',
                      ),
                      fit: BoxFit.cover,
                    )),
                  ),

                  // 这里是我的消息等相关列表
                  ListTile(
                    title: Text('我的消息'),
                    trailing: Icon(Icons.insert_comment),
                  ),
                  ListTile(
                    title: Text('我的反馈'),
                    trailing: Icon(Icons.feedback),
                  ),
                  ListTile(
                    title: Text('系统设置'),
                    trailing: Icon(Icons.settings),
                  ),
                  // 分隔线
                  Divider(color: Colors.black38),
                  ListTile(
                    title: Text('注销'),
                    trailing: Icon(Icons.exit_to_app),
                  ),
                ]),
          ),

          // body 页面主体内容
          body: TabBarView(children: <Widget>[
            new MovieList(type: 'in_theaters'),
            new MovieList(type: 'coming_soon'),
            new MovieList(type: 'top250'),
            new MovieList(type: '')
          ]),

          // 底部的tabBar
          bottomNavigationBar: Container(
          // 解决苹果X等刘海屏下方的安全区域
          // bottomNavigationBar: SafeArea(
              // 美化当前的 bottomNavigationBar
              // decoration: BoxDecoration(
              //   color: Colors.green,
              // ),
              // height: 50,
              child: TabBar(
                // labelStyle: TextStyle(height: 0,fontSize: 12),
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.movie_filter),
                    text: '正在热映',
                  ),
                  Tab(icon: Icon(Icons.local_movies), text: '即将上映'),
                  Tab(icon: Icon(Icons.move_to_inbox), text: '电影排名'),
                  Tab(icon: Icon(Icons.audiotrack), text: '点读音频'),
                ],
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black38,
                indicatorColor: Colors.white,
              )),
        ));
  }
}
