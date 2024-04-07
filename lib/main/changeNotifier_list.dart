import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const ListenableBuilderExample());
}

// 리스트 상태를 관리하는 ChangeNotifier 클래스
class ListModel with ChangeNotifier {
  final List<int> _values = <int>[];
  List<int> get values => _values.toList(); // 변경 불가능한 리스트의 복사본 반환

  // 리스트에 새로운 값 추가 및 변경 사항 알림
  void add(int value) {
    _values.add(value);
    notifyListeners();
  }

  // 지정된 인덱스의 항목 삭제 및 변경 사항 알림
  void removeAt(int index) {
    _values.removeAt(index);
    notifyListeners();
  }
}

// 리스트뷰를 생성하고 리스트 모델을 전달하여 상태를 감시하는 StatefulWidget
class ListenableBuilderExample extends StatefulWidget {
  const ListenableBuilderExample({Key? key});

  @override
  State<ListenableBuilderExample> createState() =>
      _ListenableBuilderExampleState();
}

class _ListenableBuilderExampleState extends State<ListenableBuilderExample> {
  final ListModel _listNotifier = ListModel(); // 리스트 모델 인스턴스
  final math.Random _random = math.Random(0); // 랜덤 값을 생성하기 위한 인스턴스

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ListenableBuilder Example')),
        body: ListBody(listNotifier: _listNotifier), // 리스트 몸체 위젯에 리스트 모델 전달
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // 리스트에 새로운 항목 추가하는 버튼
            FloatingActionButton(
              onPressed: () => _listNotifier.add(
                  _random.nextInt(1 << 31)), // 랜덤 값을 리스트에 추가
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 8), // 버튼 간격 조절
            // 리스트에서 임의의 항목 삭제하는 버튼
            FloatingActionButton(
              onPressed: () {
                if (_listNotifier.values.isNotEmpty) {
                  final indexToRemove =
                  _random.nextInt(_listNotifier.values.length);
                  _listNotifier.removeAt(indexToRemove); // 임의의 항목 삭제
                }
              },
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}

// 리스트 몸체를 나타내는 StatelessWidget
class ListBody extends StatelessWidget {
  const ListBody({Key? key, required this.listNotifier});

  final ListModel listNotifier;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text('Current values:'), // 현재 값들을 나타내는 텍스트
          Expanded(
            child: ListenableBuilder(
              listenable: listNotifier,
              builder: (BuildContext context, Widget? child) {
                final List<int> values = listNotifier.values;
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) => ListTile(
                    title: Text('${values[index]}'), // 리스트 아이템
                  ),
                  itemCount: values.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
