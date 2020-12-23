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
final detailsRef = (PublicDoc publicDoc) => DetailsRef(publicDoc);

class DetailsRef extends CollectionRef<Detail, DetailDoc, DetailRef> {
  // TODO: ここを書き換えちまうか
  //DetailsRef() : super(FirebaseFirestore.instance.collection('details'));
  DetailsRef(this.publicDoc)
      : super(publicDoc.publicRef.ref.collection('details'));
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
