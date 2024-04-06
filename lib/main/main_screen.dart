import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_obesity/result/result_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _fromKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

// 메모리 리셋
  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비만도계산기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _fromKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _heightController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: '키'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '키를 입력하세요';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: '몸무게'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '몸무게를 입력하세요';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_fromKey.currentState?.validate() == false ) {
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          height: double.parse(_heightController.text),
                          weight: double.parse(_weightController.text)
                        ),
                      ),
                    );
                  },


                  
                  child: Text('결과'))
            ],
          ),
        ),
      ),
    );
  }
}