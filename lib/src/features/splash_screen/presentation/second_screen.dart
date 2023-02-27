import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/assetsPath.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: Hero(
          tag: 'imageHero',
          child:  SvgPicture.asset(AssetsPath.authScreenSvg,width: 100,),
        ),
      ),
    );
  }
}
