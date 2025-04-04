// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/18
// Description:
// -------------------------------------------------------------------
import 'package:connectflutter/model/index.dart';
import 'package:connectflutter/route/app_router_provider.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'mine/profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    StatusBarUtil.applyPlatformSpecificStatusBar(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PageUtil.buildPageWithNoAppBar(
      _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    if (_selectedIndex == 0) {
      return _buildHomePage();
    } else if (_selectedIndex == 1) {
      return _buildWidgetsPage();
    } else {
      return ProfilePage();
    }
  }

  Widget _buildHomePage() {
    return Padding(
      padding: EdgeInsets.all(DimenUtil.width20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNewsSection("最新の技術ニュース", getLatestLinkModels()),
            _buildNewsSection("最新のAI技術", getAiLinkModels()),
            _buildNewsSection("関連技術", getRelatedLinkModels()),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetsPage() {
    return Padding(
      padding: EdgeInsets.all(DimenUtil.width20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildWidgetButton('Video Ads', () {
              context.push(videoAdPath);
            }),
            SizedBox(height: DimenUtil.height10),
            buildWidgetButton('Cupertino Checkbox Example', () {
              context.push(cupertinoCheckboxPath);
            }),
            SizedBox(height: DimenUtil.height10),
            buildWidgetButton('Cupertino Switch Example', () {
              context.push(cupertinoSwitchPath);
            }),
            SizedBox(height: DimenUtil.height10),
            buildWidgetButton('Go ban', () {
              context.push(gobanPath);
            }),
            SizedBox(height: DimenUtil.height10),
            buildWidgetButton('StatusBar Congiguration Guide', () {
              context.push(statusBarCongigurationGuidePath);
            }),
            SizedBox(height: DimenUtil.height10),
            buildWidgetButton('国際将棋', () {
              context.push(connectPath);
            }),

            SizedBox(height: DimenUtil.height10),
            buildWidgetButton('国際将棋Test', () {
              context.push(testPath);
            }),
            SizedBox(height: DimenUtil.height10),
            buildWidgetButton('BallTest', () {
              context.push(ballPath);
            }),

          ],
        ),
      ),
    );
  }



  Widget _buildNewsSection(String title, List<LinkModel> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getWidgetText(title),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: links.length,
          itemBuilder: (context, index) {
            final link = links[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: getLinkText(link),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.widgets), label: 'Widgets'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
