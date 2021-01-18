import 'package:firestore_ref/firestore_ref.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'public.dart';

part 'detail.freezed.dart';
part 'detail.g.dart';

@freezed
abstract class Detail with _$Detail {
  factory Detail({
    @required String title,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  }) = _Detail;
  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);
}

class DetailField {
  static const title = 'title';
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
}

// 書き換え
// final detailsRef = DetailsRef();
final detailsRef = (PublicDoc publicDoc) => DetailsRef(publicDoc: publicDoc);

class DetailsRef extends CollectionRef<Detail, DetailDoc, DetailRef> {
  // ここを書き換えちまう。TODO: もっといい対応があるのか？
  //DetailsRef() : super(FirebaseFirestore.instance.collection('details'));
  // 引数があると、CollectionGroupRefのdocRefが実装しづらい　→　コンストラクタ修正
  // TODO: 引数がないときは、CollectionGroupRef?いや違うDetailsGroupRefを使う
  DetailsRef({this.publicDoc})
      : super(publicDoc == null
            ? FirebaseFirestore.instance.collection('details')
            : publicDoc.publicRef.ref.collection('details'));
  final PublicDoc publicDoc;

  @override
  Map<String, dynamic> encode(Detail data) =>
      replacingTimestamp(json: data.toJson());

  @override
  DetailDoc decode(DocumentSnapshot snapshot, DetailRef docRef) {
    assert(docRef != null);
    return DetailDoc(
      docRef,
      Detail.fromJson(snapshot.data()),
    );
  }

  @override
  DetailRef docRef(DocumentReference ref) => DetailRef(
        ref: ref,
        detailsRef: this,
      );
}

class DetailsGroupRef extends CollectionGroupRef<Detail, DetailDoc, DetailRef> {
  DetailsGroupRef() : super('details');

  @override
  Map<String, dynamic> encode(data) => replacingTimestamp(json: data.toJson());

  @override
  decode(DocumentSnapshot snapshot, docRef) {
    assert(docRef != null);
    return DetailDoc(
      docRef,
      Detail.fromJson(snapshot.data()),
    );
  }

  @override
  docRef(DocumentReference ref) => DetailRef(
        ref: ref,
        detailsRef: DetailsRef(),
      );
}

class DetailRef extends DocumentRef<Detail, DetailDoc> {
  const DetailRef({
    @required DocumentReference ref,
    @required this.detailsRef,
  }) : super(
          ref: ref,
          collectionRef: detailsRef,
        );

  final DetailsRef detailsRef;
}

class DetailDoc extends Document<Detail> {
  const DetailDoc(
    this.detailRef,
    Detail entity,
  ) : super(detailRef, entity);

  final DetailRef detailRef;
}
