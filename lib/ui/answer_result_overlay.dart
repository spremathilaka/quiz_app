import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnswerResultOverlay extends StatefulWidget {
  final bool _isCorrect;
  final VoidCallback _onTap;

  AnswerResultOverlay(this._isCorrect,this._onTap);

  @override
  State createState() => AnswerResultOverlayState();
}

class AnswerResultOverlayState extends State<AnswerResultOverlay>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    super.initState();
    _iconAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _iconAnimation = CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.elasticOut);
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }


  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.black54,
        child: InkWell(
          onTap: () => widget._onTap(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Transform.rotate(
                  angle: _iconAnimation.value * 2 * math.pi,
                  child: Icon(
                    widget._isCorrect == true ? Icons.done : Icons.clear,
                    size: _iconAnimation.value * 80.0,
                  ),
                ),
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
              ),
              Text(
                widget._isCorrect == true ? "Correct!!" : "Wrong!!",
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              )
            ],
          ),
        ));
  }
}
