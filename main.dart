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

[{
	"resource": "/c:/Users/김지율/Desktop/flutter 1/flutter_application_1/lib/main.dart",
	"owner": "_generated_diagnostic_collection_name_#0",
	"code": {
		"value": "uri_does_not_exist",
		"target": {
			"$mid": 1,
			"path": "/diagnostics/uri_does_not_exist",
			"scheme": "https",
			"authority": "dart.dev"
		}
	},
	"severity": 8,
	"message": "Target of URI doesn't exist: 'package:audioplayers/audioplayers.dart'.\nTry creating the file referenced by the URI, or try using a URI for a file that does exist.",
	"source": "dart",
	"startLineNumber": 3,
	"startColumn": 8,
	"endLineNumber": 3,
	"endColumn": 48,
	"origin": "extHost1"
},{
	"resource": "/c:/Users/김지율/Desktop/flutter 1/flutter_application_1/lib/main.dart",
	"owner": "_generated_diagnostic_collection_name_#0",
	"code": {
		"value": "undefined_method",
		"target": {
			"$mid": 1,
			"path": "/diagnostics/undefined_method",
			"scheme": "https",
			"authority": "dart.dev"
		}
	},
	"severity": 8,
	"message": "The method 'AudioPlayer' isn't defined for the type '_OceanScreenState'.\nTry correcting the name to the name of an existing method, or defining a method named 'AudioPlayer'.",
	"source": "dart",
	"startLineNumber": 25,
	"startColumn": 18,
	"endLineNumber": 25,
	"endColumn": 29,
	"origin": "extHost1"
},{
	"resource": "/c:/Users/김지율/Desktop/flutter 1/flutter_application_1/lib/main.dart",
	"owner": "_generated_diagnostic_collection_name_#0",
	"code": {
		"value": "undefined_method",
		"target": {
			"$mid": 1,
			"path": "/diagnostics/undefined_method",
			"scheme": "https",
			"authority": "dart.dev"
		}
	},
	"severity": 8,
	"message": "The method 'AssetSource' isn't defined for the type '_OceanScreenState'.\nTry correcting the name to the name of an existing method, or defining a method named 'AssetSource'.",
	"source": "dart",
	"startLineNumber": 56,
	"startColumn": 23,
	"endLineNumber": 56,
	"endColumn": 34,
	"origin": "extHost1"
},{
	"resource": "/c:/Users/김지율/Desktop/flutter 1/flutter_application_1/lib/main.dart",
	"owner": "_generated_diagnostic_collection_name_#0",
	"code": {
		"value": "use_key_in_widget_constructors",
		"target": {
			"$mid": 1,
			"path": "/diagnostics/use_key_in_widget_constructors",
			"scheme": "https",
			"authority": "dart.dev"
		}
	},
	"severity": 2,
	"message": "Constructors for public widgets should have a named 'key' parameter.\nTry adding a named parameter to the constructor.",
	"source": "dart",
	"startLineNumber": 9,
	"startColumn": 7,
	"endLineNumber": 9,
	"endColumn": 20,
	"origin": "extHost1"
},{
	"resource": "/c:/Users/김지율/Desktop/flutter 1/flutter_application_1/lib/main.dart",
	"owner": "_generated_diagnostic_collection_name_#0",
	"code": {
		"value": "use_key_in_widget_constructors",
		"target": {
			"$mid": 1,
			"path": "/diagnostics/use_key_in_widget_constructors",
			"scheme": "https",
			"authority": "dart.dev"
		}
	},
	"severity": 2,
	"message": "Constructors for public widgets should have a named 'key' parameter.\nTry adding a named parameter to the constructor.",
	"source": "dart",
	"startLineNumber": 16,
	"startColumn": 7,
	"endLineNumber": 16,
	"endColumn": 18,
	"origin": "extHost1"
},{
	"resource": "/c:/Users/김지율/Desktop/flutter 1/flutter_application_1/lib/main.dart",
	"owner": "_generated_diagnostic_collection_name_#0",
	"code": {
		"value": "library_private_types_in_public_api",
		"target": {
			"$mid": 1,
			"path": "/diagnostics/library_private_types_in_public_api",
			"scheme": "https",
			"authority": "dart.dev"
		}
	},
	"severity": 2,
	"message": "Invalid use of a private type in a public API.\nTry making the private type public, or making the API that uses the private type also be private.",
	"source": "dart",
	"startLineNumber": 18,
	"startColumn": 3,
	"endLineNumber": 18,
	"endColumn": 20,
	"origin": "extHost1"
},{
	"resource": "/c:/Users/김지율/Desktop/flutter 1/flutter_application_1/lib/main.dart",
	"owner": "_generated_diagnostic_collection_name_#0",
	"code": {
		"value": "unnecessary_to_list_in_spreads",
		"target": {
			"$mid": 1,
			"path": "/diagnostics/unnecessary_to_list_in_spreads",
			"scheme": "https",
			"authority": "dart.dev"
		}
	},
	"severity": 2,
	"message": "Unnecessary use of 'toList' in a spread.\nTry removing the invocation of 'toList'.",
	"source": "dart",
	"startLineNumber": 92,
	"startColumn": 14,
	"endLineNumber": 92,
	"endColumn": 20,
	"origin": "extHost1"
},{
	"resource": "/c:/Users/김지율/Desktop/flutter 1/flutter_application_1/lib/main.dart",
	"owner": "_generated_diagnostic_collection_name_#0",
	"code": {
		"value": "use_key_in_widget_constructors",
		"target": {
			"$mid": 1,
			"path": "/diagnostics/use_key_in_widget_constructors",
			"scheme": "https",
			"authority": "dart.dev"
		}
	},
	"severity": 2,
	"message": "Constructors for public widgets should have a named 'key' parameter.\nTry adding a named parameter to the constructor.",
	"source": "dart",
	"startLineNumber": 107,
	"startColumn": 7,
	"endLineNumber": 107,
	"endColumn": 19,
	"origin": "extHost1"
}]
