import 'package:atem_interview/utils/coonst_color.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../utils/custom_style/progress_indicator.dart';
import '../product/product_provider.dart';
import 'providers/calendar_event_provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class CalendarEventPage extends StatelessWidget {
  final Calendar? calendarPage;
  const CalendarEventPage({
    Key? key,
    @required this.calendarPage,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final calendarEventList = Provider.of<CalendarEventProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('${calendarPage!.name} events'),
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: FutureBuilder(
                future: calendarEventList.retrieveEvents(calendarPage!.id),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.data != null &&
                      (snapshot.data as List<dynamic>).length > 0) {
                    return calenderWidget(snapshot.data);
                  } else if (snapshot.data != null &&
                      (snapshot.data as List<dynamic>).length == 0) {
                    return Center(child: Text('No events found'));
                  } else {
                    return Indicator().progressIndicator();
                  }
                }),
          ),
        ));
  }

  Widget calenderWidget(List data) {
    return SfCalendar(
      allowViewNavigation: true,
      initialDisplayDate: DateTime.now(),
      todayHighlightColor: CoonstColor.green,
      monthViewSettings: const MonthViewSettings(
          // showAgenda: true,
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          navigationDirection: MonthNavigationDirection.vertical),
      view: CalendarView.month,
      dataSource: MeetingDataSource(_getDataSource(data)),
      // by default the month appointment display mode set as Indicator, we can
      // change the display mode as appointment using the appointment display
      // mode property
      /* monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),*/
    );
  }

  List<Meeting> _getDataSource(List data) {
    List<Event> eventList = List.from(data);
    final List<Meeting> meetings = <Meeting>[];

    // final startDate = DateTime.now().add(Duration(days: -30));
    //final endDate = DateTime.now().add(Duration(days: 30));
    if (eventList != null && eventList.length > 0) {
      for (int i = 0; i < eventList.length; i++) {
        tz.TZDateTime startEvent = eventList[i].start!;
        tz.TZDateTime endEvent = eventList[i].end!;

        final DateTime startTime = DateTime(
            startEvent.year,
            startEvent.month,
            startEvent.day,
            startEvent.hour,
            startEvent.minute,
            startEvent.second);

        final DateTime endTime = DateTime(endEvent.year, endEvent.month,
            endEvent.day, endEvent.hour, endEvent.minute, endEvent.second);
        meetings.add(Meeting('${eventList[i].title}', startTime, endTime,
            CoonstColor.blue, false));
      }
    }

    return meetings;
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
