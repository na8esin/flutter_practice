void main() {
  List<List<PublicDetail>> listList = [
    [PublicDetail('john', 'title1'), PublicDetail('john', 'title2')],
    [PublicDetail('mickel', 'title3')],
  ];

  List<PublicDetail> details = listList.fold<List<PublicDetail>>([],
      (List<PublicDetail> previousValue, List<PublicDetail> element) {
    previousValue.addAll(element.map((e) => e));
    return previousValue;
  });

  // [Instance of 'PublicDetail', Instance of 'PublicDetail', Instance of 'PublicDetail']
  print(details);
}

class PublicDetail {
  PublicDetail(this.publicName, this.detailtitle);
  final String publicName;
  final String detailtitle;
}
