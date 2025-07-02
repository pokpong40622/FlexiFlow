import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Import for date formatting

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
  final Map<DateTime, List<Map<String, dynamic>>> schedules = {};

  late DateTime today; // Will store today's date
  late DateTime selectedDate; // Will store the currently selected date in the calendar

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    // Normalize today to just year, month, day for consistent keying in map
    today = DateTime(today.year, today.month, today.day);
    selectedDate = today;

    // Initialize some dummy data for demonstration, using actual dates as keys
    _initializeDummySchedules();
  }

  void _initializeDummySchedules() {
    // Example: Schedule for today
    schedules[today] = [
      {'time': '07:30', 'event': 'Wake up and brush your teeth', 'completed': true},
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

  @override
  void dispose() {
    timeController.dispose();
    eventController.dispose();
    super.dispose();
  }

  final TextEditingController timeController = TextEditingController();
  final TextEditingController eventController = TextEditingController();

  int activeIndex = 0; // Keeping this for carousel, not directly for calendar days

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final List<Widget> slideItems = [
      Image.asset('assets/PerfectMatchLogo.png'),
      Image.asset('assets/WanderLogo.png'),
      Container(color: Colors.white),
      Container(color: Colors.white),
    ];

    // Get the dates for the current view (today + next 3 days)
    List<DateTime> displayDates = List.generate(
        4, (index) => DateTime(today.year, today.month, today.day).add(Duration(days: index)));

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
            SizedBox(height: screenHeight * 0.022),
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
                  SizedBox(height: screenHeight * 0.014),
                  Container(
                    height: screenHeight * 0.35, // Adjust this height as needed
                    child: SingleChildScrollView(
                      child: Column(
                        children: (schedules[selectedDate] ?? [])
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
                            })
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
    DateTime date,
  ) {
    bool isSelected = selectedDate.day == date.day &&
        selectedDate.month == date.month &&
        selectedDate.year == date.year;

    String day = date.day.toString();
    String weekday = DateFormat('EEE').format(date); // Formats to 'Mon', 'Tue', etc.

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
  Widget _buildScheduleItem(
      String time, String event, bool completed, int index, double screenWidth) {
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
        if (schedules[selectedDate] != null) {
          final dismissedItem = schedules[selectedDate]!.removeAt(index);
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
        height: 96, // Increased height by 20% (80 * 1.2 = 96)
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
                  if (schedules[selectedDate] != null && index < schedules[selectedDate]!.length) {
                    schedules[selectedDate]![index]['completed'] = !completed;
                  }
                });
              },
              child: Container(
                width: 40, // Increased checkbox size slightly to match image
                height: 40,
                decoration: BoxDecoration(
                  color: completed ? Colors.white : Colors.transparent,
                  border: Border.all(color: Colors.white, width: 2.5),
                  shape: BoxShape.circle, // Changed to circle for the checkmark container
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
                if (timeController.text.isNotEmpty && eventController.text.isNotEmpty) {
                  setState(() {
                    // Initialize the list for selectedDate if it doesn't exist
                    schedules.putIfAbsent(selectedDate, () => []);
                    schedules[selectedDate]!.add({
                      'time': timeController.text,
                      'event': eventController.text,
                      'completed': false,
                    });
                    // Sort the schedule by time after adding a new event
                    schedules[selectedDate]!.sort((a, b) => a['time'].compareTo(b['time']));
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