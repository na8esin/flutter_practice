import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/*
 * セグメント
 */
enum Segment {
  day,
  night,
}

class SegmentController extends StateNotifier<Segment> {
  SegmentController(Segment state) : super(state);

  setSegment(segment) {
    state = segment;
  }

  Color getButtonColor(segment) {
    if (state == segment) {
      return Colors.red;
    }
    return Colors.grey;
  }
}

final segmentProvider =
    StateNotifierProvider((ref) => SegmentController(Segment.day));

/*
 * dayとnightを切り替える
 */
class SegmentWidget extends HookWidget {
  SegmentWidget() : super();

  @override
  Widget build(BuildContext context) {
    final segmentController = useProvider(segmentProvider);
    return Container(
      height: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
              onPressed: () => segmentController.setSegment(Segment.day),
              child: Text("day"),
              color: segmentController.getButtonColor(Segment.day)),
          FlatButton(
            onPressed: () => segmentController.setSegment(Segment.night),
            child: Text("night"),
            color: segmentController.getButtonColor(Segment.night),
          ),
        ],
      ),
    );
  }
}
