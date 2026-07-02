import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImagePromoCarousel extends StatefulWidget {
  const ImagePromoCarousel({Key? key}) : super(key: key);

  @override
  State<ImagePromoCarousel> createState() => _ImagePromoCarouselState();
}

class _ImagePromoCarouselState extends State<ImagePromoCarousel> {
  int _currentIndex = 0;

  final List<String> imageList = [
    'assets/images/Banner1.png',
    'assets/images/Banner2.png',
    'assets/images/Banner3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 180.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              viewportFraction: 0.85,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: imageList.map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(imagePath, fit: BoxFit.cover),
                    ),
                  );
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageList.asMap().entries.map((entry) {
              bool isSelected = _currentIndex == entry.key;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isSelected ? 24.0 : 8.0,
                height: 6.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isSelected
                      ? const Color(0xFF7A6BFA)
                      : const Color(0xFFE0E0E0),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
