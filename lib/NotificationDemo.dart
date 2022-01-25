import 'package:flutter/material.dart';
import 'package:fluttertask/notificationservices.dart';

class NotificationDemo extends StatefulWidget {
  var tittle;
  NotificationDemo({Key? key,this.tittle}) : super(key: key);

  @override
  _NotificationDemoState createState() => _NotificationDemoState();
}

class _NotificationDemoState extends State<NotificationDemo> {

  DateTime datetime=DateTime(2022,12,11,11,20);

  @override
  void initState(){
    super.initState();
    NotificationServices.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.tittle),),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
           children: [

             const Text("Push Notification"),
             ElevatedButton(onPressed: (){
               NotificationServices.showNotification(
                   tittle: 'Flutter Task',
                   body: 'Drc Systems Tasks Push Notification',
                   payload: 'By Nishant'
               );
             }, child:const Text("Notify")),

             const Text("Scheduled Notification bt Date & Time"),
             ElevatedButton(
               child: Text(
                   datetime.year.toString()+"/"+datetime.month.toString()+"/"+datetime.day.toString()+" "+
                   datetime.hour.toString().padLeft(2,'0')+":"+datetime.minute.toString().padLeft(2,'0')),
               onPressed: ()async{
                 final date=await pickDate();
                 if(date==null) return;
                 setState(() => datetime=date);

                 final time=await pickTime();
                 if(time==null) return;
                 final newdate=DateTime(
                     datetime.year,
                     datetime.month,
                     datetime.day,
                     time.hour,
                     time.minute);
                 setState(() => datetime=newdate);

                 NotificationServices.showScheduledNotification(
                     tittle: 'Flutter Task',
                     body: 'Drc Systems Tasks Schedule Notification',
                     scheduledDate: datetime,
                     payload: 'By Nishant'
                 );
               },
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
