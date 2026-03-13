import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:motion_kit/games/PerfectMatchPlaying.dart'; // Import for date formatting
import 'package:motion_kit/fake_var.dart';

import '../games/MathgamePlaying.dart';

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
  // Use a map with DateTime as keys to store schedules for specific dates
  // This allows for more robust handling of schedules across different days.
  // final Map<DateTime, List<Map<String, dynamic>>> schedules = {};

  late DateTime today; // Will store today's date
  late DateTime
      selectedDate; // Will store the currently selected date in the calendar

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    // Normalize today to just year, month, day for consistent keying in map
    today = DateTime(today.year, today.month, today.day);
    selectedDate = today;

    // Initialize some dummy data for demonstration, using actual dates as keys
    // _initializeDummySchedules();
  }

  /*
  void _initializeDummySchedules() {
    // Example: Schedule for today
    schedules[today] = [
      {
        'time': '07:30',
        'event': 'Wake up and brush your teeth',
        'completed': true
      },
      {'time': '08:30', 'event': 'Leave Home for Work', 'completed': false},
      {'time': '09:00', 'event': 'Company Meeting', 'completed': false},
      {'time': '12:00', 'event': 'Lunch break', 'completed': false},
    ];

    // Example: Schedule for tomorrow
    DateTime tomorrow = today.add(Duration(days: 1));
    schedules[tomorrow] = [
      {'time': '09:00', 'event': 'Brunch with Friends', 'completed': false},
      {'time': '11:00', 'event': 'Go to the Gym', 'completed': true},
      {'time': '14:00', 'event': 'Shopping at Mall', 'completed': false},
    ];

    // Example: Schedule for the day after tomorrow
    DateTime dayAfterTomorrow = today.add(Duration(days: 2));
    schedules[dayAfterTomorrow] = [
      {'time': '08:00', 'event': 'Go to Church', 'completed': false},
      {'time': '10:30', 'event': 'Brunch with Family', 'completed': false},
    ];
    // Note: You can add more days as needed or fetch from a database.
  }
  */

  @override
  void dispose() {
    timeController.dispose();
    eventController.dispose();
    super.dispose();
  }

  final TextEditingController timeController = TextEditingController();
  final TextEditingController eventController = TextEditingController();

  int activeIndex =
      0; // Keeping this for carousel, not directly for calendar days

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final List<Widget> slideItems = [
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                const PerfectMatchPlaying(), // Replace with actual game page
              ));
        },
        child: Image.asset('assets/PerfectMatchLogo.png'),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                const MathgamePlaying(), // Replace with actual game page
              ));
        },
        child: Image.asset('assets/SumItUpLogo.png'),
      ),
      Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
              onTap: () {
                if (!Globals.unlockedSumItUp) return;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const MathgamePlaying(), // Replace with actual game page
                    ));
              },
              child: Image.asset('assets/WanderLogo.png'),
          ),
          if (!Globals.unlockedSumItUp)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'LOCKED',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2.0,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Unlock in Shop',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      /*
      Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.4),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: Text(
                      'COMING\nSOON',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
       */
    ];

    // Get the dates for the current view (today + next 3 days)
    List<DateTime> displayDates = List.generate(
        4,
        (index) => DateTime(today.year, today.month, today.day)
            .add(Duration(days: index)));

    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.015,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: screenWidth * 0.12), // Placeholder for spacing, can be used for future icons
                  // Title with improved styling
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Training',
                        style: GoogleFonts.inter(
                          fontSize: screenWidth * 0.065,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2C2C2C),
                          letterSpacing: 0.5,
                        ),
                      ),
                      Container(
                        height: 2,
                        width: screenWidth * 0.1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                  // Logo with improved styling
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/FlexiFlowLogoColor.png',
                      width: screenWidth * 0.1,
                      height: screenWidth * 0.1,
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: widget,
                      ),
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
                      SizedBox(height: screenHeight * 0.014),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: displayDates.map((date) {
                          return _buildCalendarDay(date);
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.028),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'To Do List',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth * 0.054,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showAddEventDialog(context),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                  SizedBox(height: screenHeight * 0.014),
                  Container(
                    height: screenHeight * 0.35, // Adjust this height as needed
                    child: SingleChildScrollView(
                      child: Column(
                        children: (Globals.schedules[selectedDate] ?? [])
                            .asMap()
                            .entries
                            .map((entry) {
                          int index = entry.key;
                          Map<String, dynamic> schedule = entry.value;
                          return _buildScheduleItem(
                            schedule['time']!,
                            schedule['event']!,
                            schedule['completed']!,
                            index,
                            screenWidth,
                          );
                        }).toList(),
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
    DateTime date,
  ) {
    bool isSelected = selectedDate.day == date.day &&
        selectedDate.month == date.month &&
        selectedDate.year == date.year;

    String day = date.day.toString();
    String weekday =
        DateFormat('EEE').format(date); // Formats to 'Mon', 'Tue', etc.

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDate = date; // Change selected date
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.206,
        padding: EdgeInsets.only(bottom: 24),
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

  // Creates swipeable schedule items with specific colors and delete functionality
  Widget _buildScheduleItem(String time, String event, bool completed,
      int index, double screenWidth) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: EdgeInsets.only(bottom: 12),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 24,
        ),
      ),
      onDismissed: (direction) {
        // Ensure there's a list for the selectedDate before attempting to remove
        if (Globals.schedules[selectedDate] != null) {
          final dismissedItem = Globals.schedules[selectedDate]!.removeAt(index);
          Globals.save(); // Save after deletion
          // Update the state to reflect the removal in the UI
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Event "${dismissedItem['event']}" deleted'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: Container(
        width: screenWidth * 0.911,
        height: 96,
        // Increased height by 20% (80 * 1.2 = 96)
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: completed
              ? Color(0xFF0262A4) // Color when checked
              : Color(0xFF0397FD), // Color when not checked
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF0397FD).withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              time,
              style: GoogleFonts.inter(
                fontSize: 26, // Increased font size for time
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                event,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  // Ensure the list exists before trying to update an item
                  if (Globals.schedules[selectedDate] != null &&
                      index < Globals.schedules[selectedDate]!.length) {
                    Globals.schedules[selectedDate]![index]['completed'] = !completed;
                    Globals.save(); // Save after toggling completion
                  }
                });
              },
              child: Container(
                width: 40, // Increased checkbox size slightly to match image
                height: 40,
                decoration: BoxDecoration(
                  color: completed ? Colors.white : Colors.transparent,
                  border: Border.all(color: Colors.white, width: 2.5),
                  shape: BoxShape
                      .circle, // Changed to circle for the checkmark container
                ),
                child: completed
                    ? Icon(
                        Icons.check,
                        color: Color(0xFF0397FD),
                        size: 24, // Increased check icon size
                      )
                    : null,
              ),
            ),
          ],
        ),
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
            'Add Event for ${DateFormat('EEE, MMM d').format(selectedDate)}', // Display full date
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: timeController,
                decoration: InputDecoration(labelText: 'Time (HH:MM)'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  TimeInputFormatter(),
                ],
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
                if (timeController.text.isNotEmpty &&
                    eventController.text.isNotEmpty) {
                  setState(() {
                    // Initialize the list for selectedDate if it doesn't exist
                    Globals.schedules.putIfAbsent(selectedDate, () => []);
                    Globals.schedules[selectedDate]!.add({
                      'time': timeController.text,
                      'event': eventController.text,
                      'completed': false,
                    });
                    // Sort the schedule by time after adding a new event
                    Globals.schedules[selectedDate]!
                        .sort((a, b) => a['time'].compareTo(b['time']));
                    Globals.save(); // Save after adding new event
                  });
                  timeController.clear();
                  eventController.clear();
                  Navigator.of(context).pop();
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
