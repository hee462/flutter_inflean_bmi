import 'package:flutter/material.dart';

void main() {
  runApp(const ListenableBuilderExample());
}

class ItemModel with ChangeNotifier {
  List<String> _items = []; // 아이템 목록을 저장하는 변수
  List<String> get items => _items;

  void addItem(String item) {
    _items.add(item); // 아이템을 목록에 추가
    notifyListeners(); // 상태 변경을 알림
  }
}

class ListenableBuilderExample extends StatefulWidget {
  const ListenableBuilderExample({Key? key});

  @override
  State<ListenableBuilderExample> createState() =>
      _ListenableBuilderExampleState();
}

class _ListenableBuilderExampleState extends State<ListenableBuilderExample> {
  final ItemModel _itemModel = ItemModel(); // 아이템 모델 인스턴스 생성

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () {
                _itemModel.addItem('Item2 ${_itemModel.items.length + 1}');
              },
              icon: Icon(Icons.connected_tv_sharp))
        ], title: const Text('ListenableBuilder Example')),

        body: ItemList(itemModel: _itemModel), // 아이템 목록 위젯에 아이템 모델 전달
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _itemModel.addItem('Item ${_itemModel.items.length + 1}');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({Key? key, required this.itemModel});

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Current item count:'),
          // 아이템 개수가 변경될 때마다 화면을 다시 그립니다.
          ListenableBuilder(
            listenable: itemModel, // 아이템 모델을 감시합니다.
            builder: (BuildContext context, Widget? child) {
              return Text('${itemModel.items.length}'); // 아이템 개수를 표시합니다.
            },
          ),
        ],
      ),
    );
  }
}
