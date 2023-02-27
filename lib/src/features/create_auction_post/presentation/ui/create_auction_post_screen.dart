import 'package:e_auction/src/core/extensions/extensions.dart';
import 'package:e_auction/src/features/create_auction_post/presentation/ui/widgets/auction_post_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../image_picker_button.dart';
import '../../../../core/utils/e_auction_decoration.dart';
import '../controller/create_auction_post_controller.dart';

class CreateAuctionScreen extends StatefulWidget {
  const CreateAuctionScreen({super.key});

  @override
  State<CreateAuctionScreen> createState() => _CreateAuctionScreenState();
}

class _CreateAuctionScreenState extends State<CreateAuctionScreen> {
  late CreateAuctionPostController _createAuctionPostController;
  late TextEditingController dateController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    dateController = TextEditingController();
    _createAuctionPostController = Get.put(CreateAuctionPostController());
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
    Get.delete<CreateAuctionPostController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Obx(() =>
                _createAuctionPostController.loading.value
                    ? const CreateAuctionLoadingDialog() : const SizedBox()),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Flexible(
                            flex: 4,
                            child: ImagePickerButton(),
                          ),
                          16.pw,
                          Flexible(
                            flex: 6,
                            child: SizedBox(
                              height: 150,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: TextFormField(
                                        decoration: EAuctionDecorations
                                            .eAuctionInputDecoration(
                                          hint: 'Minimum Bid Price',
                                          label: 'Bid Price',
                                        ),

                                        ///
                                        /// Copy paste of non digit text blocked by this formatter.
                                        ///
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a minimum bid price';
                                          }
                                          final double? price =
                                          double.tryParse(value);
                                          if (price == null || price <= 0) {
                                            return 'Please enter a valid minimum bid price';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          _createAuctionPostController.bidPrice
                                              .value = double.parse(value);
                                        },
                                      ),
                                    ),
                                    10.ph,
                                    Flexible(
                                      child: TextFormField(
                                        decoration: EAuctionDecorations
                                            .eAuctionInputDecoration(
                                            hint: 'Auction deadline',
                                            label: 'Deadline'),
                                        onTap: () {
                                          _createAuctionPostController
                                              .isDatePicked.value = true;
                                          _createAuctionPostController
                                              .selectDate(context);
                                          dateController.text = DateFormat.yMd()
                                              .add_jm()
                                              .format(
                                              _createAuctionPostController
                                                  .auctionEndDateTime.value);
                                        },
                                        readOnly: true,
                                        controller: dateController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a deadline';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      16.ph,
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
                        onChanged: (value) {
                          _createAuctionPostController.title.value = value;
                        },
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
                        onChanged: (value) {
                          _createAuctionPostController.description.value = value;
                        },
                      ),
                      16.ph,
                      ElevatedButton(
                        style: TextButton.styleFrom(),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _createAuctionPostController.postNewAuction();
                          }
                        },
                        child: const SizedBox(height: 50,
                            width: double.infinity,
                            child: Center(child: Text('Submit'))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
