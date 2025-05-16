// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/05/16
// Description:
// -------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieRefreshPage extends StatefulWidget {
  const LottieRefreshPage({super.key});

  @override
  State<LottieRefreshPage> createState() => _LottieRefreshPageState();
}

class _LottieRefreshPageState extends State<LottieRefreshPage> {
  int _count = 3;
  double pullDistance = 0;
  bool isRefreshing = false;

  Future<void> _onRefresh() async {
    setState(() {
      isRefreshing = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isRefreshing = false;
      _count++;
      pullDistance = 0;
    });
  }

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is OverscrollNotification && !isRefreshing) {
      setState(() {
        pullDistance += notification.overscroll / 2;
      });
      if (pullDistance > 100) {
        _onRefresh();
      }
    }
    if (notification is ScrollEndNotification && !isRefreshing) {
      setState(() {
        pullDistance = 0;
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lottie Refresh Page')),
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: _onScrollNotification,
            child: ListView.builder(
              itemCount: _count,
              itemBuilder: (context, index) {
                return ListTile(title: Text('Item $index'));
              },
            ),
          ),
          if (pullDistance > 20 || isRefreshing)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Lottie.asset(
                'assets/lottie/envelope.json',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                repeat: isRefreshing,
              ),
            ),
        ],
      ),
    );
  }
}
