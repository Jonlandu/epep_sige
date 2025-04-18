import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';

class GenderSelectionWidget extends StatelessWidget {
  final bool showOtherGender;
  final bool alignVertical;
  final ValueChanged<Gender?> onChanged;

  const GenderSelectionWidget({
    Key? key,
    required this.showOtherGender,
    required this.alignVertical,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            "Choose your Gender",
          ),
          SizedBox(height: 9,),
          GenderPickerWithImage(
            showOtherGender: showOtherGender,
            verticalAlignedText: alignVertical,
            selectedGender: Gender.Others,
            selectedGenderTextStyle: TextStyle(
              color: Color(0xFF8b32a8),
              fontWeight: FontWeight.bold,
            ),
            unSelectedGenderTextStyle: TextStyle(
              fontWeight: FontWeight.normal,
            ),
            onChanged: onChanged,
            equallyAligned: true,
            animationDuration: Duration(milliseconds: 300),
            isCircular: true,
            opacityOfGradient: 0.4,
            padding: const EdgeInsets.all(3),
            size: 50,
          ),
        ],
      ),
    );
  }
}