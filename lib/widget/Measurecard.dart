import 'package:flutter/material.dart';
import 'package:balance/constants.dart';

class ReusableWidget extends StatelessWidget {
  ReusableWidget(
      {@required this.color,
      @required this.value,
      @required this.precision,
      @required this.text,
      @required this.metric,
      @required this.slider});

  final Color color;
  final double value;
  final int precision;
  final String text;
  final String metric;
  final Slider slider;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: klabelTextStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value.toStringAsFixed(precision),
                style: knumberTextStyle,
              ),
              Text(
                ' $metric',
                style: klabelTextStyle,
              )
            ],
          ),
          SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.white,
                thumbColor: Colors.white,
                overlayColor: Color(0x51FFFFFF),
              ),
              child: slider)
        ],
      ),
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
    );
  }
}
