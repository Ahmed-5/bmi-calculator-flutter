import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'reusable_card.dart';
import 'round_icon_button.dart';
import '../constants.dart';

class PlusMinusCard extends StatefulWidget {
  PlusMinusCard({this.value, this.text});

  int value;
  final String text;

  @override
  _PlusMinusCardState createState() => _PlusMinusCardState();
}

class _PlusMinusCardState extends State<PlusMinusCard> {
  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      color: kActiveCardColor,
      cardChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.text,
            style: kLabelTextStyle,
          ),
          Text(
            widget.value.toString(),
            style: kNumberTextStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundIconButton(
                icon: FontAwesomeIcons.minus,
                onPressed: () {
                  setState(() {
                    widget.value--;
                  });
                },
              ),
              SizedBox(
                width: 15.0,
              ),
              RoundIconButton(
                icon: FontAwesomeIcons.plus,
                onPressed: () {
                  setState(() {
                    widget.value++;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
