import 'package:flutter/material.dart';

class Animated_expand extends StatefulWidget {
  bool is_expand = false;
  Widget child;
  Animated_expand({@required this.child, @required this.is_expand});

  @override
  _Animated_expandState createState() => _Animated_expandState();
}

class _Animated_expandState extends State<Animated_expand>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> animation;
  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn);
    super.initState();
  }

  void _runExpandCheck() {
    if (widget.is_expand) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void didUpdateWidget(Animated_expand oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: 1.0,
      child: widget.child,
    );
  }
}
