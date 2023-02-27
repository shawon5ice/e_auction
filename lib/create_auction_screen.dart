import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'image_picker_button.dart';

class CreateAuctionScreen extends StatefulWidget {
  @override
  _CreateAuctionScreenState createState() => _CreateAuctionScreenState();
}

class _CreateAuctionScreenState extends State<CreateAuctionScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _productName;
  late String _productDescription;
  late double _minimumBidPrice;
  late DateTime _auctionEndDateTime;
  File? _imageFile;

  final _minimumBidPriceController = TextEditingController();
  final _auctionEndDateTimeController = TextEditingController();

  @override
  void dispose() {
    _minimumBidPriceController.dispose();
    _auctionEndDateTimeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try{
      final pickedFile = await ImagePicker().pickImage(source: source);
      if(pickedFile == null) return;

      File? img = File(pickedFile.path);
      setState(() {
        _imageFile = img;
      });
      Navigator.pop(context);
    }on PlatformException catch(e){
        Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Product Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _productName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Product Description',
                ),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _productDescription = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Minimum Bid Price',
                ),
                keyboardType: TextInputType.number,
                controller: _minimumBidPriceController,
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
                  _minimumBidPrice = double.parse(value!);
                },
              ),
              InkWell(
                  onTap: () async {
                    late ImageSource imgSrc;
                    await showDialog(context: context, builder: (context){
                      return Card(
                        child: Column(
                          children: [
                            ElevatedButton(onPressed: (){
                              imgSrc = ImageSource.camera;
                            }, child: Text('Camera')),
                            ElevatedButton(onPressed: (){
                              imgSrc = ImageSource.gallery;
                            }, child: Text('Gallery')),
                          ],
                        ),
                      );
                    });
                    await _pickImage(imgSrc);
                  },
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: _imageFile != null? Image.asset(_imageFile!.path): const Center(
                            child: Text('Tap to pick an image'),
                          ),
                  )),
              ImagePickerButton(),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Auction End Date and Time',
                ),
                controller: _auctionEndDateTimeController,
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (picked != null) {
                    final TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        _auctionEndDateTime = DateTime(
                          picked.year,
                          picked.month,
                          picked.day,
                          time.hour,
                          time.minute,
                        );
                        _auctionEndDateTimeController.text = DateFormat.yMd()
                            .add_jm()
                            .format(_auctionEndDateTime);
                      });
                    }
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an auction end date and time';
                  }
                  return null;
                },
                onSaved: (value) {
                  // _auctionEndDateTime = DateFormat.yMd().add_jm().parse
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
