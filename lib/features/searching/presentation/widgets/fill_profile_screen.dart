import 'package:flutter/material.dart';
import 'package:halves/core/constants/text_constants.dart';
import 'package:halves/features/searching/presentation/widgets/data_form_widget.dart';

class FillProfileScreen extends StatelessWidget {
  final String sex;
  const FillProfileScreen({super.key, required this.sex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        foregroundColor: Colors.white,
        title: Text(AppTextConstants.fillProfileAppBarText),
        centerTitle: true,
      ),
      body: Column(
        children: [
          DataFormWidget(sex: sex),
        ],
      ),
    );
  }
}
