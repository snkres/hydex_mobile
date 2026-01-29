import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:pretty_animated_text/pretty_animated_text.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText({super.key});

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with TickerProviderStateMixin {
  final words = ["escape.", "rhythm.", "energy.", "favlor."];

  final List<List<Color>> wordGradients = [
    [Color(0xff51A2FF), Color(0xff00D3F2), Color(0xff51A2FF)],
    [Color(0xffD051FF), Color(0xffE600F2), Color(0xffF20079)],
    [Color(0xffFFF051), Color(0xff1CF200), Color(0xff51FF79)],
    [Color(0xffFFA251), Color(0xffF2AE00), Color(0xffFF5151)],
  ];

  late AnimationController _verticalController;
  late Animation<double> _verticalAnimation;
  late Timer _wordChangeTimer;
  int _currentWordIndex = 0;

  @override
  void initState() {
    super.initState();
    _verticalController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _verticalAnimation = Tween<double>(begin: 20, end: 0).animate(
      CurvedAnimation(parent: _verticalController, curve: Curves.easeOut),
    );

    _wordChangeTimer = Timer.periodic(Duration(seconds: 4), (_) {
      setState(() {
        _currentWordIndex = (_currentWordIndex + 1) % words.length;
      });
      _verticalController.forward(from: 0.0);
    });

    // Start the first animation
    _verticalController.forward();
  }

  @override
  void dispose() {
    _wordChangeTimer.cancel();
    _verticalController.dispose();
    super.dispose();
  }

  Shader _createGradientShader(List<Color> colors, double width) {
    return LinearGradient(
      colors: colors,
    ).createShader(Rect.fromLTWH(0.0, 0.0, width, 70.0));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _verticalAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _verticalAnimation.value),
          child: child,
        );
      },
      child: BlurText(
        key: ValueKey(_currentWordIndex),
        text: words[_currentWordIndex],
        duration: Duration(milliseconds: 1500),
        textStyle: TextStyle(
          fontSize: AppTextStyles(context).accumulator * 44,
          fontWeight: .w900,
          fontStyle: .italic,
          height: 0.9,
          foreground: Paint()
            ..shader = _createGradientShader(
              wordGradients[_currentWordIndex],
              100.0,
            ),
        ),
      ),
    );
  }
}
