#### responsive_framework
 ブレイクポイント定義やレスポンシブグリッドを簡単に導入できます。

導入例（responsive_framework）：

```
MaterialApp(
  builder: (context, widget) => ResponsiveWrapper.builder(
    ClampingScrollWrapper.builder(context, widget!),
    breakpoints: [
      ResponsiveBreakpoint.resize(350, name: MOBILE),
      ResponsiveBreakpoint.autoScale(800, name: TABLET),
      ResponsiveBreakpoint.autoScale(1200, name: DESKTOP),
    ],
  ),
  home: MyHomePage(),
);
```