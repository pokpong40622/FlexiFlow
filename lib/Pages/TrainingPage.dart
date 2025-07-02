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
  final Map<int, List<Map<String, dynamic>>> schedules = {
    6: [
      {'time': '07:00', 'event': 'Morning Exercise', 'completed': false},
      {'time': '09:00', 'event': 'Office Work', 'completed': true},
      {'time': '12:30', 'event': 'Lunch at Cafe', 'completed': false},
      {'time': '15:00', 'event': 'Grocery Shopping', 'completed': false},
      {'time': '19:00', 'event': 'Watch a Movie', 'completed': true},
    ],
    7: [
      {'time': '07:30', 'event': 'Wake up and brush your teeth', 'completed': true},
      {'time': '07:30', 'event': 'Wake up and brush your teeth', 'completed': true},
      {'time': '08:30', 'event': 'Leave Home for Work', 'completed': false},
      {'time': '09:00', 'event': 'Company Meeting', 'completed': false},
      {'time': '12:00', 'event': 'Lunch break', 'completed': false},
      {'time': '16:00', 'event': 'Leave Office', 'completed': false},
      {'time': '17:30', 'event': 'Physical Activity', 'completed': false},
      {'time': '18:30', 'event': 'Dinner with Family', 'completed': false},
    ],
    8: [
      {'time': '09:00', 'event': 'Brunch with Friends', 'completed': false},
      {'time': '11:00', 'event': 'Go to the Gym', 'completed': true},
      {'time': '14:00', 'event': 'Shopping at Mall', 'completed': false},
      {'time': '17:00', 'event': 'Family Gathering', 'completed': false},
      {'time': '20:00', 'event': 'Relax at Home', 'completed': true},
    ],
    9: [
      {'time': '08:00', 'event': 'Go to Church', 'completed': false},
      {'time': '10:30', 'event': 'Brunch with Family', 'completed': false},
      {'time': '14:00', 'event': 'Relax and Read a Book', 'completed': true},
      {'time': '18:00', 'event': 'Dinner with Friends', 'completed': false},
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

    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Column(
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
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'List',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth * 0.054,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showAddEventDialog(context),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Color(0xFF0397FD),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Add',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: screenHeight * 0.3,
                    child: SingleChildScrollView(
                      child: Column(
                        children: schedules[clickedDay]!
                            .map((schedule) => _buildScheduleItem(
                                  schedule['time']!,
                                  schedule['event']!,
                                  schedule['completed']!,
                                  schedules[clickedDay]!.indexOf(schedule),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Builds clickable calendar day buttons with blue headers
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
                color: isSelected ? Color(0xFF0262A4) : Color(0xFF0397FD),
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

  // Creates individual schedule items with gradient background and checkboxes
  Widget _buildScheduleItem(String time, String event, bool completed, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12), // Increased spacing between items
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18), // More padding for bigger look
      decoration: BoxDecoration(
        // Gradient background - light blue to darker blue
        gradient: LinearGradient(
          colors: completed 
              ? [Color(0xFF0262A4), Color(0xFF0397FD)] // Darker gradient for completed
              : [Color(0xFF0397FD), Color(0xFF1BA3FD)], // Lighter gradient for pending
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16), // More rounded corners
        boxShadow: [
          BoxShadow(
            color: Color(0xFF0397FD).withOpacity(0.3), // Blue shadow
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Time with bigger font and semi-bold weight
          Text(
            time,
            style: GoogleFonts.inter(
              fontSize: 18, // Increased font size
              fontWeight: FontWeight.w700, // Semi-bold
              color: Colors.white,
            ),
          ),
          SizedBox(width: 20), // More spacing
          // Event text expanded to fill remaining space
          Expanded(
            child: Text(
              event,
              style: GoogleFonts.inter(
                fontSize: 15, // Slightly bigger
                fontWeight: FontWeight.w600, // Semi-bold
                color: Colors.white,
              ),
            ),
          ),
          // Completion checkbox with rounded corners
          GestureDetector(
            onTap: () {
              setState(() {
                schedules[clickedDay]![index]['completed'] = !completed;
              });
            },
            child: Container(
              width: 28, // Bigger checkbox
              height: 28,
              decoration: BoxDecoration(
                color: completed ? Colors.white : Colors.transparent,
                border: Border.all(color: Colors.white, width: 2.5), // Thicker border
                borderRadius: BorderRadius.circular(8), // More rounded
              ),
              child: completed
                  ? Icon(
                      Icons.check,
                      color: Color(0xFF0397FD),
                      size: 18, // Bigger check icon
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  // Shows dialog for adding new events to selected day
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
                decoration: InputDecoration(labelText: 'Time (HH:MM)'),
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
                Navigator.of(context).pop(); // Close dialog without saving
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (timeController.text.isNotEmpty && eventController.text.isNotEmpty) {
                  setState(() {
                    // Add new event to selected day's schedule
                    schedules[clickedDay]!.add({
                      'time': timeController.text,
                      'event': eventController.text,
                      'completed': false,
                    });
                  });
                  timeController.clear(); // Clear input fields
                  eventController.clear();
                  Navigator.of(context).pop(); // Close dialog
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}