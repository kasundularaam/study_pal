import 'dart:developer';

import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:study_pal/data/models/add_mod_eve_cal_cu_model.dart';
import 'package:study_pal/data/models/cal_event_modle.dart';
import 'package:study_pal/data/repositories/firebase_repo/firebase_cal_repo.dart';
import 'package:url_launcher/url_launcher.dart';

class CalandarRepo {
  static const scopes = const [CalendarApi.calendarScope];
  static const clId =
      "571275540498-sqd60o24nneq5u5id8e9s0rdb29uq6rd.apps.googleusercontent.com";
  static Future<String?> addEventForAContent({required Event event}) async {
    try {
      var clientId = new ClientId(clId, "");
      AuthClient authClient =
          await clientViaUserConsent(clientId, scopes, userPrompt);
      var calendar = CalendarApi(authClient);
      CalendarList calendarList = await calendar.calendarList.list();
      print("CALENDAR LIST: $calendarList");
      String calendarId = "primary";
      Event returningEvent = await calendar.events.insert(event, calendarId);
      if (returningEvent.status == "confirmed") {
        log('Event added in google calendar');
        return returningEvent.id;
      } else {
        log("Unable to add event in google calendar");
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<void> addModEveToCal(
      {required List<Event> events,
      required AddModEveCalCuMod addModEveCalCuMod,
      required DateTime selectedDateTime}) async {
    try {
      var clientId = new ClientId(clId, "");
      AuthClient authClient =
          await clientViaUserConsent(clientId, scopes, userPrompt);
      var calendar = CalendarApi(authClient);
      CalendarList calendarList = await calendar.calendarList.list();
      print("CALENDAR LIST: $calendarList");
      String calendarId = "primary";

      int weekIntForFire = 1;
      int indexForFire = 0;

      events.forEach((singleEvent) async {
        Event addedEvent =
            await calendar.events.insert(singleEvent, calendarId);
        if (addedEvent.status == "confirmed") {
          log('Event added in google calendar');

          String titleForFire =
              "${addModEveCalCuMod.subjectName} > ${addModEveCalCuMod.moduleName} | week $weekIntForFire";
          int timeForFire = selectedDateTime
              .add(
                Duration(
                  days: (7 * indexForFire),
                ),
              )
              .millisecondsSinceEpoch;

          await FirebaseCalRepo.addEventToCal(
            calEvent: CalEvent(
              id: addedEvent.id!,
              title: titleForFire,
              time: timeForFire,
              type: "module",
              subjectId: addModEveCalCuMod.subjectId,
              subjectName: addModEveCalCuMod.subjectName,
              moduleId: addModEveCalCuMod.moduleId,
              moduleName: addModEveCalCuMod.moduleName,
              contentId: "",
              contentName: "",
            ),
          );

          weekIntForFire++;
          indexForFire++;
        } else {
          log("Unable to add event in google calendar");
        }
      });
    } catch (e) {
      throw e;
    }
  }

  static void userPrompt(String url) async {
    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
