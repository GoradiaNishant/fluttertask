import 'package:flutter/material.dart';
import 'package:fluttertask/main.dart';
import 'package:fluttertask/gridviewdemo.dart';

class DateTimeDemo extends StatefulWidget {
  var tittle;

  DateTimeDemo({this.tittle});

  @override
  _DateTimeDemoState createState() => _DateTimeDemoState();
}

class _DateTimeDemoState extends State<DateTimeDemo> {

  int _selectedIndex=1;
  DateTime datetime=DateTime(2022,12,11,11,20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tittle),
      ),
      body: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Date"),
                  ElevatedButton(
                    child: Text(datetime.year.toString()+"/"+datetime.month.toString()+"/"+datetime.day.toString()),
                    onPressed: ()async{
                      final date=await pickDate();
                      if(date==null) return;
                      setState(() => datetime=date);
                    },
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Time"),
                  ElevatedButton(
                    child: Text(datetime.hour.toString().padLeft(2,'0')+":"+datetime.minute.toString().padLeft(2,'0')),
                    onPressed: ()async{
                      final time=await pickTime();
                      if(time==null) return;
                      final newdate=DateTime(
                          datetime.year,
                          datetime.month,
                          datetime.day,
                          time.hour,
                          time.minute);
                      setState(() => datetime=newdate);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: datetime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100)
  );
  
  Future<TimeOfDay?> pickTime()=>showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: datetime.hour, minute: datetime.minute)
  );
}
