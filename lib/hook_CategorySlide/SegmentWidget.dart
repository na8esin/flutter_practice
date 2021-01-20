import 'package:flutter/material.dart';

/*
 * セグメント
 */
enum Segment {
  day,
  night,
}

/*
 * セグメントコールバック
 */
typedef SegmentCallback = void Function(Segment segment);

/*
 * セグメントウィジェット
 */
class SegmentWidget extends StatelessWidget {
  // セグメント選択コールバック
  final SegmentCallback callback;

  // セグメント
  Segment segment = Segment.day;

  SegmentWidget(this.segment, this.callback) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              _updateButtonState(Segment.day);
            },
            child: Text("day"),
            color: _getButtonColor(Segment.day),
          ),
          FlatButton(
            onPressed: () {
              _updateButtonState(Segment.night);
            },
            child: Text("night"),
            color: _getButtonColor(Segment.night),
          ),
        ],
      ),
    );
  }

  /*
   * ボタンの状態を更新
   */
  void _updateButtonState(Segment seg) {
    if (segment == seg) {
      return;
    }

    if (callback != null) {
      callback(seg);
    }
  }

  /*
   * 状態に応じたボタン色を返す
   */
  Color _getButtonColor(Segment seg) {
    if (segment == seg) {
      return Colors.red;
    }
    return Colors.grey;
  }
}
