import 'package:e_auction/src/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../image_picker_button.dart';
import '../../../../core/utils/e_auction_decoration.dart';
import '../controller/create_auction_post_controller.dart';

class CreateAuctionScreen extends StatelessWidget {
  CreateAuctionScreen({super.key});

  final CreateAuctionPostController _createAuctionPostController =
      Get.put(CreateAuctionPostController());
  final _formKey = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.delete<CreateAuctionPostController>();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Obx(
            () => _createAuctionPostController.loading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // 10.ph,
                            TextFormField(
                              decoration:
                                  EAuctionDecorations.eAuctionInputDecoration(
                                      hint: 'Product title', label: 'Title'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a product title';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _createAuctionPostController.title.value =
                                    value!;
                              },
                            ),
                            16.ph,
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: EAuctionDecorations.eAuctionInputDecoration(hint: 'Minimum Bid Price', label: 'Minimum Bid Price',),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a minimum bid price';
                                      }
                                      final double? price = double.tryParse(value);
                                      if (price == null || price <= 0) {
                                        return 'Please enter a valid minimum bid price';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _createAuctionPostController.bidPrice
                                          .value = double.parse(value!);
                                    },
                                  ),
                                ),
                                16.pw,
                                Expanded(
                                  child: TextFormField(
                                    decoration: EAuctionDecorations
                                        .eAuctionInputDecoration(
                                            hint: 'Deadline',
                                            label: 'Auction End Date and Time'),
                                    controller: dateController,
                                    onTap: () async {
                                      final DateTime? picked =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now()
                                            .add(const Duration(days: 365)),
                                      );
                                      if (picked != null) {
                                        final TimeOfDay? time =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );
                                        if (time != null) {
                                          _createAuctionPostController
                                              .auctionEndDateTime = DateTime(
                                            picked.year,
                                            picked.month,
                                            picked.day,
                                            time.hour,
                                            time.minute,
                                          );
                                        }
                                      }
                                    },
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return 'Please enter a deadline';
                                    //   }
                                    //   return null;
                                    // },
                                    onSaved: (value) {
                                      _createAuctionPostController.deadline.value = DateFormat.yMd().add_jm().format(_createAuctionPostController.auctionEndDateTime);
                                      dateController.text = _createAuctionPostController.deadline.value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            16.ph,
                            TextFormField(
                              maxLines: 5,
                              decoration:
                                  EAuctionDecorations.eAuctionInputDecoration(
                                      hint: 'Product description',
                                      label: 'Description'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a product name';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _createAuctionPostController.description.value =
                                    value!;
                              },
                            ),

                            16.ph,
                            const ImagePickerButton(),
                            16.ph,
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _createAuctionPostController.submitData();
                                }
                              },
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
