import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:study_pal/core/constants/my_colors.dart';
import 'package:study_pal/data/models/cal_event_modle.dart';
import 'package:study_pal/logic/cubit/show_cal_events_cubit/show_cal_events_cubit.dart';
import 'package:study_pal/presentation/router/app_router.dart';
import 'package:study_pal/presentation/screens/widgets/error_msg_box.dart';
import 'package:study_pal/presentation/screens/widgets/event_card.dart';
import 'package:study_pal/presentation/screens/widgets/my_text_field.dart';
import 'package:study_pal/presentation/templates/home_tabs_tmpl.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({Key? key}) : super(key: key);

  @override
  _EventsTabState createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ShowCalEventsCubit>(context).loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return HomeTabsTmpl(
      title: "Events",
      action: GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppRouter.newEventScreen),
        child: Icon(
          Icons.add_alert_rounded,
          color: MyColors.secondaryColor,
          size: 22.sp,
        ),
      ),
      content: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 10.h,
            ),
            MyTextField(
              onChanged: (text) => BlocProvider.of<ShowCalEventsCubit>(context)
                  .searchEvents(searchText: text),
              onSubmitted: (text) {},
              textInputAction: TextInputAction.search,
              isPassword: false,
              hintText: "Find event",
              textColor: MyColors.lightColor,
              bgColor: MyColors.primaryColor.withOpacity(0.9),
            ),
            SizedBox(
              height: 3.h,
            ),
            BlocBuilder<ShowCalEventsCubit, ShowCalEventsState>(
              builder: (context, state) {
                if (state is ShowCalEventsInitial) {
                  return Center(child: Text("Initial Event"));
                } else if (state is ShowCalEventsLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: MyColors.progressColor,
                    ),
                  );
                } else if (state is ShowCalEventsLoaded) {
                  return ListView.builder(
                    padding: EdgeInsets.all(0),
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.calEvents.length,
                    itemBuilder: (BuildContext context, int index) {
                      CalEvent calEvent = state.calEvents[index];
                      return EventCard(
                          onLongPress: (eventId) {
                            showModalBottomSheet(
                                context: context,
                                builder: (bottomSheetContext) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(bottomSheetContext);
                                          BlocProvider.of<ShowCalEventsCubit>(
                                                  context)
                                              .deleteEvent(eventId: eventId);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w, vertical: 1.2.h),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3.h),
                                              color: MyColors.primaryColor
                                                  .withOpacity(0.1)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.delete_rounded,
                                                color: MyColors.rRed,
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Text(
                                                "Delete",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: MyColors.darkColor,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                    ],
                                  );
                                });
                          },
                          calEvent: calEvent);
                    },
                  );
                } else if (state is ShowCalEventsFailed) {
                  return Center(
                    child: ErrorMsgBox(
                      errorMsg: state.errorMsg,
                    ),
                  );
                } else if (state is ShowCalEventsNoResult) {
                  return Center(
                    child: ErrorMsgBox(
                      errorMsg: state.message,
                    ),
                  );
                } else {
                  return Center(
                      child:
                          ErrorMsgBox(errorMsg: "unhandled state excecuted!"));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
