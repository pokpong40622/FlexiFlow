import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String _selectedCategory = 'Recommended'; //Selected recommended or all

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0425),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.024),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/FlexiFlowLogoColor.png',
                      width: screenWidth * 0.13,
                    ),
                    Text(
                      'Shop',
                      style: GoogleFonts.inter(
                        fontSize: screenWidth * 0.062,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '83',
                          style: GoogleFonts.inter(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFF6B647),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.016),
                        Image.asset(
                          'assets/CoinsLogo.png',
                          width: screenWidth * 0.084,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.034),
                // Recommended/All Selection Part
                Container(
                  height: screenHeight * 0.0516,
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = 'Recommended';
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _selectedCategory == 'Recommended'
                                  ? Color(
                                      0xFF0397FD,
                                    ) // Selected color (blue from your image)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              'Recommended',
                              style: GoogleFonts.inter(
                                fontSize: screenWidth * 0.037,
                                fontWeight: FontWeight.w700,
                                color: _selectedCategory == 'Recommended'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = 'All';
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _selectedCategory == 'All'
                                  ? Color(0xFF007BFF) // Selected color
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              'All',
                              style: GoogleFonts.inter(
                                fontSize: screenWidth * 0.037,
                                fontWeight: FontWeight.w700,
                                color: _selectedCategory == 'All'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.023),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildShopItems(
                              ItemPic: 'assets/Newgamepic.png',
                              ItemLabel: 'Unlock new games!',
                              ItemPrice: '80',
                            ),
                            SizedBox(width: screenWidth * 0.037),
                            _buildShopItems(
                              ItemPic: 'assets/Lotterypic.png',
                              ItemLabel: 'Lottery',
                              ItemPrice: '60',
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.021),
                        Row(
                          children: [
                            _buildShopItems(
                              ItemPic: 'assets/Sushiropic.png',
                              ItemLabel: 'Sushiro Coupon 60B',
                              ItemPrice: '50',
                            ),
                            SizedBox(width: screenWidth * 0.037),
                            Container(
                              width: screenWidth * 0.43888,
                              height: screenHeight * 0.218,
                              child: Center(
                                child: Text(
                                  'Request',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF8B8B8B),
                                    fontSize: screenWidth * 0.044,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFFAFAFA),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.03),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                    color: Color(0xFF0397FD),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
                    child: Text(
                      'Back',
                      style: GoogleFonts.inter(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopItems({
    required String ItemPic,
    required String ItemLabel,
    required String ItemPrice,
  }) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: screenWidth * 0.43888,
          height: screenHeight * 0.218,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.018),
                child: Container(
                  width: screenWidth * 0.36481,
                  height: screenHeight * 0.096666,
                  child: Expanded(child: Image.asset(ItemPic)),
                  decoration: BoxDecoration(
                    // color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.directional(
                  top: screenHeight * 0.0122,
                  bottom: screenHeight * 0.0128,
                ),
                child: Text(
                  ItemLabel,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth * 0.0304,
                    color: Colors.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showBuyConfirmationDialog(context, ItemLabel, ItemPrice);
                },
                child: Container(
                  width: screenWidth * 0.39722,
                  height: screenHeight * 0.0395,
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Buy',
                          style: GoogleFonts.inter(
                            fontSize: screenWidth * 0.027,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.174),
                        Text(
                          ItemPrice,
                          style: GoogleFonts.inter(
                            fontSize: screenWidth * 0.032,
                            color: Color(0xFFFDD835),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        Image.asset(
                          'assets/CoinsLogo.png',
                          width: screenWidth * 0.042,
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0xFF0397FD),
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }

  void _showBuyConfirmationDialog(
      BuildContext context, String itemName, String itemPrice) {
    double screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.05),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Confirm Purchase',
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.055,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenWidth * 0.04),
                Text(
                  'Are you sure you want to buy $itemName for $itemPrice coins?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.04,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: screenWidth * 0.06),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Container(
                          height: screenWidth * 0.12,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.inter(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Handle the actual purchase logic here
                          // For now, just close the dialog and print a message
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('You have successfully purchased $itemName!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          print('Purchase confirmed for $itemName');
                        },
                        child: Container(
                          height: screenWidth * 0.12,
                          decoration: BoxDecoration(
                            color: Color(0xFF0397FD),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              'Buy',
                              style: GoogleFonts.inter(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}