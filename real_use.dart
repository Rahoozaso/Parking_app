import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:numberpicker/numberpicker.dart';



class NumberPickerForFloor extends StatefulWidget {
  const NumberPickerForFloor({super.key});

  @override
  _NumberPickerFloor createState() => _NumberPickerFloor();
}

class _NumberPickerFloor extends State<NumberPickerForFloor> {
  int _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          NumberPicker(
            value: _currentValue,
            minValue: -10,
            maxValue: 10,
            axis: Axis.horizontal,  // Set the axis to horizontal
            onChanged: (newValue) {
              setState(() {
                _currentValue = newValue;
              });
            },
          ),
          Text("Current number: $_currentValue"),
        ],
      ),
    ); // Added missing semicolon
  }
}


class RealUse extends StatefulWidget {
  const RealUse({Key? key}) : super(key: key);

  @override
  State<RealUse> createState() => _MyRealUse();
}

class _MyRealUse extends State <RealUse> {
  XFile? _image; //이미지를 담을 변수 선언
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

  //이미지를 가져오는 함수
  Future<void> getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
    }
  }
  Future<Uint8List?> _convertImageToUint8List(XFile? imageFile) async {
    if (imageFile == null) return null;
    return await imageFile.readAsBytes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100, width: double.infinity),
            _buildPhotoArea(),
            SizedBox(height: 20),
            _buildPickImageButton(),
            SizedBox(height: 20),
            _GoBackButton(),
            SizedBox(height: 20),
            NumberPickerForFloor()
          ],
        ),
      );
  }

  Widget _buildPhotoArea() {
    return Container(
      width: MediaQuery.of(context).size.height*0.7,
      height: MediaQuery.of(context).size.height*0.3,
      child: _image != null
          ? Container(
          child:Image.file(File(_image!.path),
            fit: BoxFit.cover,),
      ) // 가져온 이미지를 화면에 띄워주는 코드
          : Image.asset('asset/img/img1.png'), // 기본 이미지 경로 수정 (assets)
    );
  }
  Widget _GoBackButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            Uint8List? imageData = await _convertImageToUint8List(_image);
            Navigator.pop(context,imageData);
          },
          child: Text("Check"),
        ),
      ],
    );
  }
  Widget _buildPickImageButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => getImage(ImageSource.camera),
          child: Text("주차사진")
        ),
      ],
    );
  }
  Widget _CheckButton(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 70,
          width: 70,
          child: Icon(Icons.add_box_outlined),
        )
      ],
    );
  }
}
