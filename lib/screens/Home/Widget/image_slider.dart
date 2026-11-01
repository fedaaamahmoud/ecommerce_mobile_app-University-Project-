import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final ValueChanged<int>? onSlideChanged;

  const ImageSlider({super.key, this.onSlideChanged});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int currentSlide = 0;

  void onPageChanged(int index) {
    setState(() {
      currentSlide = index;
      if (widget.onSlideChanged != null) {
        widget.onSlideChanged!(currentSlide); // استدعاء الكول باك
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final images = [
      "images/slider.jpg",
      "images/image1.png",
      "images/slider3.png"
    ];

    return Stack(
      children: [
        SizedBox(
          height: 220,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: PageView(
              scrollDirection: Axis.horizontal,
              onPageChanged: onPageChanged,
              physics: const ClampingScrollPhysics(),
              children: images
                  .map((imagePath) => Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: currentSlide == index ? 15 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: currentSlide == index
                      ? Colors.black
                      : Colors.transparent,
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

