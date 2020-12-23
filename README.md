# flutter_practice

Practice flutter

## ファイル名に main が入ってるものは main メソッドが入っている

Android Studio で右クリックで実行できる

## I switched to Riverpod, so I don't use LocatorMixin now.

https://twitter.com/remi_rousselet/status/1287151052245139456

## feezed

flutter pub run build_runner build --delete-conflicting-outputs

## ログインした後、リロードするとログイン画面がちらつく

下記のサンプルでもちらつく

- https://github.com/bizz84/starter_architecture_flutter_firebase
- https://github.com/lohanidamodar/flutter_firebase_starter

ということで後回し

## TODO

- public コレクションは publics にしたからもろもろ直す
- freezed, flutter_hooks, firestore_ref のサンプル
  - firestore_ref ってサブコレクションに対応してる？
- ui 系もちゃんとわかってないな
- routes
- riverpod の StateNotifierProvider 使うと copyWith 必要なくない？
- サブコレクションが欲しいときと欲しくない時あるよねー。
  - author_model
  - author_book_model とかやると冗長だね
  - book_model
- author の一覧
- author に紐づく、book の一覧
- author を跨いだ book の一覧に author 表示されるパターン

## 些末なこと

- Scaffold extends StatefulWidget なので、StatefulWidget が完全になくせるわけじゃないし、意味がないと思う
