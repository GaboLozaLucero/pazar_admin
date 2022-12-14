import 'package:admin_project_v1/constants/constant_colors.dart';
import 'package:admin_project_v1/controllers/add_stories_map_controller.dart';
import 'package:admin_project_v1/controllers/edit_story_controller.dart';
import 'package:admin_project_v1/models/stories.dart';
import 'package:admin_project_v1/navigation/pages.dart';
import 'package:admin_project_v1/ui/widgets/custom_appbar.dart';
import 'package:admin_project_v1/ui/widgets/custom_button.dart';
import 'package:admin_project_v1/ui/widgets/form_field_long_text.dart';
import 'package:admin_project_v1/ui/widgets/form_field_text.dart';
import 'package:admin_project_v1/ui/widgets/simple_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class EditStoryPage extends GetView<EditStoryController> {
  EditStoryPage({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _storyController = TextEditingController();
  final TextEditingController _latLngController = TextEditingController();
  final TextEditingController _modelUrl = TextEditingController();
  late AddStoriesMapController storiesMapController = Get.find<AddStoriesMapController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Editando'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: Get.height * 0.8,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FormFieldText(
                        controller: _nameController,
                        hint: controller.story.name,
                        iconData: Icons.drive_file_rename_outline_rounded),
                    //form field name
                    FormFieldText(controller: _addressController, hint: controller.story.address, iconData: Icons.directions),
                    //form field address
                    FormFieldLongText(controller: _storyController, hint: controller.story.story, iconData: Icons.history_edu),
                    //form field story
                    FormFieldText(controller: _modelUrl, hint: controller.story.modelUrl, iconData: Icons.emoji_people),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Obx(
                        () {
                          return DropdownButton(
                              isExpanded: true,
                              iconEnabledColor: ConstantColors.buttonColor,
                              iconSize: 40.0,
                              onChanged: (newValue) {
                                controller.selectedType = newValue.toString();
                                log('this values is ${controller.selectedType}');
                              },
                              value: controller.selectedType,
                              items: controller.storyType.map((story) {
                                return DropdownMenuItem(
                                  value: story,
                                  child: Text(story),
                                );
                              }).toList());
                        },
                      ),
                    ),
                    //dropdown button type of story
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Obx(() {
                        return DropdownButton(
                            isExpanded: true,
                            iconEnabledColor: ConstantColors.buttonColor,
                            iconSize: 40.0,
                            onChanged: (newValue) {
                              controller.selectedActive = newValue.toString();
                              log('this values is ${controller.selectedActive}');
                            },
                            value: controller.selectedActive,
                            items: controller.activeType.map((active) {
                              return DropdownMenuItem(
                                value: active,
                                child: Text(
                                  active,
                                  style: TextStyle(
                                      color: (active == 'Activado') ? ConstantColors.successColor : ConstantColors.errorColor),
                                ),
                              );
                            }).toList());
                      }),
                    ), //dropdown button activeness
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                      child: Obx(() {
                        return (!storiesMapController.isLoading)
                            ? CustomButton(
                                function: () async {
                                  showMap(_latLngController);
                                },
                                text: 'Ubicaci??n en el mapa',
                                iconData: Icons.map,
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomButton(
                                    function: () async {
                                      showMap(_latLngController);
                                    },
                                    text: 'Ubicaci??n en el mapa',
                                    iconData: Icons.map,
                                    width: Get.width * 0.85,
                                  ),
                                  const Icon(
                                    Icons.check_circle,
                                    color: ConstantColors.saveColor,
                                  )
                                ],
                              );
                      }),
                    ), // add location to the history
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.07,
                width: double.infinity,
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(ConstantColors.saveColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    final active = (controller.selectedActive == 'Activado') ? true : false;
                    final type = (controller.selectedType == 'Mito') ? 'myth' : 'legend';
                    if (_nameController.text.isEmpty &&
                        _addressController.text.isEmpty &&
                        _storyController.text.isEmpty &&
                        _modelUrl.text.isEmpty &&
                        active == controller.story.active &&
                        type == controller.story.type &&
                        storiesMapController.newMarker.elementAt(0).position == const LatLng(0.0, 0.0)) {
                      noChanges();
                    } else {
                      await saveData();
                    }
                  },
                  child: const SimpleText(
                    text: 'Guardar historia',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showMap(TextEditingController latLngController) {
    Get.dialog(
      AlertDialog(
        title: const SimpleText(
          text: 'Selecciona el lugar',
          color: ConstantColors.appBarTextColor,
        ),
        content: SizedBox(
          width: Get.width * 0.95,
          height: Get.height * 0.75,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
            child: Obx(
              () {
                if (storiesMapController.isLoading1) {
                  return Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          Text('Cargando mapa'),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      GoogleMap(
                        onMapCreated: (mapController) {
                          storiesMapController.onMapCreated(mapController);
                        },
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(-16.49817713198687, -68.133475729177),
                          zoom: 16.0,
                        ),
                        zoomControlsEnabled: false,
                        minMaxZoomPreference: const MinMaxZoomPreference(14.0, 16.0),
                        myLocationButtonEnabled: false,
                        myLocationEnabled: false,
                        markers: storiesMapController.newMarker,
                        onTap: storiesMapController.setMarker,
                      ),
                      OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(ConstantColors.successColor),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: const SimpleText(text: 'Listo', color: Colors.white),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  positionMissing() {
    Get.dialog(
      AlertDialog(title: const Text('Error'), content: const Text('La ubicaci??n de la historia esta vac??a.'), actions: [
        OutlinedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'))
      ]),
    );
  }

  noChanges() {
    Get.dialog(
      AlertDialog(title: const Text('Error'), content: const Text('No existen cambios en la informaci??n.'), actions: [
        OutlinedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'))
      ]),
    );
  }

  saveData() async {
    Story story = Story(
      id: controller.story.id,
      name: (_nameController.text.isEmpty) ? controller.story.name : _nameController.text,
      geoPoint: (storiesMapController.newMarker.elementAt(0).position == const LatLng(0.0, 0.0))
          ? controller.story.geoPoint
          : GeoPoint(storiesMapController.newMarker.elementAt(0).position.latitude,
              storiesMapController.newMarker.elementAt(0).position.longitude),
      address: (_addressController.text.isEmpty) ? controller.story.address : _addressController.text,
      story: (_storyController.text.isEmpty) ? controller.story.story : _storyController.text,
      imageUrl: controller.story.imageUrl,
      active: (controller.selectedActive == 'Activado') ? true : false,
      type: (controller.selectedType == 'Mito') ? 'myth' : 'legend',
      modelUrl: controller.story.modelUrl,
    );
    if (await controller.updateStory(story)) {
      Get.offAllNamed(Routes.initial);
      Get.dialog(
        AlertDialog(title: const Text('??xito'), content: const Text('La informaci??n ha sido modificada.'), actions: [
          OutlinedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'))
        ]),
      );
    } else {
      Get.dialog(
        AlertDialog(title: const Text('Error'), content: const Text('La informaci??n no ha sido modificada.'), actions: [
          OutlinedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'))
        ]),
      );
    }
  }
}
