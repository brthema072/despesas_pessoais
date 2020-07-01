import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {

  final DateTime selectedDate;
  final Function (DateTime) onDateChanged;

  AdaptativeDatePicker({
    this.selectedDate,
    this.onDateChanged,
  });

  _showDatePicker(BuildContext context){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pikedDate) {

      if(pikedDate == DateTime.now()){
        return;
      }

      onDateChanged(pikedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS 
    ? Container(
        height: 180,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: DateTime.now(),
          minimumDate: DateTime(2019),
          maximumDate: DateTime.now(),
          onDateTimeChanged: onDateChanged,
        ),
    )
    : Container(
        height: 70,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Icon(Icons.calendar_today),
                  Text(
                    selectedDate == DateTime.now()
                    ? '${DateFormat('dd/MM/y').format(DateTime.now())}'
                    : DateFormat('dd/MM/y').format(selectedDate), 
                  ),
                ],
              ),
            ),
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              child: Text(
                'Selecionar data.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => _showDatePicker(context),
            )
          ],
        ),
      );
  }
}