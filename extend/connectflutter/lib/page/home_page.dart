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
      return Center(
        child: Text('Profile Page', style: TextStyle(fontSize: 20)),
      );
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
            InkWell(
              onTap: () {
                context.push(videoAdPath);
              },
              child: Container(
                padding: EdgeInsets.all(DimenUtil.width20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Video Ads',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
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
