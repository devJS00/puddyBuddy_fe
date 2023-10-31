import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'feed.dart';
import 'shop.dart';
import 'my_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PuddyBuddy',
      theme: ThemeData(
        primaryColor: Colors.blue,
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[Feed(), Shop(), MyPage()];

  void changePage(int index) { // 하단바의 아이템을 클릭할 때 실행되는 함수
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // extendBody를 true로 해야 하단바 뒤로도 내용이 보임
      body: _widgetOptions[_currentIndex],
      appBar: AppBar(
        backgroundColor: Color(0xFFA8ABFF),
        title: Center(
          child: const Text(
            'PuddyBuddy',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Flexible(
            child: DotNavigationBar(
              marginR: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              paddingR: EdgeInsets.only(bottom: 5, top: 10),
              itemPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              boxShadow: [ // 하단바 그림자
                BoxShadow(
                    color: Colors.black12, spreadRadius: 1, blurRadius: 5)
              ],
              dotIndicatorColor: Colors.transparent, // 선택된 아이템을 가리키는 점이 보이지 않길 원하면 투명 상태로 설정해야 함
              selectedItemColor: Color(0xFFA8ABFF), // 선택된 상태의 아이템 색상
              unselectedItemColor: Colors.black, // 선택되지 않은 상태의 아이템 색상
              currentIndex: _currentIndex,
              onTap: changePage, // 아이템을 선택하면 실행되는 함수
              enablePaddingAnimation: false,  // 아이템 선택했을 때 실행되는 애니메이션 비활성화
              items: [
                DotNavigationBarItem( // 하단바에 들어갈 아이템들
                  icon: Icon(
                    Icons.home,
                    size: 35,
                  ),
                ),
                DotNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_bag,
                    size: 35,
                  ),
                ),
                DotNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: FloatingActionButton( // BottomNavigationBar 옆에 추가한 Button
              backgroundColor: Color(0xFFA8ABFF),
              onPressed: () {},
              child: Icon(
                Icons.edit,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}