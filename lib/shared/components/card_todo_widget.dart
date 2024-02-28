import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/shared/provider/service_provider.dart';

import '../../styles/app_style.dart';

class CardToDoListWidget extends ConsumerWidget {
  const CardToDoListWidget({super.key, required this.getIndex});

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final todoData = ref.watch(fetchStreamProvider);
    return todoData.when(
        data: (todoData) {
          Color categoryColor = Colors.white;
          final getCategory = todoData[getIndex].category;
          switch (getCategory){
            case 'Learning':
              categoryColor = Colors.green;
              break;
              case 'Working':
              categoryColor = Colors.blue;
              break;
              case 'General':
              categoryColor = Colors.grey;
              break;
          }

          return Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
              height: MediaQuery.of(context).size.height*0.19,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: categoryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12))),
                    width: 22,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(todoData[getIndex].titleTask,
                                style:
                                Theme.of(context).textTheme.titleLarge!.copyWith(decoration: todoData[getIndex].isDone ? TextDecoration.lineThrough : null )
                            ),
                            subtitle: Text(todoData[getIndex].description,maxLines: 2,overflow: TextOverflow.fade,style:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(decoration: todoData[getIndex].isDone ? TextDecoration.lineThrough : null )

                            ),
                            trailing: Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                activeColor: Colors.blue,
                                shape: CircleBorder(),
                                value: todoData[getIndex].isDone,
                                onChanged: (value) => ref.read(serviceProvider).updateTask(todoData[getIndex].docID, value),
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(0,-6),
                            child: Container(
                              child: Column(
                                children: [
                                  Divider(
                                    thickness: 1.5,
                                    color: Colors.grey.shade300,
                                  ),
                                  Gap(6),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("Today",style:  Theme.of(context).textTheme.titleMedium),
                                      Gap(10),
                                      Text(todoData[getIndex].timeTask,style:  Theme.of(context).textTheme.titleSmall),
                                      Spacer(),
                                      InkWell(
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
                                                      Text("You will delete this task."),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text("Yes"),
                                                    onPressed: () {
                                                      ref.read(serviceProvider).deleteTask(todoData[getIndex].docID);
                                                      Navigator.pop(context);
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
                                        child: Icon(CupertinoIcons.delete,color: Colors.red,)),
                                      Gap(12)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
        },
        error: (error,stackTrace) => Center(child: Container(color: Colors.blue,width: 300,height: 400,)),
        loading: ()=> Center(child: CircularProgressIndicator()));
  }
}

//
//
// Container(
// decoration: BoxDecoration(
// color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
// height: 130,
// width: double.infinity,
// child: Row(
// children: [
// Container(
// decoration: BoxDecoration(
// color: Colors.green,
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(12),
// bottomLeft: Radius.circular(12))),
// width: 20,
// ),
// Expanded(
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 20.0),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// ListTile(
//
// contentPadding: EdgeInsets.zero,
// title: Text("Learning Flutter",style: AppStyle.headingOne),
// subtitle: Text("Learning rivepod and making todo app",style: TextStyle(fontSize: 13,color: Colors.grey,fontWeight: FontWeight.w200)),
// trailing: Transform.scale(
// scale: 1.5,
// child: Checkbox(
// activeColor: Colors.blue,
// shape: CircleBorder(),
// value: true,
// onChanged: (value) => print(value),
// ),
// ),
// ),
// Transform.translate(
// offset: Offset(0,-6),
// child: Container(
// child: Column(
// children: [
// Divider(
// thickness: 1.5,
// color: Colors.grey.shade300,
// ),
// Row(
// children: [
// Text("Today",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black)),
// Gap(12),
// Text("09:15PM - 11:45PM",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.grey.shade500))
// ],
// ),
// ],
// ),
// ),
// )
// ],
// ),
// ),
// )
// ],
// ),
// );
