import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';
import '../widgets/appbar.dart';
import '../icons/eva_icons_icons.dart';
import '../providers/ticket_suivi_controller.dart';
import '../models/ticket_response.dart';
import '../utils/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Photos extends StatefulWidget {
  static const routeName = '/photos';
  @override
  _PhotosState createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final pageIndexNotifier = ValueNotifier<int>(0);
  bool allowBack = false;

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final title = arguments['title'];
    final ticketId = arguments['id'];
    final taskId = arguments['task_id'];
    final back = arguments['back'];

    final imagesData = Provider.of<TicketSuivi>(context);
    List<Picture> imageList = [];

    if (taskId != null) {
      imageList = imagesData.taskImages(taskId);
    } else {
      imageList = imagesData.allImages;
    }

    final length = imageList.length;

    Future<void> takePicture(int ticketId, {int taskId = 0}) async {
      try {
        final pickedFile = await ImagePicker.pickImage(
          source: ImageSource.camera,
          maxWidth: 600,
        );
        if (pickedFile == null) {
          return;
        }

        final appDir = await syspaths.getApplicationDocumentsDirectory();
        File rotatedImage =
            await FlutterExifRotation.rotateImage(path: pickedFile.path);
        //final fileName = path.basename(rotatedImage.path);
        //File image = pickedFile;
        final fileName = path.basename(rotatedImage.path);
        final ext = fileName.split('.');
        print(fileName);
        print(ext);
        final savedImage = await rotatedImage.copy('${appDir.path}/$fileName');
        if (taskId == 0) {
          setState(() {
            allowBack = true;
          });
          final Picture ticketImage = Picture(
            name: '${ticketId}_${imageList.length + 1}.${ext[1]}',
            datePrise: DateTime.now(),
            image: savedImage,
            statut: 0,
          );
          print(ticketImage.name);
          imagesData.addImage(ticketImage);
        } else {
          final Picture ticketImage = Picture(
            name: '${ticketId}_${taskId}_${imageList.length + 1}.${ext[1]}',
            datePrise: DateTime.now(),
            image: savedImage,
            statut: 0,
          );
          imagesData.addTaskImage(ticketImage, taskId);
        }
      } catch (e) {
        print(e);
      }
    }

    Widget buildPicture(String text) {
      return imageList.isNotEmpty
          ? Container(
              padding: EdgeInsets.fromLTRB(35, 15, 35, 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (index) => pageIndexNotifier.value = index,
                      itemCount: length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Color.fromRGBO(242, 242, 242, 1),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${index + 1}/$length",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Container(
                                      height: 23.0,
                                      width: 28.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color.fromRGBO(251, 91, 79, 1),
                                      ),
                                      child: IconButton(
                                        padding: EdgeInsets.all(0),
                                        icon: Icon(
                                          EvaIcons.trash_2_outline,
                                          color: Colors.white,
                                          size: 14.0,
                                        ),
                                        onPressed: () {
                                          if (taskId != null) {
                                            imagesData.removeTaskImage(
                                                imageList[index].name, taskId);
                                          } else {
                                            imagesData.removeImage(
                                                imageList[index].name);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: Image.file(
                                      imageList[index].image,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Text(
                '$text',
                style: TextStyle(
                  color: Color.fromRGBO(204, 204, 204, 1),
                  fontSize: 20,
                ),
              ),
            );
    }

    return back
        ? Scaffold(
            appBar: buildAppbar('$title', context, true),
            body: buildPicture(AppLocalizations.of(context).photos),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                dialog(context, _keyLoader);
                if (taskId != null) {
                  if (length < 2) {

                    await takePicture(ticketId, taskId: taskId);

                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                    SweetAlert.show(
                      context,
                      title: AppLocalizations.of(context).desole,
                      subtitle: AppLocalizations.of(context).photosAtteint,
                      style: SweetAlertStyle.error,
                    );
                  }
                } else {
                  if (length < 3) {
                    await takePicture(ticketId);
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                    SweetAlert.show(
                      context,
                      title: AppLocalizations.of(context).desole,
                      subtitle: AppLocalizations.of(context).photosAtteint,
                      style: SweetAlertStyle.error,
                    );
                  }
                }
              },
              child: Icon(
                EvaIcons.camera_outline,
                color: Colors.white,
              ),
            ),
          )
        : WillPopScope(
            child: Scaffold(
              appBar: buildAppbar('$title', context, allowBack),
              body: buildPicture(AppLocalizations.of(context).prendrePhoto),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (length >= 3) {
                    SweetAlert.show(context,
                        title: AppLocalizations.of(context).desole,
                        subtitle: AppLocalizations.of(context).photosAtteint,
                        style: SweetAlertStyle.error);
                  } else {
                    takePicture(ticketId);
                  }
                },
                child: Icon(
                  EvaIcons.camera_outline,
                  color: Colors.white,
                ),
              ),
            ),
            onWillPop: () async => allowBack,
          );
  }
}
