https://gist.github.com/johnpryan/bbca91e23bbb4d39247fa922533be7c9

長くてわかりづらいんで、分割してみる
そして、rail を使う

# 構成

```
// app.dart
MaterialApp.router(
  routerDelegate: _routerDelegate, //BookRouterDelegate
  // BookRouteInformationParser
  routeInformationParser: _routeInformationParser,
);

// BookRouterDelegate
build(BuildContext context) {
  return Navigator(
    pages: [
      MaterialPage(
        child: AppShell(appState: appState),
      ),
    ],);
}
setNewRoutePath();

// AppShell(BooksAppState) //MaterialApp.router があるわけじゃない
  - InnerRouterDelegate
  - ChildBackButtonDispatcher
  build(){ NavigationRail() }
```
