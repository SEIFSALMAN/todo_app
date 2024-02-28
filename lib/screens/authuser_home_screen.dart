import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/network/cache_helper.dart';
import 'package:todo_app/shared/provider/service_provider.dart';

import '../shared/components/add_new_task_model.dart';
import '../shared/components/card_todo_widget.dart';
import '../shared/components/navigator.dart';
import '../shared/components/switcher.dart';
import 'authentication/login_view.dart';

class AuthUserHomeScreen extends ConsumerWidget {
  const AuthUserHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(child: Text("Task Tide",style: TextStyle(fontSize: 35,color: Colors.white),)),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Dark Mode'),
              trailing: DarkLightSwitcher(),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Logout',style: TextStyle(color: Colors.red)),
              onTap: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Are you sure?"),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text("You will be redirected to login page."),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text("Yes"),
                          onPressed: () {
                            AppNavigator.customNavigator(context: context, screen: const LoginView(), finish: true);
                            FirebaseAuth.instance.signOut();
                            CacheHelper.saveData(key: "uId", value: -1);
                          },
                        ),
                        TextButton(
                          child: Text("No"),
                          onPressed: () {
                            Navigator.of(context).pop(); // Dismiss the Dialog
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: NestedScrollView(
          physics: (todoData.value?.length ?? 0) >= 4
              ? AlwaysScrollableScrollPhysics()
              : NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              leading: Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Theme.of(context).iconTheme.color,
                         size: 25,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      tooltip:
                          MaterialLocalizations.of(context).openAppDrawerTooltip,
                    ),
                  );
                },
              ),
              pinned: (todoData.value?.length ?? 0) != 0 ? false : true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              floating: true,
              toolbarHeight: 70,
              snap: true,
              title: ListTile(
                title: Transform.translate(
                  offset: Offset(-20,0),
                  child: Text(
                    "Task Tide",
                    style: Theme.of(context).textTheme.displayLarge
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/profile.jpg"),
                    radius: 24,
                  ),
                ),
              ],
            )
          ],
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today's Task",
                          style: Theme.of(context).textTheme.bodyLarge
                        ),
                        Text(
                          "${DateFormat('MMMMEEEEd').format(DateTime.now())}",
                          style:  Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                    Gap(6),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                          backgroundColor: Color(0xFFD5E8FA),
                          foregroundColor: Colors.blue.shade700,
                          elevation: 0),
                      onPressed: () => showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        context: context,
                        builder: (context) => AddNewTaskModel(),
                      ),
                      child: Text(
                        "+ New Task",
                      ),
                    )
                  ],
                ),
                (todoData.value?.length ?? 0) != 0
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: todoData.value?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 9.0),
                          child: CardToDoListWidget(getIndex: index),
                        ),
                      )
                    : Column(
                        children: [
                          Gap(130),
                          Image.asset("assets/to-do-list.png",
                              height: 250, color: Colors.grey.shade500),
                          Gap(25),
                          Text("No tasks to do ",
                              style: TextStyle(
                                  fontSize: 28, color: Colors.grey.shade500)),
                        ],
                      )
              ],
            ),
          ),
        ));
  }
}

//
// appBar: AppBar(
// backgroundColor: Colors.white,
// foregroundColor: Colors.black,
// elevation: 0,
// title: ListTile(
// leading: CircleAvatar(
// backgroundImage: AssetImage("assets/profile.jpg"),
// radius: 25,
// ),
// title: Text(
// "Hello",
// style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
// ),
// subtitle: Text(
// "Seif Salman",
// style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
// ),
// ),
// actions: [
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 20.0),
// child: Row(
// children: [
// IconButton(
// onPressed: () {},
// icon: Icon(CupertinoIcons.calendar),
// ),
// IconButton(
// onPressed: () {},
// icon: Icon(CupertinoIcons.bell),
// ),
// ],
// ),
// )
// ],
// ),
//

// body:
//
// SingleChildScrollView(
// padding: EdgeInsets.symmetric(horizontal: 30),
// child: Column(
// children: [
// SizedBox(
// height: 20,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// "Today's Task",
// style: TextStyle(
// fontSize: 20,
// fontWeight: FontWeight.bold,
// color: Colors.black),
// ),
// Text(
// "Wednesday, 20 Nov",
// style: TextStyle(color: Colors.grey),
// )
// ],
// ),
// ElevatedButton(
// style: ElevatedButton.styleFrom(
// backgroundColor: Color(0xFFD5E8FA),
// foregroundColor: Colors.blue.shade700,
// elevation: 0),
// onPressed: () => showModalBottomSheet(
// isScrollControlled: true,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(25),
// topRight: Radius.circular(25),
// ),
// ),
// context: context,
// builder: (context) => AddNewTaskModel(),
// ),
// child: Text(
// "+ New Task",
// ),
// )
// ],
// ),
// Gap(30),
// ListView.builder(
// physics: NeverScrollableScrollPhysics(),
// itemCount: 10,
// shrinkWrap: true,
// itemBuilder: (context,index) => Padding(
// padding: const EdgeInsets.symmetric(vertical: 10.0),
// child: CardToDoListWidget(),
// ),
// )
//
// ],
// ),
// )
