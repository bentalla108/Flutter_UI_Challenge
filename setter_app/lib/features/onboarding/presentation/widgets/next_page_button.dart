import 'dart:math';

import 'package:flutter/material.dart';

class BNext extends StatefulWidget {
  final double totalPages;

  const BNext({super.key, required this.totalPages});

  @override
  State<BNext> createState() => _BNextState();
}

class _BNextState extends State<BNext> with TickerProviderStateMixin {
  late AnimationController controller;

  int curPage = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  void nextPage() {
    if (curPage == widget.totalPages) {
      curPage = 0;
    } else {
      curPage++;
    }
    controller.animateTo(curPage / widget.totalPages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (c, child) => Btn(
            value: controller.value,
            onTap: nextPage,
          ),
        ),
      ),
    );
  }
}

class Btn extends StatelessWidget {
  final double size;
  final double value;
  final void Function() onTap;
  const Btn({
    Key? key,
    this.size = 100,
    required this.onTap,
    required this.value,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size + 20,
      width: size + 20,
      child: Stack(
        children: [
          SizedBox(
            height: size + 20,
            width: size + 20,
            child: CustomPaint(
              painter: IndicatorPainter(value: value),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                height: size,
                width: size,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IndicatorPainter extends CustomPainter {
  final double value;
  IndicatorPainter({
    required this.value,
  }) : assert(value >= 0 && value <= 1);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = primaryColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final angle = 6.2832 * value;

    canvas.drawArc(
      const Offset(0, 0) & const Size(120, 120),
      -1.5708,
      angle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ArcPainter extends CustomPainter {
  final double value;
  final double size;
  ArcPainter(this.value, this.size) : super();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = primaryColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final paint2 = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    final radius = size.width / 2;
    // final angle = 2.0944 * index;
    final angle = 6.2832 * value;
    var x = radius * sin(angle);
    var y = radius * cos(angle);

    var h = radius;
    var k = radius;
    var center = Offset(-y, -x);

    if (value > 0) {
      canvas.drawCircle(Offset(h - center.dy, k + center.dx), 5, paint2);
    }

    canvas.drawArc(
      const Offset(0, 0) & Size(this.size, this.size),
      -1.5708,
      angle,
      false,
      paint,
    );
    // canvas.drawCircle(Offset(size.width / 2, size.height / 2), 100, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BNextPageEffect extends StatefulWidget {
  @override
  State<BNextPageEffect> createState() => BNextPageEffectState();
}

class BNextPageEffectState extends State<BNextPageEffect>
    with TickerProviderStateMixin {
  late AnimationController _ctrl;
  late int totalPages;
  late int index;

  @override
  void initState() {
    super.initState();
    totalPages = 10;
    index = 0;
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Index : $index"),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: _ctrl,
                builder: (c, child) {
                  return OnboardBtn(
                    onTap: () async {
                      if (index < totalPages) {
                        await _ctrl.animateTo(1 / totalPages * (index + 1));
                        setState(() {
                          index++;
                        });
                      }
                    },
                    value: _ctrl.value,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardBtn extends StatelessWidget {
  final double spacing;
  final double size;
  final double value;
  final void Function() onTap;

  const OnboardBtn({
    Key? key,
    required this.onTap,
    this.spacing = 10,
    this.size = 110,
    required this.value,
  })  : assert(value >= 0 && value <= 1),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        children: [
          SizedBox(
            height: size,
            width: size,
            child: CustomPaint(
              painter: ArcPainter(value, size),
            ),
          ),
          Center(
            child: TapEffect(
              onClick: onTap,
              child: Container(
                height: size - (spacing * 2),
                width: size - (spacing * 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor,
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Color primaryColor = const Color(0xFFA44F30);

class TapEffect extends StatefulWidget {
  const TapEffect(
      {super.key,
      this.isClickable = true,
      required this.onClick,
      required this.child});

  final bool isClickable;
  final VoidCallback onClick;
  final Widget child;

  @override
  _TapEffectState createState() => _TapEffectState();
}

class _TapEffectState extends State<TapEffect>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  DateTime tapTime = DateTime.now();
  bool isProgress = false;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    animationController!.animateTo(1.0,
        duration: const Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  Future<void> onTapCancel() async {
    if (widget.isClickable) {
      await _onDelayed();
      animationController!.animateTo(1.0,
          duration: const Duration(milliseconds: 240),
          curve: Curves.fastOutSlowIn);
    }
    isProgress = false;
  }

  Future<void> _onDelayed() async {
    if (widget.isClickable) {
      //this logic creator like more press experience with some delay
      final int tapDuration = DateTime.now().millisecondsSinceEpoch -
          tapTime.millisecondsSinceEpoch;
      if (tapDuration < 120) {
        await Future<dynamic>.delayed(
            Duration(milliseconds: 120 - tapDuration));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.isClickable) {
          await Future<dynamic>.delayed(const Duration(milliseconds: 280));
          try {
            if (!isProgress) {
              widget.onClick();
              isProgress = true;
            }
          } catch (_) {}
        }
      },
      onTapDown: (TapDownDetails details) {
        if (widget.isClickable) {
          tapTime = DateTime.now();
          animationController!.animateTo(0.9,
              duration: const Duration(milliseconds: 120),
              curve: Curves.fastOutSlowIn);
        }
        isProgress = true;
      },
      onTapUp: (TapUpDetails details) {
        onTapCancel();
      },
      onTapCancel: () {
        onTapCancel();
      },
      child: AnimatedBuilder(
        animation: animationController!,
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
            scale: animationController!.value,
            origin: const Offset(0.0, 0.0),
            child: widget.child,
          );
        },
      ),
    );
  }
}
