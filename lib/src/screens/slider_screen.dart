import 'package:flutter/material.dart';

import '../../widgets/slidershow.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SliderScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(children: [
      const GradientBackground(),
      ValuePorpose(),
      HeaderCurvo(),
      Slideshow(
        //colorPrimario: const Color(0xffAE6389),
        //colorSecundario: const Color.fromARGB(189, 144, 44, 44),
        bulletPrimario: 15,
        bulletSecundario: 12,
        puntosArriba: false,
        slides: [
          SvgPicture.asset('assets/svgs/slide-1.svg'),
          SvgPicture.asset('assets/svgs/slide-2.svg'),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(top: height * 0.88),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              minWidth: 150.0,
              height: 40.0,
              onPressed: () {},
              color: Color(0xFF50A6FD),
              child: Text('ENTER', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    ]));
  }
}
