# flutter_practice

Practice flutter

## ファイル名に main が入ってるものは main メソッドが入っている

Android Studio で右クリックで実行できる

## I switched to Riverpod, so I don't use LocatorMixin now.

https://twitter.com/remi_rousselet/status/1287151052245139456

## feezed

flutter pub run build_runner build --delete-conflicting-outputs

## TODO

- ui 系もちゃんとわかってないな
- サブコレクションが欲しいときと欲しくない時あるよねー。
  - author_model
  - author_book_model とかやると冗長だね
  - book_model
- author の一覧
- author に紐づく、book の一覧
- author を跨いだ book の一覧に author 表示されるパターン

## 些末なこと

- Scaffold extends StatefulWidget なので、StatefulWidget が完全になくせるわけじゃないし、意味がないと思う
