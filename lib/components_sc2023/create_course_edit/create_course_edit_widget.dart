import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_checkbox_group.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'create_course_edit_model.dart';
export 'create_course_edit_model.dart';

class CreateCourseEditWidget extends StatefulWidget {
  const CreateCourseEditWidget({
    Key? key,
    this.cid,
    this.courseName,
    this.courseTutor,
    this.courseSchedule,
    this.courseRef,
  }) : super(key: key);

  final String? cid;
  final String? courseName;
  final String? courseTutor;
  final CourseScheduleStruct? courseSchedule;
  final DocumentReference? courseRef;

  @override
  _CreateCourseEditWidgetState createState() => _CreateCourseEditWidgetState();
}

class _CreateCourseEditWidgetState extends State<CreateCourseEditWidget> {
  late CreateCourseEditModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateCourseEditModel());

    _model.courseNameController ??=
        TextEditingController(text: widget.courseName);
    _model.professorNameController ??=
        TextEditingController(text: widget.courseTutor);
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4.0,
          sigmaY: 9.0,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xD60E151B),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                child: Container(
                  width: 60.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).lineColor,
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 7.0,
                        color: Color(0x5D000000),
                        offset: Offset(0.0, -2.0),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 20.0, 16.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Edit Course',
                                style: FlutterFlowTheme.of(context).title2,
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'CREATE_COURSE_EDIT_DELETE_BTN_ON_TAP');
                                  logFirebaseEvent('Button_backend_call');
                                  await widget.courseRef!.delete();
                                  logFirebaseEvent('Button_navigate_back');
                                  Navigator.pop(context);
                                },
                                text: 'Delete',
                                options: FFButtonOptions(
                                  width: 75.0,
                                  height: 30.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context)
                                      .tertiaryColor,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Outfit',
                                        color:
                                            FlutterFlowTheme.of(context).white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 4.0, 16.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Modify the details below to edit a course.',
                                style: FlutterFlowTheme.of(context).subtitle2,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 0.0),
                          child: TextFormField(
                            controller: _model.courseNameController,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Course Name',
                              labelStyle:
                                  FlutterFlowTheme.of(context).subtitle2,
                              hintText: 'Enter the course name here....',
                              hintStyle: FlutterFlowTheme.of(context).subtitle2,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                            ),
                            style: FlutterFlowTheme.of(context).bodyText1,
                            validator: _model.courseNameControllerValidator
                                .asValidator(context),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 16.0),
                          child: TextFormField(
                            controller: _model.professorNameController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Professor Name',
                              labelStyle:
                                  FlutterFlowTheme.of(context).subtitle2,
                              hintText: 'Enter the professor name here...',
                              hintStyle: FlutterFlowTheme.of(context).subtitle2,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                              fillColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                            ),
                            style: FlutterFlowTheme.of(context).bodyText1,
                            textAlign: TextAlign.start,
                            validator: _model.professorNameControllerValidator
                                .asValidator(context),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 4.0, 16.0, 4.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Course schedule',
                                style: FlutterFlowTheme.of(context).subtitle2,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.92,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: FlutterFlowCheckboxGroup(
                            initiallySelected: (bool monday,
                                    bool tuesday,
                                    bool wednesday,
                                    bool thursday,
                                    bool friday,
                                    bool saturday,
                                    bool sunday) {
                              return [
                                if (monday) "Monday",
                                if (tuesday) "Tuesday",
                                if (wednesday) "Wednesday",
                                if (thursday) "Thursday",
                                if (friday) "Friday",
                                if (saturday) "Saturday",
                                if (sunday) "Sunday"
                              ];
                            }(
                                widget.courseSchedule!.monday!,
                                widget.courseSchedule!.tuesday!,
                                widget.courseSchedule!.wednesday!,
                                widget.courseSchedule!.thursday!,
                                widget.courseSchedule!.friday!,
                                widget.courseSchedule!.saturday!,
                                widget.courseSchedule!.sunday!),
                            options: [
                              'Monday',
                              'Tuesday',
                              'Wednesday',
                              'Thursday',
                              'Friday',
                              'Saturday',
                              'Sunday'
                            ],
                            onChanged: (val) => setState(
                                () => _model.checkboxGroupValues = val),
                            activeColor:
                                FlutterFlowTheme.of(context).primaryColor,
                            checkColor: Colors.white,
                            checkboxBorderColor: Color(0xFF95A1AC),
                            textStyle: FlutterFlowTheme.of(context).bodyText1,
                            initialized: _model.checkboxGroupValues != null,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 16.0, 16.0, 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'CREATE_COURSE_EDIT_CANCEL_BTN_ON_TAP');
                                  logFirebaseEvent('Button_navigate_back');
                                  Navigator.pop(context);
                                },
                                text: 'Cancel',
                                options: FFButtonOptions(
                                  width: 110.0,
                                  height: 50.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  logFirebaseEvent(
                                      'CREATE_COURSE_EDIT_EDIT_COURSE_BTN_ON_TA');
                                  logFirebaseEvent('Button_backend_call');

                                  final courseUpdateData =
                                      createCourseRecordData(
                                    courseName:
                                        _model.courseNameController.text,
                                    courseTutor:
                                        _model.professorNameController.text,
                                    courseSchedule: createCourseScheduleStruct(
                                      monday: (List<String> list) {
                                        return list.contains("Monday");
                                      }(_model.checkboxGroupValues!.toList()),
                                      tuesday: (List<String> list) {
                                        return list.contains("Tuesday");
                                      }(_model.checkboxGroupValues!.toList()),
                                      wednesday: (List<String> list) {
                                        return list.contains("Wednesday");
                                      }(_model.checkboxGroupValues!.toList()),
                                      thursday: (List<String> list) {
                                        return list.contains("Thursday");
                                      }(_model.checkboxGroupValues!.toList()),
                                      friday: (List<String> list) {
                                        return list.contains("Friday");
                                      }(_model.checkboxGroupValues!.toList()),
                                      saturday: (List<String> list) {
                                        return list.contains("Saturday");
                                      }(_model.checkboxGroupValues!.toList()),
                                      sunday: (List<String> list) {
                                        return list.contains("Sunday");
                                      }(_model.checkboxGroupValues!.toList()),
                                      clearUnsetFields: false,
                                    ),
                                  );
                                  await widget.courseRef!
                                      .update(courseUpdateData);
                                  logFirebaseEvent('Button_navigate_back');
                                  Navigator.pop(context);
                                },
                                text: 'Edit Course',
                                options: FFButtonOptions(
                                  width: 170.0,
                                  height: 50.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .subtitle1
                                      .override(
                                        fontFamily: 'Outfit',
                                        color:
                                            FlutterFlowTheme.of(context).white,
                                      ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
