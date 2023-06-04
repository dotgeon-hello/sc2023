import '/backend/backend.dart';
import '/components_sc2023/create_note_edit/create_note_edit_widget.dart';
import '/components_sc2023/create_note_new/create_note_new_widget.dart';
import '/components_sc2023/empty_list_course_index/empty_list_course_index_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages_sc2023/sc_u_note_read/sc_u_note_read_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sc_u_course_model.dart';
export 'sc_u_course_model.dart';

import '/pages_sc2023/sc_u_chat/sc_u_chat_widget.dart';

class ScUCourseWidget extends StatefulWidget {
  const ScUCourseWidget({
    Key? key,
    this.cid,
    this.courseName,
  }) : super(key: key);

  final String? cid;
  final String? courseName;

  @override
  _ScUCourseWidgetState createState() => _ScUCourseWidgetState();
}

class _ScUCourseWidgetState extends State<ScUCourseWidget>
    with TickerProviderStateMixin {
  late ScUCourseModel _model;

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
    _model = createModel(context, () => ScUCourseModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'sc_u_Course'});
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
          logFirebaseEvent('SC_U_COURSE_FloatingActionButton_6781pve');
          logFirebaseEvent('FloatingActionButton_bottom_sheet');
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            barrierColor: Color(0x230E151B),
            context: context,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  height: MediaQuery.of(context).size.height * 1.0,
                  child: CreateNoteNewWidget(
                    cid: widget.cid,
                    courseName: widget.courseName,
                  ),
                ),
              );
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
        automaticallyImplyLeading: true,
        title: StreamBuilder<List<CourseRecord>>(
          stream: queryCourseRecord(
            singleRecord: true,
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
            List<CourseRecord> textCourseRecordList = snapshot.data!;
            // Return an empty Container when the item does not exist.
            if (snapshot.data!.isEmpty) {
              return Container();
            }
            final textCourseRecord = textCourseRecordList.isNotEmpty
                ? textCourseRecordList.first
                : null;
            return Text(
              valueOrDefault<String>(
                widget.courseName,
                'undefined',
              ),
              style: FlutterFlowTheme.of(context).title2.override(
                    fontFamily: 'Outfit',
                    color: FlutterFlowTheme.of(context).white,
                  ),
            );
          },
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
                    'Lectures',
                    style: FlutterFlowTheme.of(context).subtitle2,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                child: StreamBuilder<List<CourseIndexRecord>>(
                  stream: queryCourseIndexRecord(
                    queryBuilder: (courseIndexRecord) => courseIndexRecord
                        .where('cid', isEqualTo: widget.cid)
                        .orderBy('createdAt'),
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
                    List<CourseIndexRecord> listViewCourseIndexRecordList =
                        snapshot.data!;
                    if (listViewCourseIndexRecordList.isEmpty) {
                      return Center(
                        child: EmptyListCourseIndexWidget(
                          cid: widget.cid,
                          courseName: widget.courseName,
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: listViewCourseIndexRecordList.length,
                      itemBuilder: (context, listViewIndex) {
                        final listViewCourseIndexRecord =
                            listViewCourseIndexRecordList[listViewIndex];
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 8.0),
                          child: InkWell(
                            onTap: () async {
                              logFirebaseEvent(
                                  'SC_U_COURSE_Container_f2t4xczc_ON_TAP');
                              logFirebaseEvent('Container_navigate_to');
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ScUNoteReadWidget(
                                    courseName: widget.courseName,
                                    courseIndexTitle:
                                        listViewCourseIndexRecord.title,
                                    contentID:
                                        listViewCourseIndexRecord.contentId,
                                    courseIndexRef:
                                        listViewCourseIndexRecord.reference,
                                    contentMediaURL: listViewCourseIndexRecord
                                        .contentMediaURL,
                                  ),
                                ),
                              );
                            },
                            onLongPress: () async {
                              logFirebaseEvent(
                                  'SC_U_COURSE_Container_f2t4xczc_ON_LONG_P');
                              logFirebaseEvent('Container_bottom_sheet');
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                enableDrag: false,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: CreateNoteEditWidget(
                                      title: listViewCourseIndexRecord.title,
                                      courseIndexRef:
                                          listViewCourseIndexRecord.reference,
                                    ),
                                  );
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
                                            listViewCourseIndexRecord.title!,
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
                                                  dateTimeFormat(
                                                      "d MMM y",
                                                      listViewCourseIndexRecord
                                                          .createdAt!),
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
