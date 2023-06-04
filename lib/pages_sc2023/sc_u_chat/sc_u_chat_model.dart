import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/components_sc2023/edit_note/edit_note_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'api/chat_api.dart';

class ScUChatModel extends FlutterFlowModel {
  /// Initialization and disposal methods.
  List<String> lectureContentArray = [];

  void initState(BuildContext context) {}
  void initSpeech() async {}

  void dispose() {}

  /// Additional helper methods are added here.
}
