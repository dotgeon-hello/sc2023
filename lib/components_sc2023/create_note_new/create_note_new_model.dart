import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages_sc2023/sc_u_note_write/sc_u_note_write_widget.dart';
import 'dart:ui';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateNoteNewModel extends FlutterFlowModel {
  ///  Local state fields for this component.

  String? contentId = '';

  ///  State fields for stateful widgets in this component.

  // State field(s) for NoteName widget.
  TextEditingController? noteNameController;
  String? Function(BuildContext, String?)? noteNameControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    noteNameController?.dispose();
  }

  /// Additional helper methods are added here.

}
