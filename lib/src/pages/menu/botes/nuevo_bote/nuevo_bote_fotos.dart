import 'dart:io';

import 'package:boaty/src/providers/botes_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NuevoBoteFotos extends StatefulWidget {
  NuevoBoteFotos({Key? key}) : super(key: key);

  @override
  _NuevoBoteFotosState createState() => _NuevoBoteFotosState();
}

class _NuevoBoteFotosState extends State<NuevoBoteFotos> {
  @override
  Widget build(BuildContext context) {
    String test = '';
    final botesForm = Provider.of<BotesFormProvider>(context);

    Size _screenSize = MediaQuery.of(context).size;

    final picker = new ImagePicker();

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: _screenSize.width * 0.060,
            mainAxisSpacing: _screenSize.height * 0.040
          ),
          itemCount: 6, 
          itemBuilder: (BuildContext context, i) {
            if (botesForm.photosFilesList.containsKey(i)) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45, width: 2),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    botesForm.photosFilesList[i]!,
                    fit: BoxFit.cover,
                  ),
                )
              );
            } else {
              return InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45, width: 2),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Icon(
                    Icons.add, 
                    size: 48,
                    color: Colors.black45,
                  ),
                ),
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black45, width: 2),
                                        borderRadius: BorderRadius.circular(12)
                                      ),
                                      child: Icon(
                                        Icons.photo_camera, 
                                        size: 48,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    SizedBox(height: 12,),
                                    Text('Camara')
                                  ],
                                ),
                                onTap: () async {
                                  
                                  final XFile? pickedFile = await picker.pickImage(
                                    source: ImageSource.camera,
                                    maxHeight: 640, 
                                    maxWidth: 360,
                                    imageQuality: 50
                                  );
                                  if (pickedFile == null) return;
                                  
                                  File rotatedImage = await FlutterExifRotation.rotateImage(path: pickedFile.path);
                                  
                                  botesForm.photosFilesList[i] = rotatedImage;
                                  setState(() {});
      
                                  Navigator.pop(context);
                                },
                              ),
                              InkWell(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black45, width: 2),
                                        borderRadius: BorderRadius.circular(12)
                                      ),
                                      child: Icon(
                                        Icons.collections, 
                                        size: 48,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    SizedBox(height: 12,),
                                    Text('Galeria')
                                  ],
                                ),
                                onTap: () async {
                                  final XFile? pickedFile = await picker.pickImage(
                                    source: ImageSource.gallery
                                  );
                                  if (pickedFile == null) return;
                                  botesForm.photosFilesList[i] = File.fromUri( Uri(path: pickedFile.path) );

                                  setState(() {});

                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  );
                }  
              );
            }
          }
        ),
      )
    );
  }
}