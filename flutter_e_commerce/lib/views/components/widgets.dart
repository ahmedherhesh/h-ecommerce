import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/design_settings/values.dart';

class MySlider extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}
class SliderIndicators extends StatelessWidget {
  int? sliderImagesCount;
  int? currentSlide;
  SliderIndicators({
    required this.sliderImagesCount,
    required this.currentSlide,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          sliderImagesCount!,
          (index) => AnimatedContainer(
            duration: Duration(milliseconds: 400),
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: currentSlide == index ? primaryColor : textColor,
            ),
            width: currentSlide == index ? 14 : 6,
            height: 4.5,
          ),
        ),
      ),
    );
  }
}
