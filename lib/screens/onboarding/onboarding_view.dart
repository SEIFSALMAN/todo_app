import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_app/screens/authentication/login_view.dart';
import 'package:todo_app/screens/authuser_home_screen.dart';

import '../../shared/components/navigator.dart';
import '../../shared/network/cache_helper.dart';


class onBoardingModel {
  final String text;
  final String sloganText;
  final String image;

  onBoardingModel(this.text, this.sloganText, this.image);
}

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  int currentIndex = 0;
  late PageController controller;

  List<onBoardingModel> onBoarding = [
    onBoardingModel(
        "Welcome to Task Tide",
        "Task Tide is an app designed to help users organize and manage their tasks and responsibilities. ",
        "assets/to-do-list.png"),
    onBoardingModel(
        "Task Organization",
        "Users can set priorities for tasks to indicate which ones are most important or urgent, helping them focus on what needs to be done first.",
        "assets/images/onBoardingImage3.png"),
    onBoardingModel(
        "Reminders and Notifications",
        "To-do apps often offer reminders and notifications to alert users about upcoming deadlines or tasks that need attention.",
        "assets/images/onBoardingImage5.png"),
    onBoardingModel(
        "Synchronization",
        "To-do apps frequently synchronize across multiple devices and platforms, ensuring users have access to their tasks wherever they go.",
        "assets/images/onBoardingImage3.png")
  ];

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    super.initState();
  }

  void submit() {
    //To Make it appear again .set value to False  ||||
    CacheHelper.saveData(key: "onBoarding", value: true).then((value) {
      print(CacheHelper.getData(key: 'onBoarding'));
      if (value) {
        AppNavigator.customNavigator(
            context: context, screen: LoginView(), finish: true);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          TextButton(
            child: Text(
              "Skip",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            onPressed: () => submit(),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: 4,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Image.asset(onBoarding[index].image, height: 250),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        onBoarding[index].text,
                        maxLines: 4,
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        onBoarding[index].sloganText,
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SmoothPageIndicator(
            controller: controller,
            count: 4,
            effect: ExpandingDotsEffect(
              dotHeight: 10,
              expansionFactor: 4,
              dotWidth: 10,
              activeDotColor: Colors.blue
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                shadowColor: Colors.transparent,
                elevation: 0,
              ),
              onPressed: () {
                if (currentIndex == 3) {
                  submit();
                }
                controller.nextPage(
                    duration: Duration(milliseconds: 250),
                    curve: Curves.easeIn);
              },
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                  currentIndex == 3 ?  "Continue" :  "Next",
                  style: TextStyle(fontSize: 16, fontFamily: 'PlaypenSans',color: Colors.white),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
