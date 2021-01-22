import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:front_end_flutter/Databases/notedao.dart';
import 'package:front_end_flutter/Pages/home_page.dart';
import 'package:front_end_flutter/constants.dart';
import 'package:get/get.dart';

import 'book.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectIcon = 0;

  Widget _currentPage;
  HomePage _homePage;
  Book _bookPage;
  List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _homePage = HomePage();
    _bookPage = Book();
    _pages = [_homePage, _bookPage];
    _currentPage = _homePage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _currentPage,
          _bottomNav(),
        ],
      ),
    );
  }

  _bottomNav() {
    return Positioned(
      height: 50,
      bottom: 0.0,
      right: 0.0,
      left: 0.0,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: firstColor,
          currentIndex: _selectIcon,
          onTap: (int index) {
            setState(() {
              _selectIcon = index;
              if (index == 0 || index == 1) _currentPage = _pages[index];
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/home.svg',
                    width: 30.0,
                    color: _selectIcon == 0 ? secondColor : fourthColor),
                title: SizedBox.shrink()),
            // BottomNavigationBarItem(
            //     icon: SvgPicture.asset('assets/icons/table.svg',
            //         width: 35.0,
            //         color: _selectIcon == 1 ? secondColor : fourthColor),
            //     title: SizedBox.shrink()),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/book.svg',
                    width: 30.0,
                    color: _selectIcon == 1 ? secondColor : fourthColor),
                title: SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
