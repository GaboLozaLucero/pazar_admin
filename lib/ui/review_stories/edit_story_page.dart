import 'package:admin_project_v1/constants/constant_colors.dart';
import 'package:admin_project_v1/controllers/add_stories_map_controller.dart';
import 'package:admin_project_v1/controllers/edit_story_controller.dart';
import 'package:admin_project_v1/ui/widgets/custom_appbar.dart';
import 'package:admin_project_v1/ui/widgets/custom_button.dart';
import 'package:admin_project_v1/ui/widgets/form_field_long_text.dart';
import 'package:admin_project_v1/ui/widgets/form_field_text.dart';
import 'package:admin_project_v1/ui/widgets/simple_text.dart';
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
                height: Get.height * 0.77,
                width: double.infinity,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  physics: const BouncingScrollPhysics(),
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
                      FormFieldText(
                          controller: _modelUrl,
                          hint: controller.story.modelUrl,
                          iconData: Icons.emoji_people),
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
                                  text: 'Ubicación en el mapa',
                                  iconData: Icons.map,
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomButton(
                                      function: () async {
                                        showMap(_latLngController);
                                      },
                                      text: 'Ubicación en el mapa',
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
                  onPressed: () {
                    // if (storiesMapController.newMarker.elementAt(0).position == const LatLng(0.0, 0.0)) {
                    //   positionMissing();
                    // }
                    // if (controller.portraitPath == './././assets/images/default_image.png') {
                    //   portraitMissing();
                    // }
                    // if (_formKey.currentState?.validate() == false) {
                    //   return;
                    // } else {
                    //   _formKey.currentState?.save();
                    //   saveData();
                    // }
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
}
