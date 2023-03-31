import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/components_sc2023/quiz_choice/quiz_choice_widget.dart';
import '/components_sc2023/quiz_short_answer/quiz_short_answer_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sc_u_quiz_model.dart';
export 'sc_u_quiz_model.dart';

class ScUQuizWidget extends StatefulWidget {
  const ScUQuizWidget({
    Key? key,
    this.courseName,
    this.courseIndexTitle,
    this.contentID,
    this.courseIndexRef,
  }) : super(key: key);

  final String? courseName;
  final String? courseIndexTitle;
  final String? contentID;
  final DocumentReference? courseIndexRef;

  @override
  _ScUQuizWidgetState createState() => _ScUQuizWidgetState();
}

class _ScUQuizWidgetState extends State<ScUQuizWidget> {
  late ScUQuizModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScUQuizModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'sc_u_Quiz'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('SC_U_QUIZ_PAGE_sc_u_Quiz_ON_PAGE_LOAD');
      logFirebaseEvent('sc_u_Quiz_backend_call');

      final courseIndexUpdateData = createCourseIndexRecordData(
        viewedAt: getCurrentTimestamp,
      );
      await widget.courseIndexRef!.update(courseIndexUpdateData);
    });
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          widget.courseIndexTitle!,
          style: FlutterFlowTheme.of(context).subtitle1,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: StreamBuilder<List<CourseContentRecord>>(
          stream: queryCourseContentRecord(
            queryBuilder: (courseContentRecord) =>
                courseContentRecord.where('id', isEqualTo: widget.contentID),
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
            List<CourseContentRecord> columnCourseContentRecordList =
                snapshot.data!;
            final columnCourseContentRecord =
                columnCourseContentRecordList.isNotEmpty
                    ? columnCourseContentRecordList.first
                    : null;
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final quizArray = columnCourseContentRecord!.quizArray!
                          .toList()
                          .map((e) => e)
                          .toList();
                      return Container(
                        width: double.infinity,
                        height: 500.0,
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 50.0),
                              child: PageView.builder(
                                controller: _model.pageViewController ??=
                                    PageController(
                                        initialPage:
                                            min(0, quizArray.length - 1)),
                                scrollDirection: Axis.horizontal,
                                itemCount: quizArray.length,
                                itemBuilder: (context, quizArrayIndex) {
                                  final quizArrayItem =
                                      quizArray[quizArrayIndex];
                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (quizArrayItem.type == 'choices')
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      28.0, 28.0, 28.0, 28.0),
                                              child: Text(
                                                quizArrayItem
                                                    .quizChoice!.question!,
                                                textAlign: TextAlign.center,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          fontSize: 20.0,
                                                        ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1.0,
                                              decoration: BoxDecoration(),
                                              child: QuizChoiceWidget(
                                                key: Key(
                                                    'Keyros_${quizArrayIndex}_of_${quizArray.length}'),
                                                answer: quizArrayItem
                                                    .quizChoice?.answer,
                                                choices: quizArrayItem
                                                    .quizChoice?.choices
                                                    ?.toList()
                                                    ?.toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      if (quizArrayItem.type == 'shortAnswer')
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                28.0,
                                                                28.0,
                                                                28.0,
                                                                28.0),
                                                    child: Text(
                                                      quizArrayItem.quizChoice!
                                                          .question!,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Outfit',
                                                                fontSize: 20.0,
                                                              ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            1.0,
                                                    decoration: BoxDecoration(),
                                                    child:
                                                        QuizShortAnswerWidget(
                                                      key: Key(
                                                          'Keye47_${quizArrayIndex}_of_${quizArray.length}'),
                                                      answer: quizArrayItem
                                                          .quizShortAnswer
                                                          ?.answer,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 28.0),
                                                child: FFButtonWidget(
                                                  onPressed: () async {
                                                    logFirebaseEvent(
                                                        'SC_U_QUIZ_PAGE_ShowAnswerButton_ON_TAP');
                                                    logFirebaseEvent(
                                                        'ShowAnswerButton_alert_dialog');
                                                    await showDialog(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: Text('Answer'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext),
                                                              child: Text('Ok'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  text: 'Show Answer',
                                                  options: FFButtonOptions(
                                                    width: 130.0,
                                                    height: 40.0,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .tertiaryColor,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily: 'Outfit',
                                                          color: Colors.white,
                                                        ),
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 10.0),
                                child:
                                    smooth_page_indicator.SmoothPageIndicator(
                                  controller: _model.pageViewController ??=
                                      PageController(
                                          initialPage:
                                              min(0, quizArray.length - 1)),
                                  count: quizArray.length,
                                  axisDirection: Axis.horizontal,
                                  onDotClicked: (i) {
                                    _model.pageViewController!.animateToPage(
                                      i,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  },
                                  effect:
                                      smooth_page_indicator.ExpandingDotsEffect(
                                    expansionFactor: 2.0,
                                    spacing: 8.0,
                                    radius: 16.0,
                                    dotWidth: 16.0,
                                    dotHeight: 16.0,
                                    dotColor: Color(0xFF9E9E9E),
                                    activeDotColor: Color(0xFF3F51B5),
                                    paintStyle: PaintingStyle.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
