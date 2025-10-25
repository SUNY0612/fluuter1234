import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MySchoolApp());
}

// ---------------- App ----------------
class MySchoolApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '나의 학교 퀴즈',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ---------------- SplashScreen ----------------
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text(
              "학교 퀴즈 앱",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}

// ---------------- LoginScreen ----------------
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nicknameController = TextEditingController();
  final _statusController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.blue.shade600],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 12,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.school, size: 90, color: Colors.blue),
                    SizedBox(height: 12),
                    Text(
                      "나의 학교 퀴즈 앱",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _nicknameController,
                      decoration: InputDecoration(
                        labelText: '닉네임',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: _statusController,
                      decoration: InputDecoration(
                        labelText: '상태 메시지',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        String nick = _nicknameController.text.trim();
                        String status = _statusController.text.trim();
                        if (nick.isNotEmpty) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  MainScreen(nickname: nick, status: status),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text('닉네임을 입력하세요')));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 36,
                          vertical: 12,
                        ),
                        backgroundColor: Colors.green,
                      ),
                      child: Text("시작하기", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- MainScreen ----------------
class MainScreen extends StatefulWidget {
  String nickname;
  String status;

  MainScreen({required this.nickname, required this.status});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  int score = 0;
  int coins = 0;
  List<String> solvedQuestions = [];

  List<Map<String, String>> quizList = [
    {'q': '태양계에서 가장 큰 행성은 무엇일까요?', 'a': '목성'},
    {'q': '지구에서 가장 깊은 바다는 어디일까요?', 'a': '마리아나 해구'},
    {'q': '무지개는 몇 가지 색으로 이루어져 있을까요?', 'a': '7가지'},
    {'q': '새는 알을 낳는다. 포유류는 무엇을 낳을까요?', 'a': '새끼'},
    {'q': '지구의 자연 위성은 무엇일까요?', 'a': '달'},
    {'q': '대한민국의 초대 대통령은 누구일까요?', 'a': '이승만'},
    {'q': '에디슨이 발명한 중요한 발명품 중 하나는 무엇일까요?', 'a': '전구'},
    {'q': '콜럼버스가 아메리카 대륙을 발견한 해는 언제일까요?', 'a': '1492년'},
    {'q': '한글을 창제한 왕은 누구일까요?', 'a': '세종대왕'},
    {'q': '이순신 장군이 지휘한 유명한 해전은 무엇일까요?', 'a': '한산도 대첩'},
  ];

  String _currentQuestion = "";

  @override
  void initState() {
    super.initState();
    _nextQuestion();
  }

  void _nextQuestion() {
    quizList.shuffle();
    setState(() {
      _currentQuestion = quizList.first['q']!;
    });
  }

  void _answerQuestion(String answer) {
    final correct = quizList.first['a']!;
    bool isCorrect = answer.trim() == correct;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isCorrect ? "정답!" : "오답"),
        content: isCorrect ? Text("정답이에요! +1 코인 획득 🎉") : Text("정답은: $correct"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              if (isCorrect) {
                setState(() {
                  score++;
                  coins += 1;
                  solvedQuestions.add(quizList.first['q']!);
                });
              }
              _nextQuestion();
            },
            child: Text("확인"),
          ),
        ],
      ),
    );
  }

  String _avatarEmoji() {
    if (coins < 3) return "🙂";
    if (coins < 6) return "😎";
    return "😁";
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      // 홈
      HomeTab(
        nickname: widget.nickname,
        coins: coins,
        score: score,
        avatar: _avatarEmoji(),
      ),
      // 프로필
      ProfileTab(
        nickname: widget.nickname,
        status: widget.status,
        solvedQuestions: solvedQuestions,
        avatar: _avatarEmoji(),
        onEditProfile: (newName, newStatus) {
          setState(() {
            if (newName.isNotEmpty) widget.nickname = newName;
            if (newStatus.isNotEmpty) widget.status = newStatus;
          });
        },
      ),
      // 게임
      GameTab(question: _currentQuestion, onAnswer: _answerQuestion),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: '게임'),
        ],
      ),
    );
  }
}

// ---------------- HomeTab ----------------
class HomeTab extends StatelessWidget {
  final String nickname;
  final int coins;
  final int score;
  final String avatar;

  HomeTab({
    required this.nickname,
    required this.coins,
    required this.score,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("홈")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(avatar, style: TextStyle(fontSize: 80)),
            SizedBox(height: 20),
            Text(
              "$nickname 님",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.monetization_on, color: Colors.amber, size: 28),
                SizedBox(width: 6),
                Text(
                  "$coins 코인",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              "맞춘 문제: $score",
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- ProfileTab ----------------
class ProfileTab extends StatelessWidget {
  final String nickname;
  final String status;
  final List<String> solvedQuestions;
  final String avatar;
  final Function(String, String) onEditProfile;

  ProfileTab({
    required this.nickname,
    required this.status,
    required this.solvedQuestions,
    required this.avatar,
    required this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("프로필")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(avatar, style: TextStyle(fontSize: 80)),
            SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                final nameController = TextEditingController(text: nickname);
                final statusController = TextEditingController(text: status);
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text("프로필 수정"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(labelText: "닉네임"),
                        ),
                        TextField(
                          controller: statusController,
                          decoration: InputDecoration(labelText: "상태 메시지"),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("취소"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          onEditProfile(
                            nameController.text,
                            statusController.text,
                          );
                          Navigator.pop(context);
                        },
                        child: Text("저장"),
                      ),
                    ],
                  ),
                );
              },
              child: Column(
                children: [
                  Text(
                    nickname,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6),
                  Text(status, style: TextStyle(color: Colors.grey[700])),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "맞춘 문제 목록",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: solvedQuestions.length,
                itemBuilder: (context, idx) {
                  return ListTile(
                    leading: Icon(Icons.check, color: Colors.green),
                    title: Text(solvedQuestions[idx]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- GameTab ----------------
class GameTab extends StatelessWidget {
  final String question;
  final Function(String) onAnswer;

  GameTab({required this.question, required this.onAnswer});

  final _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("퀴즈 게임")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              question,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(
                labelText: "정답 입력",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final ans = _answerController.text.trim();
                if (ans.isNotEmpty) {
                  onAnswer(ans);
                  _answerController.clear();
                }
              },
              child: Text("제출", style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 36, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
