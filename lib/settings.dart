import 'package:flutter/material.dart';
import 'widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Settings());
  }
}

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextStyle textStyle = TextStyle(fontSize: 20);
  TextEditingController txtWork = TextEditingController();
  TextEditingController txtShort = TextEditingController();
  TextEditingController txtLong = TextEditingController();
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  int workTime;
  int shortBreak;
  int longBreak;
  SharedPreferences prefs;
  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int workTime = prefs.getInt(WORKTIME);
    if (workTime == null) {
      await prefs.setInt(WORKTIME, 30);
    }
    int shortBreak = prefs.getInt(SHORTBREAK);
    if (shortBreak == null) {
      await prefs.setInt(SHORTBREAK, 5);
    }
    int longBreak = prefs.getInt(LONGBREAK);
    if (longBreak == null) {
      await prefs.setInt(LONGBREAK, 20);
    }
    setState(() {
      txtWork.text = workTime.toString();
      print(txtWork.text);

      txtShort.text = shortBreak.toString();
      print(txtShort.text);

      txtLong.text = longBreak.toString();
      print(txtLong.text);
    });
  }

  @override
  void initState() {
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void updateSettings(String key, int value) {
      switch (key) {
        case WORKTIME:
          workTime = prefs.getInt(WORKTIME);
          workTime += value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIME, workTime);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
          break;
        case SHORTBREAK:
          shortBreak = prefs.getInt(SHORTBREAK);
          shortBreak += value;
          if (shortBreak >= 1 && shortBreak <= 120) {
            prefs.setInt(SHORTBREAK, shortBreak);
            setState(() {
              txtShort.text = shortBreak.toString();
            });
          }
          break;
        case LONGBREAK:
          {
            int long = prefs.getInt(LONGBREAK);
            long += value;
            if (long >= 1 && long <= 180) {
              prefs.setInt(LONGBREAK, long);
              setState(() {
                txtLong.text = long.toString();
              });
            }
          }
          break;
      }
    }

    return Container(
        child: GridView.count(
      scrollDirection: Axis.vertical,
      crossAxisCount: 5,
      childAspectRatio: 3,
      crossAxisSpacing: 3,
      mainAxisSpacing: 20,
      children: <Widget>[
        Text("Work", style: textStyle),
        Text(""),
        Text(""),
        Text(""),
        Text(""),
        SettingsButton(Color(0xff455A64), "-10", -10, WORKTIME, updateSettings),
        SettingsButton(Color(0xff455A64), "-", -1, WORKTIME, updateSettings),
        TextField(
            readOnly: true,
            controller: txtWork,
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),
        SettingsButton(Color(0xff009688), "+", 1, WORKTIME, updateSettings),
        SettingsButton(Color(0xff455A64), "+10", 10, WORKTIME, updateSettings),
        Text("Short", style: textStyle),
        Text(""),
        Text(""),
        Text(""),
        Text(""),
        SettingsButton(
            Color(0xff455A64), "-10", -10, SHORTBREAK, updateSettings),
        SettingsButton(Color(0xff455A64), "-", -1, SHORTBREAK, updateSettings),
        TextField(
            readOnly: true,
            controller: txtShort,
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),
        SettingsButton(Color(0xff009688), "+", 1, SHORTBREAK, updateSettings),
        SettingsButton(
            Color(0xff455A64), "+10", 10, SHORTBREAK, updateSettings),
        Text(
          "Long",
          style: textStyle,
        ),
        Text(""),
        Text(""),
        Text(""),
        Text(""),
        SettingsButton(
            Color(0xff455A64), "-10", -10, LONGBREAK, updateSettings),
        SettingsButton(Color(0xff455A64), "-", -1, LONGBREAK, updateSettings),
        TextField(
            readOnly: true,
            controller: txtLong,
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),
        SettingsButton(Color(0xff009688), "+", 1, LONGBREAK, updateSettings),
        SettingsButton(Color(0xff455A64), "+10", 10, LONGBREAK, updateSettings),
      ],
      padding: const EdgeInsets.all(20.0),
    ));
  }
}
