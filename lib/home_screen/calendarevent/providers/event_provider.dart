import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/services.dart';

class EventProvider with ChangeNotifier {
  EventProvider() {
    _deviceCalendarPlugin = DeviceCalendarPlugin();

    fetchEventList();
  }
  DeviceCalendarPlugin? _deviceCalendarPlugin;

  List _eventList = List.empty(growable: true);
  //Calendar? _calendarsData;

  Future getAllData() async {
    _eventList = _eventList;
    return _eventList;
  }

  void setEventList(eventList) {
    _eventList = eventList;
    notifyListeners();
  }

  Future<dynamic> fetchEventList() async {
    /*var permissionsGranted = await _deviceCalendarPlugin!.hasPermissions();
      if (permissionsGranted.isSuccess &&
          (permissionsGranted.data == null ||
              permissionsGranted.data == false)) {
        permissionsGranted = await _deviceCalendarPlugin!.requestPermissions();
        if (!permissionsGranted.isSuccess ||
            permissionsGranted.data == null ||
            permissionsGranted.data == false) {
          return;
        }
      }*/
    try {
      var permissionsGranted = await _deviceCalendarPlugin!.hasPermissions();
      if (permissionsGranted.isSuccess && !permissionsGranted.data!) {
        permissionsGranted = await _deviceCalendarPlugin!.requestPermissions();
        if (permissionsGranted.isSuccess) {
          final calendarsResult =
              await _deviceCalendarPlugin!.retrieveCalendars();
          _eventList = calendarsResult.data!;

          setEventList(_eventList);
        }
        if (!permissionsGranted.isSuccess || permissionsGranted.data!) {
          return;
        }
      } else if (permissionsGranted.isSuccess && permissionsGranted.data!) {
        final calendarsResult =
            await _deviceCalendarPlugin!.retrieveCalendars();
        _eventList = calendarsResult.data!;

        setEventList(_eventList);
      }
    } catch (e) {
      print("exceptin $e");
    }

    return _eventList;
  }
}
