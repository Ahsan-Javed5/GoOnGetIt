import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_on_get_it/constants/app_images.dart';
import 'package:go_on_get_it/constants/color_constants.dart';
import 'package:go_on_get_it/screens/location/controller/main_controller.dart';
import 'package:sizer/sizer.dart';
import '/constants/font_constants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ReserveBottomDialog extends StatefulWidget {
  const ReserveBottomDialog({Key? key, required this.shopData})
      : super(key: key);
  final Map<String, dynamic> shopData;

  @override
  State<ReserveBottomDialog> createState() => _ReserveBottomDialogState();
}

class _ReserveBottomDialogState extends State<ReserveBottomDialog> {
  final MainController mainController = Get.find<MainController>();

  final nameController = TextEditingController();

  final quantityController = TextEditingController();

  final dateTimeController = TextEditingController();

  @override
  void initState() {
    mainController.quantity?.value = widget.shopData['quantity']!;
    mainController.totalPrice?.value = widget.shopData['price']!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool _isMobileLayout = shortestSide < 600;
    return _isMobileLayout

        ///for mobile view
        ? SingleChildScrollView(
            child: Container(
              height: 55.h,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: ColorConstants.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3.h),
                  topRight: Radius.circular(3.h),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 1.5.w,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: const Color(0xFFEAEAEA),
                      height: 0.3.h,
                      width: 23.w,
                      margin: EdgeInsets.only(top: 1.h, bottom: 2.h),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.shopData['name']!,
                              style: TextStyle(
                                fontFamily: FontConstants.sourceSansProSemiBold,
                                color: ColorConstants.blackShade,
                                fontSize: 13.5.sp,
                              ),
                            ),
                            Obx(() => Text(
                                  'Remaining-${mainController.quantity?.value}'
                                      .tr,
                                  style: TextStyle(
                                    fontFamily:
                                        FontConstants.sourceSansProRegular,
                                    color: ColorConstants.parrotGreen,
                                    fontSize: 10.sp,
                                  ),
                                )),
                          ],
                        ),
                        Text(
                          '\$${widget.shopData['price']!}',
                          style: TextStyle(
                            fontFamily: FontConstants.sourceSansProSemiBold,
                            color: ColorConstants.parrotGreen,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 2.5.h,
                        bottom: 1.h,
                      ),
                      height: 7.h,
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            top: 0.5.h,
                            left: 3.w,
                          ),
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(1.w),
                            ),
                            borderSide: BorderSide(
                              width: 0.5.h,
                            ),
                          ),
                          hintText: 'Name'.tr,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 2.5.h,
                        bottom: 1.h,
                      ),
                      height: 7.h,
                      child: TextFormField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,

                        /// Only numbers can be entered
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (text) {
                          updatePriceAndQuantity(text);
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            top: 0.5.h,
                            left: 3.w,
                          ),
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(1.w),
                            ),
                            borderSide: BorderSide(
                              width: 0.5.h,
                            ),
                          ),
                          hintText: 'Quantity'.tr,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 2.5.h,
                      ),
                      height: 7.h,
                      child: TextFormField(
                        controller: dateTimeController,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              DatePicker.showDateTimePicker(
                                context,
                                showTitleActions: true,
                                onChanged: (date) {},
                                minTime: DateTime.now(),
                                onConfirm: (date) {
                                  dateTimeController.text =
                                      date.toString().substring(0, 19);
                                },
                                currentTime: DateTime.now(),
                              );
                            },
                            child: SvgPicture.asset(
                              AppImages.calendar,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          contentPadding: EdgeInsets.only(
                            top: 0.5.h,
                            left: 3.w,
                          ),
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(1.w),
                            ),
                            borderSide: BorderSide(
                              width: 0.5.h,
                            ),
                          ),
                          hintText: 'Date & Time'.tr,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Row(
                          children: [
                            Text(
                              'Total Price: ',
                              style: TextStyle(
                                fontFamily: FontConstants.sourceSansProBold,
                                color: ColorConstants.parrotGreen,
                                fontSize: 11.sp,
                              ),
                            ),
                            Obx(() => Text(
                                  '\$${mainController.totalPrice?.value}',
                                  style: const TextStyle(
                                    fontFamily:
                                        FontConstants.sourceSansProRegular,
                                    color: ColorConstants.parrotDark,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (nameController.text.trim().isEmpty) {
                              Get.snackbar(
                                'Wrong Name',
                                'Please Enter Name',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: ColorConstants.parrotGreen,
                              );
                            } else if (int.parse(
                                    quantityController.text.trim().toString()) >
                                int.parse(widget.shopData['quantity'])) {
                              Get.snackbar(
                                'Wrong Quantity',
                                'You cannot enter more than quantity available',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: ColorConstants.parrotGreen,
                              );
                            } else if (dateTimeController.text.trim().isEmpty) {
                              Get.snackbar(
                                'Wrong Date',
                                'Please Enter Date and Time',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: ColorConstants.parrotGreen,
                              );
                            } else {
                              mainController.postReserve(
                                widget.shopData['id'],
                                nameController.text,
                                quantityController.text,
                                dateTimeController.text,
                              );
                              dateTimeController.clear();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 1.7.h,
                              horizontal: 19.w,
                            ),
                          ),
                          child: Text(
                            'Ok'.tr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: FontConstants.sourceSansProRegular,
                            ),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 1.7.h,
                              horizontal: 15.5.w,
                            ),
                          ),
                          child: Text('cancel'.tr),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )

        ///for tablet view
        : Center(
            child: Text(
            'Not Implemented Yet for Tablet.',
            style: TextStyle(
              fontSize: 20.sp,
              color: ColorConstants.parrotGreen,
            ),
          ));
  }

  updatePriceAndQuantity(String text) {
    log(mainController.quantity!.value);
    mainController.quantity?.value = widget.shopData['quantity'];
    mainController.totalPrice?.value = widget.shopData['price'];
    mainController.quantity?.value =
        (int.parse((mainController.quantity?.value).toString()) -
                int.parse(text))
            .toString();
    mainController.totalPrice?.value =
        (int.parse((mainController.totalPrice?.value).toString()) *
                int.parse(text))
            .toString();
  }
}
