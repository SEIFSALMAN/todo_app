import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/shared/components/radio_tile_widget.dart';
import 'package:todo_app/shared/cubits/unAuth_todo/un_auth_todo_cubit.dart';
import 'package:todo_app/shared/provider/date_time_provider.dart';
import 'package:todo_app/shared/provider/radio_provider.dart';
import 'package:todo_app/shared/provider/service_provider.dart';
import 'package:todo_app/styles/app_style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'date_time_widget.dart';
import 'input_textfield.dart';

class UnAuthAddNewTaskModel extends ConsumerStatefulWidget {
  const UnAuthAddNewTaskModel({super.key});

  @override
  _AddNewTaskModelState createState() => _AddNewTaskModelState();
}

class _AddNewTaskModelState extends ConsumerState<UnAuthAddNewTaskModel> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int selectedOption = 1;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final dateProv = ref.watch(dateProvider);
    final timeProv = ref.watch(timeProvider);

    return Container(
      padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
      height: MediaQuery
          .of(context)
          .size
          .height * 0.81,
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  "New Task",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).iconTheme.color
                  ),
                ),
              ),
              Divider(
                thickness: 1.2,
                color: Colors.grey.shade100,
              ),
              Gap(12),
              Text(
                "Title Task",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Theme.of(context).iconTheme.color),
              ),
              Gap(6),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please enter your title task";
                      } else {
                        return null;
                      }
                    },
                    maxLines: 1,
                    controller: titleController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 6),
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: "Add your task here.",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 15,
                        )),
                  )),
              Gap(20),
              Text(
                "Description",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Theme.of(context).iconTheme.color),
              ),
              Gap(6),
              InputTextField(descriptionController: descriptionController),
              Gap(20),
              Text(
                "Category",
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Theme.of(context).iconTheme.color),
              ),
              Gap(6),
              Row(
                children: [
                  Expanded(
                    flex: 11,
                    child: RadioTileWidget(categoryColor: Colors.green,
                      titleRadio: "LEARN",
                      selectedOption: selectedOption,
                      option: 1,
                      onChangedValue:(int? value) {
                        setState(() {
                          print(value);
                          selectedOption = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: RadioTileWidget(categoryColor: Colors.blue,
                      option: 2,
                      titleRadio: "WORK",
                      selectedOption: selectedOption,
                      onChangedValue:(int? value) {
                        setState(() {
                          print(value);
                          selectedOption = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    child: RadioTileWidget(categoryColor: Colors.grey,
                      option: 3,
                      titleRadio: "GENERAL",
                      selectedOption: selectedOption,
                      onChangedValue:(int? value) {
                        setState(() {
                          print(value);
                          selectedOption = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Gap(6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DateTimeWidget(
                    titleText: "Date",
                    valueText: dateProv,
                    icon: CupertinoIcons.calendar,
                    onTap: () async {
                      final getDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2039));

                      if (getDate != null) {
                        final format = DateFormat.yMd();
                        ref
                            .read(dateProvider.notifier)
                            .update((state) => format.format(getDate));
                      }
                    },
                  ),
                  Gap(25),
                  DateTimeWidget(
                    titleText: "Time",
                    valueText: timeProv,
                    icon: CupertinoIcons.time,
                    onTap: () async {
                      final getTime = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());

                      if (getTime != null) {
                        ref
                            .read(timeProvider.notifier)
                            .update((state) => getTime.format(context));
                      }
                    },
                  )
                ],
              ),
              Gap(15),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).dialogBackgroundColor,
                          foregroundColor: Colors.blue,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.blue),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14)),
                      onPressed: () => Navigator.pop(context),
                      child: Text("Cancel"),
                    ),
                  ),
                  Gap(20),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14)),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final getRadioValue = selectedOption;
                          String category = '';

                          switch (getRadioValue) {
                            case 0:
                              category = "Not Specified";
                              break;
                            case 1:
                              category = "Learning";
                              break;
                            case 2:
                              category = "Working";
                              break;
                            case 3:
                              category = "General";
                              break;
                          }

                          //Adding Task

                            UnAuthTodoCubit.get(context).insertToDoTasksToDatabase(
                                titleTask: titleController.text,
                                description: descriptionController.text,
                                category: category,
                                date: dateProv,time:timeProv);





                          print("Data is saving..");
                          Navigator.pop(context);
                        }
                      },
                      child: Text("Create"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
