import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    int activeIndex = 0; //Image slider
    final List<String> slideImages = [
      //Image slider
      'assets/ImagesliderFlexicoin.png',
      'assets/ImagesliderGrandma.png',
      'assets/ImagesliderGrandpa.png',
    ];

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.018),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0425),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/FlexiFlowProfilePic.png',
                  width: screenWidth * 0.1453,
                ),
                Text(
                  'Home',
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.062,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Image.asset(
                  'assets/FlexiFlowLogoColor.png',
                  width: screenWidth * 0.13333,
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.026),
          CarouselSlider(
            options: CarouselOptions(
              height: screenHeight * 0.21836,
              autoPlay: true,
              viewportFraction: screenWidth * 0.808 / screenWidth,
              onPageChanged: (index, reason) => setState(() {
                activeIndex = index;
              }),
            ),
            items: slideImages.map((slideImage) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10), //control the space between each image in the slide
                child: Container(                   
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      slideImage,
                      fit: BoxFit.cover, //make the image fit but not stretched i think (not sure)
                      width: double.infinity,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: screenHeight * 0.012),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0425),
            child: Row(
              children: [
                Text(
                  'Services',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: screenWidth * 0.0555,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
