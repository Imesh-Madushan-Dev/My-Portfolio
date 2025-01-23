import 'dart:html' as html;

void downloadFile(String url, String filename) {
  final anchor = html.AnchorElement()
    ..href = url
    ..setAttribute('download', filename)
    ..style.display = 'none';

  html.document.body!.children.add(anchor);
  anchor.click();
  anchor.remove();
}
