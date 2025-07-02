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
      body: Padding(
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
                      width: screenWidth * 0.1,
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
            SizedBox(height: screenHeight * 0.02),
            // Add content below based on _selectedCategory
            // For example, if you have a list of items to display:
            // if (_selectedCategory == 'Recommended') {
            //   // Display recommended items
            // } else {
            //   // Display all items
            // }
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    _buildShopItems(ItemPic: 'assets/Newgamepic.png', ItemLabel: 'Unlock new games!', ItemPrice: '80')
                    // Container(
                    //   width: screenWidth * 0.43888,
                    //   height: screenHeight * 0.218,
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Padding(
                    //         padding: EdgeInsetsGeometry.directional(top: screenHeight *0.018),
                    //         child: Container(
                    //           width: screenWidth*0.36481,
                    //           height: screenHeight * 0.096666,
                    //           child: Expanded(
                    //             child: Image.asset(
                    //               'assets/Newgamepic.png'
                    //             ),
                    //           ),
                    //           decoration: BoxDecoration(
                    //             // color: Colors.black,
                    //             borderRadius: BorderRadius.circular(4)
                    //           ),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: EdgeInsetsGeometry.directional(top:screenHeight *0.0122,bottom: screenHeight *0.0128),
                    //         child: Text(
                    //             'Sushiro Coupon 60B',
                    //             style: GoogleFonts.montserrat(
                    //               fontWeight: FontWeight.w600,
                    //               fontSize: screenWidth * 0.0304,
                    //               color: Colors.black
                    //             ),
                    //           ),
                    //       ),
                    //       Container(
                    //         width: screenWidth *0.39722,
                    //         height: screenHeight * 0.0395,
                    //         child: Expanded(
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             children: [
                    //               Text(
                    //                 'Buy',
                    //                 style: GoogleFonts.inter(
                    //                   fontSize: screenWidth * 0.027,
                    //                   color: Colors.white,
                    //                   fontWeight: FontWeight.w600
                    //                 ),
                    //               ),
                    //               SizedBox(width: screenWidth * 0.174,),
                    //               Text(
                    //                 '80',
                    //                 style: GoogleFonts.inter(
                    //                   fontSize: screenWidth * 0.032,
                    //                   color: Color(0xFFFDD835),
                    //                   fontWeight: FontWeight.w700
                    //                 ),
                    //               ),
                    //               SizedBox(width: screenWidth * 0.01,),
                    //               Image.asset(
                    //                 'assets/CoinsLogo.png',
                    //                 width: screenWidth * 0.042,
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(4),
                    //           color: Color(0xFF0397FD)
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: Color(0xFFFAFAFA),
                    //     borderRadius: BorderRadius.circular(10)
                    //   ),
                    // )
                  ],
                ),
              ],
            ),
          ],
        ),
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
                padding: EdgeInsetsGeometry.directional(
                  top: screenHeight * 0.018,
                ),
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
              Container(
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
}
