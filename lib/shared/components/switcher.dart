import 'package:flutter/material.dart';

import '../cubits/appMode/app_mode_cubit.dart';


class DarkLightSwitcher extends StatefulWidget {


  @override
  State<DarkLightSwitcher> createState() => _DarkLightSwitcherState();
}

class _DarkLightSwitcherState extends State<DarkLightSwitcher> {

  @override
  Widget build(BuildContext context) {
    bool light = AppModeCubit.get(context).isDarkMode!;
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: Colors.blue[500],
      // Remove comment when use material3
       inactiveThumbColor: Colors.black,
       inactiveTrackColor: Colors.white,
      onChanged: (bool value) {
        setState(() {
          AppModeCubit.get(context).changeAppMode();
          light = value;
        });
      },
    );
  }
}
