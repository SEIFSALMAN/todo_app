import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/shared/provider/radio_provider.dart';

class RadioTileWidget extends ConsumerWidget {
  const RadioTileWidget(
      {super.key,
      required this.categoryColor,
      required this.titleRadio,
      required this.selectedOption,
      required this.onChangedValue,
      required this.option});

  final String titleRadio;
  final Color categoryColor;
  final int selectedOption;
  final int option;
  final void Function(int?) onChangedValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radio = ref.watch(radioProvider);
    return Material(
      color: Theme.of(context).dialogBackgroundColor,
      child: Theme(
        data: ThemeData(unselectedWidgetColor: categoryColor),
        child: RadioListTile(
          contentPadding: EdgeInsets.zero,
          activeColor: categoryColor,
          title: Transform.translate(
            offset: Offset(-22, 0),
            child: Text(
              titleRadio,
              style: TextStyle(
                  color: categoryColor, fontWeight: FontWeight.w700,fontSize: 11),
            ),
          ),
          value: option,
          groupValue: selectedOption,
          onChanged: onChangedValue
        ),
      ),
    );
  }
}
