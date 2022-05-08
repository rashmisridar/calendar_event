import 'package:atem_interview/utils/coonst_color.dart';
import 'package:flutter/material.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../utils/coonst_string.dart';
import '../../utils/custom_style/custom_text_style.dart';
import '../../utils/custom_style/progress_indicator.dart';
import 'calendar_event_page.dart';
import 'event_provider.dart';

/*late DeviceCalendarPlugin _deviceCalendarPlugin;
List<Calendar> _calendars = [];

List<Calendar> get _writableCalendars =>
    _calendars.where((c) => c.isReadOnly == false).toList();

List<Calendar> get _readOnlyCalendars =>
    _calendars.where((c) => c.isReadOnly == true).toList();*/

_CalendarsPageState() {
  // _deviceCalendarPlugin = DeviceCalendarPlugin();
}

class CalendarNames extends StatelessWidget {
  const CalendarNames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calendarList = Provider.of<EventProvider>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: CoonstColor.blue,
          title: Text(
            CoonstString.calendarEvents,
            style: CustomTextStyle()
                .fontSizeNormal(CoonstColor.white, FontWeight.w500, 20),
          ),
        ),
        body: FutureBuilder(
            future: calendarList.getAllData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemCount: (snapshot.data as List<dynamic>).length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        await Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return CalendarEventPage(
                              calendarPage:
                                  (snapshot.data as List<dynamic>)[index]);
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                snapshot.data[index].name,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(snapshot.data[index].color!)),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent)),
                              child: const Text('Default'),
                            ),
                            Icon(snapshot.data[index].isReadOnly == true
                                ? Icons.lock
                                : Icons.lock_open)
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Indicator().progressIndicator();
              } else {
                return Text(CoonstString.wentWrong);
              }
            }));
  }
}
