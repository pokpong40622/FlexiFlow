import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If the new value is empty, return as is
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Check if the text length is 2 or more
    String text = newValue.text;
    if (text.length == 2 && !text.contains(':')) {
      // Insert a colon after the second digit
      text = '$text:';
      return newValue.copyWith(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }

    return newValue;
  }
}

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int clickedDay = 7;
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

  final TextEditingController timeController = TextEditingController();
  final TextEditingController eventController = TextEditingController();

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
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0445),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Games',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: screenWidth * 0.054,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.014),
          CarouselSlider(
            options: CarouselOptions(
              height: screenHeight * 0.26,
              viewportFraction: 0.45462963,
              enableInfiniteScroll: true,
              autoPlay: true,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) => setState(() {
                activeIndex = index;
              }),
            ),
            items: slideItems.map((widget) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Container(
                  margin: EdgeInsets.only(bottom: 8), // extra bottom space
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0445),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Days',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: screenWidth * 0.054,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCalendarDay('6', 'Thu', 6),
                        _buildCalendarDay('7', 'Fri', 7, isActive: true),
                        _buildCalendarDay('8', 'Sat', 8),
                        _buildCalendarDay('9', 'Sun', 9),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'List',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: screenWidth * 0.054,
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      
                    ],
                  ),
                )
                // Time Schedule Section
                // Container(
                //   width: MediaQuery.of(context).size.width * 0.905555556,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15),
                //     color: Color(0xFFF4F4F4),
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Container(
                //         width: double.infinity,
                //         decoration: BoxDecoration(
                //           color: Color(0xFF307B7B),
                //           borderRadius: BorderRadius.only(
                //             topLeft: Radius.circular(15),
                //             topRight: Radius.circular(15),
                //           ),
                //         ),
                //         padding: EdgeInsets.symmetric(
                //           horizontal: 16,
                //           vertical: 12,
                //         ),
                //         child: Row(
                //           children: [
                //             Icon(
                //               Icons.schedule,
                //               color: Colors.white,
                //               size: 24,
                //             ),
                //             SizedBox(width: 8),
                //             Text(
                //               'Time Schedule',
                //               style: GoogleFonts.inter(
                //                 color: Colors.white,
                //                 fontSize: 17,
                //                 fontWeight: FontWeight.w700,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       SizedBox(height: 16),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(
                //           horizontal: 16.0,
                //         ),
                //         child: Column(
                //           children: schedules[clickedDay]!
                //               .map(
                //                 (event) => _buildScheduleItem(
                //                   event['time']!,
                //                   event['event']!,
                //                 ),
                //               )
                //               .toList(),
                //         ),
                //       ),
                //       SizedBox(height: 16),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  
  //ปุ่มเลือกวัน
  Widget _buildCalendarDay(
    String day,
    String weekday,
    int dayIndex, {
    bool isActive = false,
  }) {
    bool isSelected = clickedDay == dayIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          clickedDay = dayIndex; // Change selected day and update schedule
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.206,
        padding: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: isSelected
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 18,
              decoration: BoxDecoration(
                color: isActive ? Color(0xFF0262A4) : Color(0xFF0397FD),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
              ),
            ),
            SizedBox(height: 12),
            Text(
              day,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Text(
              weekday,
              style: GoogleFonts.inter(
                fontSize: 9,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
  //ปุ่มเลือกวัน


  //น่าจะเอาไว้ใช้กับทที่แสดง schedule listของvia
  // Widget _buildScheduleItem(String time, String event) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: Row(
  //       children: [
  //         Text(
  //           time,
  //           style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700),
  //         ),
  //         Spacer(),
  //         Text(
  //           event,
  //           style: GoogleFonts.inter(
  //             fontSize: 16,
  //             fontWeight: FontWeight.w500,
  //             color: Color(0xFF888888),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _showAddEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Add Event for ${clickedDay == 6
                ? 'Thu'
                : clickedDay == 7
                ? 'Fri'
                : clickedDay == 8
                ? 'Sat'
                : 'Sun'}',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: timeController,
                decoration: InputDecoration(labelText: 'Time'),
                keyboardType:
                    TextInputType.number, // Ensure only numbers are allowed
                inputFormatters: [
                  TimeInputFormatter(),
                ], // Apply the custom formatter
              ),

              TextField(
                controller: eventController,
                decoration: InputDecoration(labelText: 'Event'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  schedules[clickedDay]!.add({
                    'time': timeController.text,
                    'event': eventController.text,
                  });
                });
                timeController.clear();
                eventController.clear();
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
