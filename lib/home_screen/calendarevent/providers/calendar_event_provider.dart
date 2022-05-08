import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';

class CalendarEventProvider with ChangeNotifier {
  String? calendarId;
  CalendarEventProvider() {
    _deviceCalendarPlugin = DeviceCalendarPlugin();
  }
  DeviceCalendarPlugin? _deviceCalendarPlugin;

  List<dynamic> _eventList = List.empty(growable: true);

  Future<List<dynamic>> retrieveEvents(String? id) {
    return _retrieveCalendarEvents(id);
  }

  void setEventList(eventList) {
    _eventList = eventList;
    notifyListeners();
  }

  Future<List<dynamic>> _retrieveCalendarEvents(String? id) async {
    DateTime currentDateTime = DateTime.now();
    DateTime startDate = DateTime(
        currentDateTime.year,
        currentDateTime.month - 6,
        currentDateTime.day,
        currentDateTime.hour,
        currentDateTime.minute);
    DateTime endDate = DateTime(currentDateTime.year, currentDateTime.month + 6,
        currentDateTime.day, currentDateTime.hour, currentDateTime.minute);
    var calendarEventsResult = await _deviceCalendarPlugin!.retrieveEvents(
        id, RetrieveEventsParams(startDate: startDate, endDate: endDate));
    if (calendarEventsResult.data != null) {
      _eventList = calendarEventsResult.data as List<Event>;
    }

    setEventList(_eventList);

    return _eventList;
  }
}
