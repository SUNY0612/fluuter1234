import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(BottleTalkApp());
}

class BottleTalkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BottleTalk',
      home: OceanScreen(),
    );
  }
}

class OceanScreen extends StatefulWidget {
  @override
  _OceanScreenState createState() => _OceanScreenState();
}

class _OceanScreenState extends State<OceanScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Bottle> bottles = [];
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // 애니메이션 컨트롤러
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat(reverse: true);

    // 병 5개 생성 (랜덤 위치)
    for (int i = 0; i < 5; i++) {
      bottles.add(Bottle(
        key: UniqueKey(),
        x: Random().nextDouble(),
        y: Random().nextDouble(),
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    player.dispose();
    super.dispose();
  }

  void playClickSound() async {
    await player.play(AssetSource('click.mp3')); // assets 폴더에 click.mp3 필요
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // 바다 배경
          Container(color: Colors.blue[300]),
          ...bottles.map((b) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                double sine = sin(_controller.value * 2 * pi);
                return Positioned(
                  left: b.x * screenSize.width,
                  top: (b.y * screenSize.height) + sine * 20,
                  child: GestureDetector(
                    onTap: () {
                      playClickSound();
                      showDialog(
                        context: context,
                        builder: (_) => BottleDialog(),
                      );
                    },
                    child: Icon(Icons.local_drink,
                        size: 50, color: Colors.brown),
                  ),
                );
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}

class Bottle {
  final Key key;
  final double x;
  final double y;
  Bottle({required this.key, required this.x, required this.y});
}

// 메시지 읽기 / 답장 다이얼로그
class BottleDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('병을 열었어요! 🌊'),
      content: Text('누군가의 메시지가 여기에 있어요...'),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text('그냥 흘려보내기')),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              // 답장하기 화면으로 이동 or 입력창
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text('답장 작성'),
                        content: TextField(),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('보내기')),
                        ],
                      ));
            },
            child: Text('답장하기')),
      ],
    );
  }
}
