import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmherbel/theme/app_colors.dart';
import 'package:get_storage/get_storage.dart';


class Intropage extends StatefulWidget {
  const Intropage({super.key});

  @override
  IntropageState createState() => IntropageState();
}

class IntropageState extends State<Intropage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<IntropageData> pages = [
    IntropageData(
      imagePath: 'assets/images/p1.jpg',
      title: 'आयुर्वेद\nआसान तरीक़े से',
      subtitle:
          'प्राकृतिक देखभाल और रोज़मर्रा की सेहत के लिए सरल और स्पष्ट मार्गदर्शन।',
      buttonText: 'Next',
    ),
    IntropageData(
      imagePath: 'assets/images/p1.jpg',
      title: 'मुनासिब नुस्ख़े\nआपके लिए',
      subtitle:
          'आपकी ज़रूरत के अनुसार तैयार आयुर्वेदिक सुझाव और उत्पाद। सही जानकारी और आसान उपयोग।',
      buttonText: 'Next',
    ),
    IntropageData(
      imagePath: 'assets/images/p1.jpg',
      title: 'सुरक्षित\nख़रीददारी',
      subtitle:
          'सामग्री, उपयोग और सावधानियों की पूरी जानकारी। कोई सवाल हो तो हकीम से पूछें।',
      buttonText: 'Finish',
    ),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }

  void _nextPage() {
    if (_currentPage < pages.length - 1) {
      _goToPage(_currentPage + 1);
    } else {
       GetStorage().write('seenIntro', true); // flag save
       Get.offAllNamed('/login');
      
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: pages.length,
            itemBuilder: (context, index) {
              final page = pages[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    page.imagePath,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black87, Colors.transparent],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            top: 20,
            right: 16,
            child: (_currentPage != pages.length - 1)
                ? TextButton(
                    onPressed: () => _goToPage(pages.length - 1),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    pages[_currentPage].title,
                    style: const TextStyle(
                      fontFamily: 'NotoSans',
                      color: Colors.white70,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    pages[_currentPage].subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontFamily: 'NotoSans',
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        pages.length,
                        (index) => GestureDetector(
                          onTap: () => _goToPage(index),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width: 32,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ?  AppsColors.primary
                                  : Colors.white70,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                      height: 50,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor:AppsColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        pages[_currentPage].buttonText,
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IntropageData {
  final String imagePath;
  final String title;
  final String subtitle;
  final String buttonText;

  IntropageData({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonText,
  });
}
