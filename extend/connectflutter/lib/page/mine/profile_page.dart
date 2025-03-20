// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/19
// Description:
// -------------------------------------------------------------------
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectflutter/route/app_router_provider.dart';
import 'package:connectflutter/util/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../component/title/title_util.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double _initFabHeight = 100.0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.black,
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      height: TitleUitl.TITLE_HEIGHT,
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
            context.push(settingsPath);
          },
          child: Icon(Icons.settings, color: Colors.grey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;

    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            defaultPanelState: PanelState.OPEN,

            body: _body(),
            panelBuilder: (sc) => _panel(sc),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0),
              topRight: Radius.circular(18.0),
            ),
            onPanelSlide: (double pos) => setState(() {}),
          ),
          _buildTitle(),
          Positioned(
            top: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).padding.top,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: sc,
        children: <Widget>[
          SizedBox(height: DimenUtil.height12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: DimenUtil.width30,
                height: DimenUtil.height5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(
                    Radius.circular(DimenUtil.radius16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: DimenUtil.height18),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Icon(Icons.man_2_sharp, color: Colors.white),
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  blurRadius: DimenUtil.radius8,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Tommy",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: FontSizeUtil.size16,
                ),
              ),
            ],
          ),
          SizedBox(height: DimenUtil.height30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _button("Fav", Icons.favorite, Colors.blue),
              _button("Weather", Icons.cloud, Colors.red),
              _button("Events", Icons.event, Colors.amber),
              _button("More", Icons.more_horiz, Colors.green),
            ],
          ),
          SizedBox(height: DimenUtil.height30),
          Container(
            padding: EdgeInsets.only(
              left: DimenUtil.width24,
              right: DimenUtil.width24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Images",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: FontSizeUtil.size14,
                  ),
                ),
                SizedBox(height: DimenUtil.height12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl:
                          "https://images.fineartamerica.com/images-medium-large-5/new-pittsburgh-emmanuel-panagiotakis.jpg",
                      height: 120.0,
                      width: (MediaQuery.of(context).size.width - 48) / 2 - 2,
                      fit: BoxFit.cover,
                    ),
                    CachedNetworkImage(
                      imageUrl:
                          "https://cdn.pixabay.com/photo/2016/08/11/23/48/pnc-park-1587285_1280.jpg",
                      width: (MediaQuery.of(context).size.width - 48) / 2 - 2,
                      height: 120.0,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 36.0),
          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("About", style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 12.0),
                Text(
                  """オーストラリアは、広大な大地と多様な自然環境が特徴的な国です。美しいビーチや砂漠、熱帯雨林など、さまざまな景観が広がり、観光地としても非常に人気があります。シドニーやメルボルンなどの都市は、文化やアートが豊かで、世界中から多くの旅行者や移住者を魅了しています。オーストラリアはまた、スポーツ好きな国としても知られ、ラグビー、クリケット、サーフィンなどが盛んです。親しみやすい人々とアウトドアライフが楽しめる魅力的な場所です。

                 """,
                  softWrap: true,
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _button(String label, IconData icon, Color color) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(DimenUtil.radius16),
          child: Icon(icon, color: Colors.white),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.15), blurRadius: 8.0),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Text(label),
      ],
    );
  }

  Widget _body() {
    return (CachedNetworkImage(
      fit: BoxFit.fill,
      height: DimenUtil.height80,

      imageUrl:
          "https://images.unsplash.com/photo-1523482580672-f109ba8cb9be?q=80&w=3030&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    ));
  }
}
