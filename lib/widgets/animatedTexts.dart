import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimeText extends StatelessWidget {
  String text;
  AnimeText({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        WavyAnimatedText(
          text,
          textStyle: GoogleFonts.alegreya(fontSize: 35),
          speed: Duration(milliseconds: 700),
        ),
      ],
      totalRepeatCount: 100,
    );
  }
}
