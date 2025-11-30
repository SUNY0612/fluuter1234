import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

void main() {
  runApp(const BottleApp());
}

class BottleApp extends StatelessWidget {
  const BottleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BottleHomePage(),
    );
  }
}

class BottleHomePage extends StatefulWidget {
  const BottleHomePage({super.key});

  @override
  State<BottleHomePage> createState() => _BottleHomePageState();
}

class _BottleHomePageState extends State<BottleHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;
  late AudioPlayer bgmPlayer;
  final clickPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    // 배경음 플레이
    bgmPlayer = AudioPlayer();
    bgmPlayer.setReleaseMode(ReleaseMode.loop);
    bgmPlayer.play(AssetSource('bgm.mp3')); // 배경음

    // 유리병 둥실 애니메이션
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -15, end: 15)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    bgmPlayer.dispose();
    clickPlayer.dispose();
    super.dispose();
  }

  void playClickSound() async {
    await clickPlayer.play(AssetSource('click.mp3'));
  }

  void _openBottle() {
    playClickSound();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LetterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final bottleSize = screen.width * 0.55;

    return Scaffold(
      body: Stack(
        children: [
          Container(color: const Color(0xFFBEE3F8)), // 하늘색 배경

          // 간단 구름/물결 느낌
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                top: 100 + sin(_controller.value * 2 * pi) * 20,
                left: 50 + cos(_controller.value * 2 * pi) * 30,
                child: Opacity(
                  opacity: 0.15,
                  child: Container(
                    width: 120,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              );
            },
          ),

          // 유리병
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                double dx = sin(_controller.value * 2 * pi) * 20;
                double dy = sin(_controller.value * 2 * pi) * 10;
                return Transform.translate(
                  offset: Offset(dx, dy),
                  child: SizedBox(
                    width: bottleSize,
                    child: GestureDetector(
                      onTap: _openBottle,
                      child: Image.asset(
                        'assets/유리병.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LetterPage extends StatelessWidget {
  const LetterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1), // 편지지 배경
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFECB3),
        title: const Text("유리병 편지"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3CD),
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(2, 2),
                blurRadius: 6,
              ),
            ],
          ),
          child: const TextField(
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "당신의 고민을 적어보세요...",
            ),
          ),
        ),
      ),
    );
  }
}
