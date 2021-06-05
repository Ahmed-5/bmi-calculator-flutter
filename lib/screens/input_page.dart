import 'package:bmi_calculator/screens/results_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/reusable_card.dart';
import '../components/icon_content.dart';
import '../components/plus_minus_card.dart';
import '../components/bottom_button.dart';
import 'package:bmi_calculator/calculator_brain.dart';
import '../constants.dart';

enum Gender {
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender activeCard;
  int height = 180;
  int weight = 60;
  int age = 25;

  Color colorCard(Gender card) {
    return activeCard == card ? kActiveCardColor : kInactiveCardColor;
  }

  onTap(Gender card) {
    setState(() {
      activeCard = card;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ReusableCard(
                      color: colorCard(Gender.male),
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.mars,
                        text: 'MALE',
                      ),
                      onTap: () {
                        onTap(Gender.male);
                      },
                    ),
                  ),
                  Expanded(
                    child: ReusableCard(
                      color: colorCard(Gender.female),
                      cardChild: IconContent(
                        icon: FontAwesomeIcons.venus,
                        text: 'FEMALE',
                      ),
                      onTap: () {
                        onTap(Gender.female);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ReusableCard(
                color: kActiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'HEIGHT',
                      style: kLabelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          height.toString(),
                          style: kNumberTextStyle,
                        ),
                        Text(
                          'cm',
                          style: kLabelTextStyle,
                        )
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 30.0),
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: kInactiveSliderColor,
                        thumbColor: kBottomContainerColor,
                        overlayColor: kThumbOverlayColor,
                        trackHeight: 1.5,
                      ),
                      child: Slider(
                        min: kMinHeight,
                        max: kMaxHeight,
                        value: height.toDouble(),
                        onChanged: (double value) {
                          setState(() {
                            height = value.round();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: PlusMinusCard(
                      value: weight,
                      text: 'WEIGHT',
                    ),
                  ),
                  Expanded(
                    child: PlusMinusCard(
                      value: age,
                      text: 'AGE',
                    ),
                  ),
                ],
              ),
            ),
            BottomButton(
              text: 'CALCULATE',
              onTap: () {
                CalculatorBrain calculatorBrain = CalculatorBrain(
                  height: height,
                  weight: weight,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultsPage(
                      bmi: calculatorBrain.calculateBMI(),
                      bmiResult: calculatorBrain.getResult(),
                      bmiInterpretation: calculatorBrain.getInterpretation(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
