#### OrientationBuilder で縦横向き切り替え

デバイスの向き（Portrait／Landscape）によってレイアウトを変えたい場合に使います。

```
OrientationBuilder(builder: (context, orientation) {
  return orientation == Orientation.portrait
      ? _buildPortraitLayout()
      : _buildLandscapeLayout();
});
```