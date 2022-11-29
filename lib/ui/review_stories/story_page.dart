import 'package:admin_project_v1/constants/constant_colors.dart';
import 'package:admin_project_v1/controllers/add_stories_controller.dart';
import 'package:admin_project_v1/controllers/add_stories_map_controller.dart';
import 'package:admin_project_v1/models/stories.dart';
import 'package:admin_project_v1/ui/widgets/custom_appbar.dart';
import 'package:admin_project_v1/ui/widgets/custom_button.dart';
import 'package:admin_project_v1/ui/widgets/form_field_long_text.dart';
import 'package:admin_project_v1/ui/widgets/form_field_text.dart';
import 'package:admin_project_v1/ui/widgets/simple_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class StoryPage extends GetView<AddStoriesController> {
  StoryPage({Key? key}) : super(key: key);

  final Story _story = Get.arguments;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _latLngController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _storyController = TextEditingController();
  late AddStoriesMapController storiesMapController = Get.find<AddStoriesMapController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Agregar historia',
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
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
                            controller: _nameController, hint: 'Nombre', iconData: Icons.drive_file_rename_outline_rounded),
                        //form field name
                        FormFieldText(controller: _addressController, hint: 'Dirección', iconData: Icons.directions),
                        //form field address
                        FormFieldLongText(controller: _storyController, hint: 'Cuente la historia', iconData: Icons.history_edu),
                        //form field story
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
                                          color:
                                          (active == 'Activado') ? ConstantColors.successColor : ConstantColors.errorColor),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1.0),
                          child: Obx(() {
                            return (controller.isLoading)
                                ? const CircularProgressIndicator()
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: Get.width * 0.5,
                                  height: Get.height * 0.13,
                                  child: Image.network(
                                    controller.portraitPath,
                                    loadingBuilder:
                                        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomButton(
                                      function: () async {
                                        await controller.takeImage(1);
                                      },
                                      text: '',
                                      iconData: Icons.camera_alt,
                                      width: Get.width * 0.35,
                                      height: Get.height * 0.06,
                                    ),
                                    CustomButton(
                                      function: () async {
                                        await controller.takeImage(2);
                                      },
                                      text: '',
                                      iconData: Icons.photo_sharp,
                                      width: Get.width * 0.35,
                                      height: Get.height * 0.06,
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                        ),
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
