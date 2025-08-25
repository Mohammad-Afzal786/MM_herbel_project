import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mmherbel/modules/deshboard/controllers/dashboard_controller.dart';
import 'package:mmherbel/core/utils/nav_helper.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final List<Map<String, dynamic>> products = List.generate(
    15,
    (_) => {
      'name': 'Dress Woman',
      'price': 400.0,
      'oldPrice': 200.0,
      'image': 'assets/images/navwall.png',
      'rating': 4.5,
    },
  );

  /// 🔹 Rotating Search Items
  final List<String> searchItems = [
    "Headphones",
    "Sneakers",
    "Smart Watch",
    "T-Shirts",
  ];

  int _currentIndex = 0;
  Timer? _hintTimer;

  /// ✅ Search state
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _hintTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!_isSearching) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % searchItems.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _hintTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.find<DashboardController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final itemHeight = 300.h;
    final totalHorizontalPadding = 20.w;
    final crossAxisSpacing = 8.w;
    final itemWidth =
        (screenWidth - totalHorizontalPadding - crossAxisSpacing) / 2;
    final childAspectRatio = itemWidth / itemHeight;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          controller.changeTab(0); // ✅ Home tab पर switch
        }
      },
      child: Scaffold(
        appBar:AppBar(
            title: Text(
              'Wishlist',
              style: TextStyle(fontSize: 18.sp), // responsive text
            ),
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: () => NavHelper.goToHomeTab(),
            ),
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
        
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(8.w),
          child: CustomScrollView(
            slivers: [
              /// 🔹 Search Bar
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSearching = true;
                    });
                  },
                  child: Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, anim) => FadeTransition(
                        opacity: anim,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.3),
                            end: Offset.zero,
                          ).animate(anim),
                          child: child,
                        ),
                      ),
                      child: _isSearching
                          ? TextField(
                              key: const ValueKey("textField"),
                              controller: _searchController,
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: "Type to search...",
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    setState(() {
                                      _isSearching = false;
                                      _searchController.clear();
                                    });
                                  },
                                ),
                              ),
                            )
                          : Row(
                              key: const ValueKey("idle"),
                              children: [
                                Icon(Icons.search, color: Colors.grey[600]),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Search ",
                                        style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      AnimatedSwitcher(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        transitionBuilder: (child, anim) {
                                          return SlideTransition(
                                            position: Tween<Offset>(
                                              begin: const Offset(0, 1),
                                              end: const Offset(0, 0),
                                            ).animate(CurvedAnimation(
                                              parent: anim,
                                              curve: Curves.easeOut,
                                            )),
                                            child: FadeTransition(
                                              opacity: anim,
                                              child: child,
                                            ),
                                          );
                                        },
                                        child: Text(
                                          searchItems[_currentIndex],
                                          key: ValueKey(_currentIndex),
                                          style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(height: 16.h),
              ),

              /// 🔹 Product Grid
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: crossAxisSpacing,
                  childAspectRatio: childAspectRatio,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, idx) {
                    final product = products[idx];
                    return SizedBox(
                      height: itemHeight,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 200.h,
                                margin: EdgeInsets.only(
                                  left: 4.w,
                                  right: 4.w,
                                  top: 6.h,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Image.asset(
                                    product['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10.h,
                                right: 10.w,
                                child: Container(
                                  height: 28.h,
                                  width: 28.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4.r,
                                        offset: Offset(0, 1.h),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 18.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 3.h,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product['name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 2.h),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 15.sp,
                                            ),
                                            SizedBox(width: 3.w),
                                            Text(
                                              product['rating'].toString(),
                                              style: TextStyle(fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 2.h),
                                        Row(
                                          children: [
                                            Text(
                                              product['price'].toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                            SizedBox(width: 6.w),
                                            Text(
                                              product['oldPrice'].toString(),
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 15.h, right: 10.h),
                                    height: 36.h,
                                    width: 36.w,
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Icon(
                                      Icons.shopping_bag,
                                      color: Colors.white,
                                      size: 21.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: products.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
