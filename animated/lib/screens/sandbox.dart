import 'package:flutter/material.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  double _margin = 0, _opacity = 1, _width = 200;
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(seconds: 1),
        child: AnimatedContainer(
          width: _width,
          color: _color,
          margin: EdgeInsets.all(_margin),
          duration: const Duration(seconds: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => setState(() {
                  _margin = 20;
                }),
                child: Text('Animate Margin'),
              ),
              ElevatedButton(
                onPressed: () => setState(() {
                  _width = 100;
                }),
                child: Text('Animate Width'),
              ),
              ElevatedButton(
                onPressed: () => setState(() {
                  _color = Colors.amber;
                  _opacity = 0.2;
                }),
                child: Text('Animate Color'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
