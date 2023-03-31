import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/components_sc2023/create_course_edit/create_course_edit_widget.dart';
import '/components_sc2023/create_course_new/create_course_new_widget.dart';
import '/components_sc2023/empty_list_course/empty_list_course_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages_sc2023/sc_u_course/sc_u_course_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sc_u_main_model.dart';
export 'sc_u_main_model.dart';

class ScUMainWidget extends StatefulWidget {
  const ScUMainWidget({Key? key}) : super(key: key);

  @override
  _ScUMainWidgetState createState() => _ScUMainWidgetState();
}

class _ScUMainWidgetState extends State<ScUMainWidget>
    with TickerProviderStateMixin {
  late ScUMainModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, 70.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScUMainModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'sc_u_Main'});
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          logFirebaseEvent('SC_U_MAIN_FloatingActionButton_9jdqd9f1_');
          logFirebaseEvent('FloatingActionButton_bottom_sheet');
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            barrierColor: Color(0x230E151B),
            enableDrag: false,
            context: context,
            builder: (context) {
              return SingleChildScrollView(
                  child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  height: MediaQuery.of(context).size.height * 1.0,
                  child: CreateCourseNewWidget(),
                ),
              ));
            },
          );
        },
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        elevation: 8.0,
        child: Icon(
          Icons.add_rounded,
          color: FlutterFlowTheme.of(context).white,
          size: 28.0,
        ),
      ),
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'My Courses',
          style: FlutterFlowTheme.of(context).title1.override(
                fontFamily: 'Outfit',
                color: FlutterFlowTheme.of(context).white,
              ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  height: 53.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: Image.asset(
                        'assets/images/waves@2x.png',
                      ).image,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Courses in participation',
                    style: FlutterFlowTheme.of(context).subtitle2,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                child: StreamBuilder<List<CourseRecord>>(
                  stream: queryCourseRecord(
                    queryBuilder: (courseRecord) => courseRecord.where('user',
                        isEqualTo: currentUserReference),
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50.0,
                          height: 50.0,
                          child: CircularProgressIndicator(
                            color: FlutterFlowTheme.of(context).primaryColor,
                          ),
                        ),
                      );
                    }
                    List<CourseRecord> listViewCourseRecordList =
                        snapshot.data!;
                    if (listViewCourseRecordList.isEmpty) {
                      return Center(
                        child: EmptyListCourseWidget(),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: listViewCourseRecordList.length,
                      itemBuilder: (context, listViewIndex) {
                        final listViewCourseRecord =
                            listViewCourseRecordList[listViewIndex];
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 8.0),
                          child: InkWell(
                            onTap: () async {
                              logFirebaseEvent(
                                  'SC_U_MAIN_PAGE_Container_hdi6bs49_ON_TAP');
                              logFirebaseEvent('Container_navigate_to');
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScUCourseWidget(
                                    cid: listViewCourseRecord.cid,
                                    courseName: listViewCourseRecord.courseName,
                                  ),
                                ),
                              );
                            },
                            onLongPress: () async {
                              logFirebaseEvent(
                                  'SC_U_MAIN_Container_hdi6bs49_ON_LONG_PRE');
                              logFirebaseEvent('Container_bottom_sheet');
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                enableDrag: false,
                                context: context,
                                builder: (context) {
                                  return SingleChildScrollView(
                                      child: Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              1.0,
                                      child: CreateCourseEditWidget(
                                        cid: listViewCourseRecord.cid,
                                        courseName:
                                            listViewCourseRecord.courseName,
                                        courseTutor:
                                            listViewCourseRecord.courseTutor,
                                        courseSchedule:
                                            listViewCourseRecord.courseSchedule,
                                        courseRef:
                                            listViewCourseRecord.reference,
                                      ),
                                    ),
                                  ));
                                },
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 1.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Color(0x230E151B),
                                    offset: Offset(0.0, 2.0),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 12.0, 0.0, 12.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            listViewCourseRecord.courseName!,
                                            maxLines: 1,
                                            style: FlutterFlowTheme.of(context)
                                                .title2,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 4.0, 0.0, 0.0),
                                                child: Text(
                                                  listViewCourseRecord
                                                      .courseTutor!,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .subtitle2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation']!),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
