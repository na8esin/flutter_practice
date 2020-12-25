void main() {
  List<List<PublicDetail>> listList = [
    [PublicDetail('john', 'title1'), PublicDetail('john', 'title2')],
    [PublicDetail('mickel', 'title3')],
  ];

  listList.fold([[]], (previousValue, List<PublicDetail> element) => {});
}

class PublicDetail {
  PublicDetail(this.publicName, this.detailtitle);
  final String publicName;
  final String detailtitle;
}
