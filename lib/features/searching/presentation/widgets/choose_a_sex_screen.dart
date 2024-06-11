import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChooseSexScreen extends StatefulWidget {
  const ChooseSexScreen({super.key});

  @override
  State<ChooseSexScreen> createState() => _ChooseSexScreenState();
}

class _ChooseSexScreenState extends State<ChooseSexScreen> {
  bool male = false;
  bool female = false;
  bool another = false;
  bool isAnySelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        width: 300,
        margin: const EdgeInsets.all(10),
        child: isAnySelected
            ? ElevatedButton(
                onPressed: () {
                  final selectedSex = getSelectedSex();
                  if (selectedSex.isNotEmpty) {
                    context
                        .pushReplacement('/chooseSex/fillProfile/$selectedSex');
                  }
                },
                child: const Text('NEXT!'),
              )
            : const SizedBox(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              checkBoxRow(
                  title: 'I\'m a girl',
                  isChecked: female,
                  onChanged: (bool? newValue) {
                    setState(() {
                      female = newValue!;
                      another = false;
                      male = false;
                      checkIfAnySelected();
                    });
                  }),
              const SizedBox(height: 15),
              checkBoxRow(
                  title: 'I\'m a man',
                  isChecked: male,
                  onChanged: (bool? newValue) {
                    setState(() {
                      male = newValue!;
                      another = false;
                      female = false;
                      checkIfAnySelected();
                    });
                  }),
              const SizedBox(height: 15),
              checkBoxRow(
                title: 'I\'m a another',
                isChecked: another,
                onChanged: (bool? newValue) {
                  setState(() {
                    another = newValue!;
                    female = false;
                    male = false;
                    checkIfAnySelected();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkBoxRow({
    required String title,
    required bool isChecked,
    required Function(bool?)? onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color(0xFFFD00A6),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.8,
            child: Checkbox(
              side: BorderSide(color: Colors.white),
              fillColor: MaterialStatePropertyAll(Colors.white),
              value: isChecked,
              onChanged: onChanged,
              activeColor: Colors.white,
              checkColor: Colors.black.withOpacity(0.6),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  void checkIfAnySelected() {
    setState(() {
      isAnySelected = male || female || another;
    });
  }

  String getSelectedSex() {
    if (male) {
      return 'male';
    } else if (female) {
      return 'female';
    } else if (another) {
      return 'another';
    }
    return '';
  }
}
