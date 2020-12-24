// vscodeだとブラウザが起動しちゃう
void main() {
  print(x);
}

/**
 * The type of the function literal can't be inferred because the literal has a block as its body.
 * Try adding an explicit type to the variable.
 * https://github.com/dart-lang/sdk/issues/34503
 */
var x = [1, 2, 3].map((x) {
  return x.toString();
}).toList();

List<String> y = [1, 2, 3].map((y) {
  return y.toString();
}).toList();

/* 型が違ってると、エラーになる。なら、推測できてるじゃん？
List<bool> z = [1, 2, 3].map((y) {
  return y.toString();
}).toList();
*/
