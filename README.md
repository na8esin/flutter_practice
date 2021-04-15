# flutter_practice

Practice flutter

## goldens
flutter test --update-goldens

## ファイル名に main が入ってるものは main メソッドが入っている

Android Studio で右クリックで実行できる

## I switched to Riverpod, so I don't use LocatorMixin now.

https://twitter.com/remi_rousselet/status/1287151052245139456

## feezed

flutter pub run build_runner build --delete-conflicting-outputs

## TODO

- widgetを網羅する

## build_runnerが失敗する
### NoSuchMethodError: The getter 'definingUnit' was called on null. 

build_runnerが失敗する件。テストコードのimportの相対パスがいけない

https://github.com/google/json_serializable.dart/issues/738#

### もしかすると、ファイル名に空白があるとだめかもしれない
アノテーションとかついてない全然関係ないファイルでもだめかもしれない

build.yamlで対象を絞ってもだめ

## 些末なこと

- Scaffold extends StatefulWidget なので、StatefulWidget が完全になくせるわけじゃないし、意味がないと思う
