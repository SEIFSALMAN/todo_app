import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/components/unAuth_add_new_task_model.dart';
import 'package:todo_app/shared/cubits/unAuth_todo/un_auth_todo_cubit.dart';
import '../shared/components/add_new_task_model.dart';
import '../shared/components/build_unAuth_todo_widget.dart';
import '../shared/components/navigator.dart';
import '../shared/components/switcher.dart';
import 'authentication/login_view.dart';

class UnAuthUserHomeScreen extends StatelessWidget {
  const UnAuthUserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnAuthTodoCubit, UnAuthTodoState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var todoTasks = UnAuthTodoCubit.get(context).todoTasks;
        print(todoTasks);
        return Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Center(
                      child: Text(
                    "Task Tide",
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  )),
                ),
                ListTile(
                  title: const Text('Login'),
                  onTap: () {
                    AppNavigator.customNavigator(
                        context: context, screen: LoginView(), finish: false);
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
              ],
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: NestedScrollView(
             physics: (todoTasks.length) >= 4
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
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                      ),
                    );
                  },
                ),
                // pinned: (todoData.value?.length ?? 0) != 0 ? false : true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                floating: true,
                toolbarHeight: 70,
                snap: true,
                title: ListTile(
                  title: Transform.translate(
                    offset: Offset(-20, 0),
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
                      backgroundImage: AssetImage("assets/images/user.png"),
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
                          builder: (context) => UnAuthAddNewTaskModel(),
                        ),
                        child: Text(
                          "+ New Task",
                        ),
                      )
                    ],
                  ),
                  todoTasks.isNotEmpty
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: todoTasks.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 9.0),
                                child: buildTaskItem(todoTasks[index], context),
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
          ),
        );
      },
    );
  }
}
