import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_kit/fake_var.dart';
import 'package:motion_kit/l10n/app_localizations.dart';
import 'package:motion_kit/pages/ThaiIdInputPage.dart';
import 'package:motion_kit/theme/wcag_utils.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class ShopItem {
  final String id;
  final String name;
  final String price;
  final String imagePath;

  ShopItem({required this.id, required this.name, required this.price, required this.imagePath});
}

class CardMetadata {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final List<ShopItem> items;

  CardMetadata({required this.id, required this.title, required this.description, required this.imagePath, required this.items});
}

int coinPD = 240;
double governmentPPD = 6.5;
double aiaPPD = 4.5;

class _ShopPageState extends State<ShopPage> {
  int _selectedCardIndex = 0;
  late PageController _pageController;

  List<CardMetadata> get availableCards {
    final l10n = AppLocalizations.of(context)!;
    List<CardMetadata> cards = [
      CardMetadata(
      id: 'default',
      title: l10n.shopCardDefaultTitle,
      description: l10n.shopCardDefaultDescription,
      imagePath: 'assets/Newgamepic.png',
      items: [
        ShopItem(id: 'unlockWander', name: l10n.shopItemUnlockWander, price: '250', imagePath: 'assets/WanderLogo.png'),
        ShopItem(id: 'sushiroCoupon60', name: l10n.shopItemSushiroCoupon60, price: ((60 / aiaPPD) * coinPD).ceil().toString(), imagePath: 'assets/voucher/Sushiro.png'),
        ShopItem(id: 'mkRestaurant150', name: l10n.shopItemMkRestaurant150, price: ((150 / aiaPPD) * coinPD).ceil().toString(), imagePath: 'assets/voucher/MK.jpg'),
        ShopItem(id: 'momo20Off', name: l10n.shopItemMomo20Off, price: ((140 / aiaPPD) * coinPD).ceil().toString(), imagePath: 'assets/voucher/MOMO.png'),
        ShopItem(id: 'freeMajorTicket', name: l10n.shopItemFreeMajorTicket, price: ((220 / aiaPPD) * coinPD).ceil().toString(), imagePath: 'assets/voucher/MAJOR.png'),
        ShopItem(id: 'freeSfPopcorn', name: l10n.shopItemFreeSfPopcorn, price: ((120 / aiaPPD) * coinPD).ceil().toString(), imagePath: 'assets/voucher/SFC.jpeg'),
      ],
    )];

    if (Globals.isThaiIdVerified) {
      cards.addAll([
        CardMetadata(
          id: 'universalCoverage',
          title: l10n.shopCardUniversalTitle,
          description: l10n.shopCardUniversalDescription,
          imagePath: 'assets/card/gold_flat.png',
          items: [
            ShopItem(id: 'pttFuel300', name: l10n.shopItemPttFuel300, price: ((300 / governmentPPD) * coinPD).ceil().toString(), imagePath: 'assets/voucher/PTT.jpg'),
            ShopItem(id: 'bcpFuel300', name: l10n.shopItemBcpFuel300, price: ((300 / governmentPPD) * coinPD).ceil().toString(), imagePath: 'assets/voucher/BCP.png'),
            ShopItem(id: 'meaPea150', name: l10n.shopItemMeaPea150, price: ((150 / governmentPPD) * coinPD).ceil().toString(), imagePath: 'assets/voucher/Electricity.png'),
            ShopItem(id: 'mwaPwa150', name: l10n.shopItemMwaPwa150, price: ((150 / governmentPPD) * coinPD).ceil().toString(), imagePath: 'assets/voucher/Water.jpg'),
            ShopItem(id: 'nt250', name: l10n.shopItemNt250, price: ((250 / governmentPPD) * coinPD).ceil().toString(), imagePath: 'assets/voucher/NT.jpg'),
            ShopItem(id: 'mrt200', name: l10n.shopItemMrt200, price: ((200 / governmentPPD) * coinPD).ceil().toString(), imagePath: 'assets/voucher/MRT.jpg'),
            ShopItem(id: 'thailandPost100', name: l10n.shopItemThailandPost100, price: ((100 / governmentPPD) * coinPD).ceil().toString(), imagePath: 'assets/voucher/ThailandP.png'),
            ShopItem(id: 'govLottery', name: l10n.shopItemGovLottery, price: ((80 / governmentPPD) * coinPD).ceil().toString(), imagePath: 'assets/voucher/Lottery.png'),
          ],
        ),
        CardMetadata(
          id: 'aiaVitality',
          title: l10n.shopCardAiaTitle,
          description: l10n.shopCardAiaDescription,
          imagePath: 'assets/card/aia_vita.png',
          items: [
          ],
        ),
      ]);
    }

    cards.add(
      CardMetadata(
        id: 'thaiId',
        title: l10n.shopCardThaiIdTitle,
        description: Globals.isThaiIdVerified ? l10n.shopCardThaiIdVerified : l10n.shopCardThaiIdUnverified,
        imagePath: 'assets/ThaiID-Front.png',
        items: [],
      )
    );

    return cards;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final l10n = AppLocalizations.of(context)!;
    final pageTextScale = mediaQuery.textScaler
        .scale(1.0)
        .clamp(1.0, 1.3)
        .toDouble();

    return MediaQuery(
      data: mediaQuery.copyWith(textScaler: TextScaler.linear(pageTextScale)),
      child: Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 2),
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
                  Padding(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      child: Image.asset(
                        'assets/FlexiFlowLogoColor.png',
                        width: screenWidth * 0.1,
                        height: screenWidth * 0.1,
                        fit: BoxFit.contain,
                      ),
                    ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.shopTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: screenWidth * 0.065,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF2C2C2C),
                            letterSpacing: 0.5,
                          ),
                        ),
                        Container(
                          height: 2,
                          width: screenWidth * 0.1,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/CoinsLogo.png',
                            width: screenWidth * 0.084,
                          ),
                          SizedBox(width: screenWidth * 0.016),
                          Text(
                            '${Globals.coins}',
                            style: GoogleFonts.inter(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.w700,
                              color: wcagColor(
                                context,
                                standard: const Color(0xFFF6B647),
                                wcag: tokensOf(context).textReward,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: screenHeight * 0.02),
              SizedBox(
                height: screenHeight * 0.22,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedCardIndex = index;
                    });
                  },
                  itemCount: availableCards.length,
                  itemBuilder: (context, index) {
                    final card = availableCards[index];
                    return GestureDetector(
                      onTap: () async {
                        if (card.id == 'thaiId' && !Globals.isThaiIdVerified) {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ThaiIdInputPage()),
                          );
                          if (result == true) {
                            setState(() {
                              _selectedCardIndex = 0;
                            });
                          }
                        }
                      },
                      child: _buildCreditCard(card, index == _selectedCardIndex),
                    );
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Recommended/All Selection Part
              /*
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0425),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
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
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _selectedCategory == 'Recommended'
                                  ? const Color(0xFF0397FD)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(21.0),
                            ),
                            child: Text(
                              'Recommended',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _selectedCategory == 'Recommended'
                                    ? Colors.white
                                    : const Color(0xFF666666),
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
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _selectedCategory == 'All'
                                  ? const Color(0xFF0397FD)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(21.0),
                            ),
                            child: Text(
                              'All',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _selectedCategory == 'All'
                                    ? Colors.white
                                    : const Color(0xFF666666),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

               */
              Expanded(
                child: GridView.count(
                  padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.0425,
                    0,
                    screenWidth * 0.0425,
                    screenHeight * 0.12, // Bottom padding for "Back" button
                  ),
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    for (var item in availableCards[_selectedCardIndex].items)
                      if (!(item.id == 'unlockWander' && Globals.unlockedSumItUp))
                        _buildShopItems(
                          itemId: item.id,
                          ItemPic: item.imagePath,
                          ItemLabel: item.name,
                          ItemPrice: item.price,
                        ),
                    _buildRequestItem(screenWidth),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFF8F8F8).withOpacity(0),
                    const Color(0xFFF8F8F8),
                  ],
                ),
              ),
              padding: EdgeInsets.only(
                bottom: screenHeight * 0.03,
                top: screenHeight * 0.02,
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0397FD), Color(0xFF0277BD)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0397FD).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      l10n.goBack,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildRequestItem(double screenWidth) {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        _showRequestDialog(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: const Color(0xFFE0E0E0),
              style: BorderStyle.solid,
              width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline_rounded,
              size: 40,
              color: const Color(0xFF8B8B8B),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.shopRequest,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF8B8B8B),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.shopMoreItemsComingSoon,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                color: const Color(0xFFB0B0B0),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRequestDialog(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final l10n = AppLocalizations.of(context)!;
    TextEditingController requestController = TextEditingController();

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
                  l10n.shopRequestItemTitle,
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.055,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenWidth * 0.04),
                Text(
                  l10n.shopRequestItemPrompt,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: screenWidth * 0.04),
                TextField(
                  controller: requestController,
                  decoration: InputDecoration(
                    hintText: l10n.shopRequestItemHint,
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                SizedBox(height: screenWidth * 0.06),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: screenWidth * 0.12,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              l10n.cancel,
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
                          // Handle request submission
                          Navigator.of(context).pop();
                          if (requestController.text.isNotEmpty) {
                            _showThankYouDialog(context);
                          }
                        },
                        child: Container(
                          height: screenWidth * 0.12,
                          decoration: BoxDecoration(
                            color: Color(0xFF0397FD),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              l10n.submit,
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

  void _showThankYouDialog(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final l10n = AppLocalizations.of(context)!;

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
                Icon(
                  Icons.check_circle_outline_rounded,
                  color: const Color(0xFF0397FD),
                  size: screenWidth * 0.15,
                ),
                SizedBox(height: screenWidth * 0.04),
                Text(
                  l10n.shopThankYouTitle,
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.055,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),
                Text(
                  l10n.shopThankYouMessage,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: screenWidth * 0.06),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: screenWidth * 0.12,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0397FD),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        l10n.closeLabel,
                        style: GoogleFonts.inter(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCreditCard(CardMetadata card, bool isActive) {
    if (card.id == 'aiaVitality' || card.id == 'universalCoverage') {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: isActive ? 0 : 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          image: DecorationImage(
            image: AssetImage(card.imagePath),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: isActive ? 0 : 16,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: card.id == 'aiaVitality'
              ? [const Color(0xFFD32F2F), const Color(0xFFC62828)]
            : card.id == 'universalCoverage'
                  ? [const Color(0xFF00B0FF), const Color(0xFF0081CB)]
              : card.id == 'thaiId'
                      ? (Globals.isThaiIdVerified
                          ? [const Color(0xFF388E3C), const Color(0xFF2E7D32)]
                          : [const Color(0xFFFF9800), const Color(0xFFF57C00)])
                      : [const Color(0xFF424242), const Color(0xFF212121)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    card.title,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.credit_card, color: Colors.white70),
              ],
            ),
            const Spacer(),
            Text(
              card.description,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.white.withOpacity(0.8),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShopItems({
    required String itemId,
    required String ItemPic,
    required String ItemLabel,
    required String ItemPrice,
  }) {
    final mediaQuery = MediaQuery.of(context);
    final tileTextScale = mediaQuery.textScaler
        .scale(1.0)
        .clamp(1.0, 1.2)
        .toDouble();

    return MediaQuery(
      data: mediaQuery.copyWith(textScaler: TextScaler.linear(tileTextScale)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Image.asset(ItemPic, fit: BoxFit.contain),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Center(
                        child: Text(
                          ItemLabel,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: const Color(0xFF2C2C2C),
                            height: 1.2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: () {
                        _showBuyConfirmationDialog(context, itemId, ItemLabel, ItemPrice);
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0397FD), Color(0xFF0277BD)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0397FD).withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.buyLabel,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 1,
                                  height: 16,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  ItemPrice,
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: wcagColor(
                                      context,
                                      standard: const Color(0xFFFFD54F),
                                      wcag: tokensOf(context).textReward,
                                    ),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Image.asset(
                                  'assets/CoinsLogo.png',
                                  width: 14,
                                  height: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBuyConfirmationDialog(
      BuildContext context, String itemId, String itemName, String itemPrice) {
    double screenWidth = MediaQuery.of(context).size.width;
    final l10n = AppLocalizations.of(context)!;

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
                  l10n.shopConfirmPurchaseTitle,
                  style: GoogleFonts.inter(
                    fontSize: screenWidth * 0.055,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenWidth * 0.04),
                Text(
                  l10n.shopConfirmPurchaseMessage(itemName, itemPrice),
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
                              l10n.cancel,
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
                          setState(() {
                            Globals.coins -= int.parse(itemPrice); // Deduct coins
                            if (itemId == 'unlockWander') {
                              Globals.unlockedSumItUp = true;
                            }
                            Globals.save();
                          });
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.shopPurchaseSuccess(itemName)),
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
                              l10n.buyLabel,
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
