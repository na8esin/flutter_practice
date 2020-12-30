import 'package:firestore_ref/firestore_ref.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'public.freezed.dart';
part 'public.g.dart';

@freezed
abstract class Public with _$Public {
  // TODO: ここにDtailsを入れたくなるが。。。
  factory Public({
    @required String name,
    @required String subname,
    @TimestampConverter() DateTime createdAt,
    @TimestampConverter() DateTime updatedAt,
  }) = _Public;
  factory Public.fromJson(Map<String, dynamic> json) => _$PublicFromJson(json);
}

class PublicField {
  static const name = 'name';
  static const subname = 'subname';
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
}

final publicsRef = PublicsRef();

class PublicsRef extends CollectionRef<Public, PublicDoc, PublicRef> {
  PublicsRef() : super(FirebaseFirestore.instance.collection('publics'));

  @override
  Map<String, dynamic> encode(Public data) =>
      replacingTimestamp(json: data.toJson());

  @override
  PublicDoc decode(DocumentSnapshot snapshot, PublicRef docRef) {
    assert(docRef != null);
    return PublicDoc(
      docRef,
      Public.fromJson(snapshot.data()),
    );
  }

  @override
  PublicRef docRef(DocumentReference ref) => PublicRef(
        ref: ref,
        publicsRef: this,
      );
}

class PublicRef extends DocumentRef<Public, PublicDoc> {
  const PublicRef({
    @required DocumentReference ref,
    @required this.publicsRef,
  }) : super(
          ref: ref,
          collectionRef: publicsRef,
        );

  final PublicsRef publicsRef;
}

class PublicDoc extends Document<Public> {
  const PublicDoc(
    this.publicRef,
    Public entity,
  ) : super(publicRef, entity);

  final PublicRef publicRef;
}
