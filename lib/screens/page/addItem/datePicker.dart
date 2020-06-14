import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDate;
  DateTime firstDate = DateTime(2015, 8);
  DateTime lastDate = DateTime(2101);
  
  
  @override
  void initState(){
    selectedDate=DateTime.now();
    super.initState();
  }

  DateTime getSelectedDate() {
    return selectedDate;
    }

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      confirmText: 'OK',
      cancelText: '',
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Container(
          height: 300,
          width: 300,
          child: Column(
            children: [
              RaisedButton(
                onPressed: () => selectDate(context),
                // onPressed: () {
                //   setState(() {
                //     buildDayPicker(
                //         selectedDate, firstDate, lastDate, (value) {});
                //   });
                // },
                child: Text('Select date'),
              ),
              Text(getSelectedDate().toString())
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDayPicker(DateTime selectedDate, DateTime firstDate,
      DateTime lastDate, ValueChanged<DatePeriod> onNewSelected) {
    DatePickerRangeStyles styles = DatePickerRangeStyles(
      selectedPeriodLastDecoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0))),
      selectedPeriodStartDecoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
      ),
      selectedPeriodMiddleDecoration:
          BoxDecoration(color: Colors.yellow, shape: BoxShape.rectangle),
    );
    print('test');

    return WeekPicker(
        selectedDate: selectedDate,
        onChanged: onNewSelected,
        firstDate: firstDate,
        lastDate: lastDate,
        datePickerStyles: styles);
  }
}
