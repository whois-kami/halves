import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halves/core/constants/style_constants.dart';
import 'package:halves/features/searching/domain/entities/user_data.dart';
import 'package:halves/features/searching/presentation/bloc/search_bloc.dart';
import 'package:image_picker/image_picker.dart';

class FillProfileScreen extends StatelessWidget {
  const FillProfileScreen({super.key});

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
          const DataFormWidget(),
        ],
      ),
    );
  }
}

class PhotoPickerWidget extends StatefulWidget {
  final List<XFile?> photos;

  const PhotoPickerWidget({super.key, required this.photos});

  @override
  State<PhotoPickerWidget> createState() => _PhotoPickerWidgetState();
}

class _PhotoPickerWidgetState extends State<PhotoPickerWidget> {
  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: widget.photos.length + 1,
      separatorBuilder: (context, index) => const SizedBox(width: 10),
      itemBuilder: (context, index) {
        if (index == widget.photos.length) {
          return InkWell(
            onTap: () async {
              final XFile? image =
                  await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                setState(() {
                  widget.photos.add(image);
                });
              }
            },
            child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_outlined),
                      Text(
                        'Add photo',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                )),
          );
        } else {
          return Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(File(widget.photos[index]!.path)),
                ),
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
          );
        }
      },
    );
  }
}

class DataFormWidget extends StatefulWidget {
  const DataFormWidget({super.key});

  @override
  State<DataFormWidget> createState() => _DataFormWidgetState();
}

class _DataFormWidgetState extends State<DataFormWidget> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  final List<XFile?> photos = [];
  final Map<String, bool> _selectedChips = {
    'Drink': false,
    'Прогуляться': false,
    'Rest at sea': false,
    'Expensive food': false,
    'Rich man\'s': false,
    'Cinema': false,
    'Photography': false,
    'Оплата за встречи': false,
  };

  @override
  void initState() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          SizedBox(
            height: 100,
            child: PhotoPickerWidget(
              photos: photos,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'What\'s your name?',
          ),
          TextField(
            controller: nameController,
            cursorColor: Colors.white,
            cursorErrorColor: Colors.white,
            decoration: AppConstants.passInputDecorationStyle,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 30),
          Text('Add some description about you?'),
          TextField(
            controller: descriptionController,
            cursorColor: Colors.white,
            cursorErrorColor: Colors.white,
            decoration: AppConstants.passInputDecorationStyle,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: _selectedChips.keys.map((String label) {
              return ActionChip(
                labelStyle: TextStyle(
                    color:
                        _selectedChips[label]! ? Colors.white : Colors.black),
                backgroundColor: _selectedChips[label]!
                    ? const Color(0xFF1E1E1E)
                    : Colors.white,
                label: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: _selectedChips[label]!
                      ? Row(
                          key: ValueKey<bool>(_selectedChips[label]!),
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              child: Icon(Icons.check,
                                  size: 15,
                                  key: UniqueKey(),
                                  color: Colors.white),
                            ),
                            const SizedBox(width: 4),
                            Text(label),
                          ],
                        )
                      : Text(label,
                          key: ValueKey<bool>(_selectedChips[label]!)),
                ),
                onPressed: () {
                  setState(() {
                    _selectedChips[label] = !_selectedChips[label]!;
                  });
                },
              );
            }).toList(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          _ApplyButtonWidget(
            nameController: nameController,
            descriptionController: descriptionController,
            selectedTags: _selectedChips,
            photos: photos,
          ),
        ],
      ),
    );
  }
}

class _ApplyButtonWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final Map<String, bool> selectedTags;
  final List<XFile?> photos;
  const _ApplyButtonWidget(
      {super.key,
      required this.nameController,
      required this.descriptionController,
      required this.selectedTags,
      required this.photos});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SearchBloc>();
    UserProfileData user = UserProfileData(
      name: nameController.text,
      description: descriptionController.text,
      tags: selectedTags,
      photos: photos,
    );
    return ElevatedButton(
      onPressed: () => bloc.add(CreateProfileEvent(user: user)),
      child: Text('Find halve with halves'),
    );
  }
}
