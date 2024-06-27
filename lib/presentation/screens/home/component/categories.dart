import 'package:flutter/material.dart';
import 'package:quastions_game/constants/navigator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quastions_game/presentation/screens/home/component/shimmer_category.dart';
import '../../../../constants/colors.dart';
import '../../../../data/api/api.dart';
import '../../../../data/models/category.dart';
import '../../../widgets/button.dart';
import '../../question_screen/questions.dart';

class Categories extends StatefulWidget {
  Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final API _api = API();
  late Future<CategoriesResponse?> _categoriesFuture;
  bool progress = false;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _api.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<CategoriesResponse?>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CategoryShimmer();
        } else if (snapshot.hasError) {
          return Center(child: Text('خطأ في الاتصال بالإنترنت',style: TextStyle(
            color: Colors.black,
            fontSize: size.width * 0.05,
            fontFamily: 'Kohinoor Arabic',
          ),));
        } else if (snapshot.hasData && snapshot.data!.success) {
          List<Category> categories = snapshot.data!.data;

          return Container(
            height: size.height * 0.5,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 10, // Spacing between columns
                mainAxisSpacing: 10, // Spacing between rows
                childAspectRatio: 1, // Aspect ratio of the grid items
              ),
              itemCount: categories.length,
              // Number of items in the grid
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      progress = true;
                    });
                    startExamDialog(context, categories[index].id, () {});
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    // Margin around each container
                    height: size.height * 0.3,
                    width: size.width * 0.4,
                    // Adjust the width according to your requirement
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      border: Border.all(color: Colors.transparent),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(5, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(
                          'https://binhizam-sa.com/${categories[index].image}',
                          fit: BoxFit.cover,
                          height: size.height * 0.08,
                          width: size.width * 0.2,
                        ),
                        Text(
                          categories[index].name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Kohinoor Arabic',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(child: Padding(
            padding:  EdgeInsets.symmetric(vertical: size.height*0.1),
            child: Text('خطأ في الاتصال بالإنترنت',style: TextStyle(
              color: Colors.black,
              fontSize: size.width * 0.05,
              fontFamily: 'Kohinoor Arabic',
            ),),
          ));
        }
      },
    );
  }
}

void startExamDialog(BuildContext context, int id, VoidCallback onStartPressed) {
  bool progress = false;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(); // Close the dialog before navigation
            onStartPressed(); // Call the callback function to update the progress variable
            navigateTo(context, Questions(id: id));
          },
          child: Button(
            width: double.infinity,
            text: 'بدء الأسئلة',
            inProgress: progress,
            colorPrimary: scundryColor,
            colorDark: scundryColorDark,
            colorProgress: kPrimaryColor,
            fontSize: 20.sp,
          ),
        ),
      );
    },
  );
}