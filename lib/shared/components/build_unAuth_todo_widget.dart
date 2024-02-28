import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/cubits/unAuth_todo/un_auth_todo_cubit.dart';

Widget buildTaskItem(Map model, context) {
  Color categoryColor = Colors.white;
  final getCategory = model['category'];
  switch (getCategory) {
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
    height: 140,
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
                  title: Text(model['titleTask'],
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          decoration: (model['status'] != "false")
                              ? TextDecoration.lineThrough
                              : null)),
                  subtitle: Text(model['description'],
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          decoration: (model['status'] != "false")
                              ? TextDecoration.lineThrough
                              : null)),
                  trailing: Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      activeColor: Colors.blue,
                      checkColor: Colors.white,
                      shape: CircleBorder(),
                      value: (model['status'] == "false") ? false : true,
                      onChanged: (value) => (model['status'] == "false")
                          ? UnAuthTodoCubit.get(context)
                              .updateToDoTasksStatusData(
                                  status: 'done', id: model['id'])
                          : UnAuthTodoCubit.get(context)
                              .updateToDoTasksStatusData(
                                  status: 'false', id: model['id']),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -6),
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
                            Text("Today",
                                style: Theme.of(context).textTheme.titleMedium),
                            Gap(10),
                            Text(model['time'],
                                style:  Theme.of(context).textTheme.titleSmall),
                            Spacer(),
                            InkWell(
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Are you sure?"),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text(
                                                  "You will delete this task."),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("Yes"),
                                            onPressed: () {
                                              UnAuthTodoCubit.get(context)
                                                  .deleteToDoTasksData(
                                                      id: model['id']);
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TextButton(
                                            child: Text("No"),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Dismiss the Dialog
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Icon(
                                  CupertinoIcons.delete,
                                  color: Colors.red,
                                )),
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
}
