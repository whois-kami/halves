import 'package:flutter/material.dart';
import 'package:halves/features/searching/presentation/widgets/data_form_widget.dart';

class FillProfileScreen extends StatelessWidget {
  final String sex;
  const FillProfileScreen({super.key, required this.sex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All that\'s left to do \nis fill out the profile'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          DataFormWidget(sex: sex),
        ],
      ),
    );
  }
}





