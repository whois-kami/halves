import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
            child: Stack(
              children: [
                Positioned(
                  top: -7,
                  right: -7,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        widget.photos.removeAt(index);
                      });
                    },
                    icon: const Icon(
                      Icons.highlight_remove_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}