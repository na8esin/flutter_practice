書籍(サブコレクション)の一覧の中に、著者(コレクション)の情報も載せたいときはどうする？
コレクションとサブコレクションを一括で取得する方法はないのか？

https://stackoverflow.com/questions/63819670/how-to-get-sub-collections-of-every-collection-in-firestore-using-flutter

まあ、ないよね。

となると、パフォーマンス的にグループコレクション同士を結合させる必要があるのか？

```
// idがとれた
          return ListView(children: [
          for (DocumentSnapshot document in snapshot1.data.docs)
            ListTile(
              title: Text(document.data()['name']),
              subtitle: Text(document.id),
            )
        ]);
```

```
// 基本の形
snapshot1.data.docs.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Text(document.data()['name']),
            );
          }).toList(),

```
