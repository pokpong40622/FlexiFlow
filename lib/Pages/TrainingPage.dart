import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  @override
  int activeIndex = 0;

  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final List<Widget> slideItems = [
      Image.asset('assets/PerfectMatchLogo.png'),
      Image.asset('assets/WanderLogo.png'),
      Container(color: Colors.white),
      Container(color: Colors.white),
    ];

    int clickedDay = 7; // Default to Friday (7)

    final Map<int, List<Map<String, String>>> schedules = {
    6: [
      {'time': '07:00', 'event': 'Morning Exercise'},
      {'time': '09:00', 'event': 'Office Work'},
      {'time': '12:30', 'event': 'Lunch at Cafe'},
      {'time': '15:00', 'event': 'Grocery Shopping'},
      {'time': '19:00', 'event': 'Watch a Movie'},
    ],
    7: [
      {'time': '07:00', 'event': 'Wake-Up & Morning Routine'},
      {'time': '08:30', 'event': 'Leave Home for Work'},
      {'time': '09:00', 'event': 'Company Meeting'},
      {'time': '12:00', 'event': 'Lunch break'},
      {'time': '16:00', 'event': 'Leave Office'},
      {'time': '17:30', 'event': 'Physical Activity'},
      {'time': '18:30', 'event': 'Dinner with Family'},
    ],
    8: [
      {'time': '09:00', 'event': 'Brunch with Friends'},
      {'time': '11:00', 'event': 'Go to the Gym'},
      {'time': '14:00', 'event': 'Shopping at Mall'},
      {'time': '17:00', 'event': 'Family Gathering'},
      {'time': '20:00', 'event': 'Relax at Home'},
    ],
    9: [
      {'time': '08:00', 'event': 'Go to Church'},
      {'time': '10:30', 'event': 'Brunch with Family'},
      {'time': '14:00', 'event': 'Relax and Read a Book'},
      {'time': '18:00', 'event': 'Dinner with Friends'},
    ],
  };

    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.025),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0425),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/FlexiFlowLogoColor.png',
                  width: screenWidth * 0.13333,
                ),
                SizedBox(width: screenWidth * 0.2),
                Text(
                  'Training',
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.062,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(width: screenWidth * 0.29),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.026),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0425),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: screenHeight * 0.007),
                    Text(
                      'Games',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: screenWidth * 0.054,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.014),
                CarouselSlider(
                  options: CarouselOptions(
                    height:
                        screenHeight *
                        0.26, 
                    viewportFraction: 0.47062963,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) => setState(() {
                      activeIndex = index;
                    }),
                  ),
                  items: slideItems.map((widget) {
                    return Padding(
                      padding:EdgeInsets.symmetric(horizontal: 6),
                      child: Container(
                        margin:  EdgeInsets.only(
                          bottom: 8,
                        ), // extra bottom space
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            10,
                          ), 
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: widget is Image
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: widget,
                                )
                              : widget,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: screenHeight * 0.012),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: screenHeight * 0.007),
                    Text(
                      'Days',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: screenWidth * 0.054,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
