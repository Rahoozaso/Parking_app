import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:typed_data';
import 'package:gub1/real_use.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Uint8List? result; //이미지를 담을 변수 선언
  int something = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.5, width: double.infinity),
            _Showsomething(result: result),  // 상태를 전달
            SizedBox(height: MediaQuery.of(context).size.height*0.01, width: double.infinity),
            _Button(context),
          ],
        ),
      );
  }


  Widget _Button(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 70,
          height: 60,
          child: ElevatedButton(
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const RealUse()),
              );
              setState(() {
                this.result = result;
              });
            },
            child: Text(
              "+",
              textAlign: TextAlign.center,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(246, 242, 249, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
  Widget _Showsomething({Uint8List? result}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.9,
          height: MediaQuery.of(context).size.height*0.3,
          decoration: BoxDecoration(
            color: Color.fromRGBO(246,242,249,1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: result != null
            ? ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.memory(
                result,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            )
          : const Text(
            "현재 등록된 정보가 없습니다",
            textScaleFactor: 1,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          )
        ),
      ],
    );
  }
}