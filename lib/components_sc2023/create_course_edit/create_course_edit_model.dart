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

class CreateCourseEditModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this component.

  // State field(s) for CourseName widget.
  TextEditingController? courseNameController;
  String? Function(BuildContext, String?)? courseNameControllerValidator;
  // State field(s) for ProfessorName widget.
  TextEditingController? professorNameController;
  String? Function(BuildContext, String?)? professorNameControllerValidator;
  // State field(s) for CheckboxGroup widget.
  List<String>? checkboxGroupValues;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    courseNameController?.dispose();
    professorNameController?.dispose();
  }

  /// Additional helper methods are added here.

}
