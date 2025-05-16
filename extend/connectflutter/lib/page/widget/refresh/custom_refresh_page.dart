// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/05/15
// Description:
// -------------------------------------------------------------------
import 'package:flutter/material.dart';

class CustomRefreshPage extends StatefulWidget {
  const CustomRefreshPage({Key? key}) : super(key: key);

  @override
  State<CustomRefreshPage> createState() => _CustomRefreshPageState();
}

class _CustomRefreshPageState extends State<CustomRefreshPage> {
  int _count = 3;
  bool isRefreshing = false;
  bool isLoadingMore = false;
  double pullTop = 0;
  double pullBottom = 0;
  static const double triggerDistance = 120;
  final ScrollController _scrollController = ScrollController();

  Future<void> _refreshTop() async {
    setState(() {
      isRefreshing = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isRefreshing = false;
      _count = 0;
      pullTop = 0;
    });
  }

  Future<void> _loadMore() async {
    setState(() {
      isLoadingMore = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      isLoadingMore = false;
      _count++;
      pullBottom = 0;
    });
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is OverscrollNotification) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;

      //up
      if (notification.overscroll < 0 && !isRefreshing) {
        setState(() {
          pullTop += -notification.overscroll;
        });
        if (pullTop > triggerDistance) {
          _refreshTop();
        }
      }

      //down
      if (notification.overscroll > 0 &&
          currentScroll >= maxScroll &&
          !isLoadingMore) {
        setState(() {
          pullBottom += notification.overscroll;
        });
        if (pullBottom > triggerDistance) {
          _loadMore();
        }
      }
    }
    if (notification is ScrollEndNotification) {
      if (!isRefreshing) {
        setState(() {
          pullTop = 0;
        });
      }
      if (!isLoadingMore) {
        setState(() {
          pullBottom = 0;
        });
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Refresh Page')),
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: _onScrollNotification,

            child: ListView.builder(
              controller: _scrollController,
              itemCount: _count,
              physics: const AlwaysScrollableScrollPhysics(
                parent: ClampingScrollPhysics(),
              ),
              itemBuilder: (context, index) {
                return ListTile(title: Text('Item $index'));
              },
            ),
          ),
          if (pullTop > 20 || isRefreshing)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: pullTop / 2,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    isRefreshing ? 'Refreshing...' : 'Pull to refresh',
                  ),
                ),
              ),
            ),
          if (pullBottom > 20 || isLoadingMore)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: pullBottom / 2,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    isLoadingMore ? 'Loading...' : 'Pull to load more',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
