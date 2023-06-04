import 'package:google_speech/generated/google/cloud/speech/v1/cloud_speech.pb.dart'
    as cloud_speech;
import 'package:sc2023/flutter_flow/custom_functions.dart';
import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/components_sc2023/edit_note/edit_note_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
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

import 'package:pdfx/pdfx.dart';
import 'package:internet_file/internet_file.dart';

import 'sc_u_chat_model.dart';
export 'sc_u_chat_model.dart';

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:google_speech/google_speech.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sound_stream/sound_stream.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '/pages_sc2023/sc_u_chat/api/chat_api.dart';
import '/pages_sc2023/sc_u_chat/models/chat_message.dart';
import '/pages_sc2023/sc_u_chat/widgets/message_bubble.dart';
import '/pages_sc2023/sc_u_chat/widgets/message_composer.dart';

// final openAiApiKey = dotenv.env['OPENAI_API_KEY'];

class ScUChatWidget extends StatefulWidget {
  const ScUChatWidget({
    Key? key,
    this.courseName,
    this.courseIndexTitle,
    this.contentID,
  }) : super(key: key);

  final String? courseName;
  final String? courseIndexTitle;
  final String? contentID;

  @override
  _ScUChatWidgetState createState() => _ScUChatWidgetState();
}

class _ScUChatWidgetState extends State<ScUChatWidget> with TickerProviderStateMixin {
  late ScUChatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScUChatModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'sc_u_Chat'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  final _messages = <ChatMessage>[
    ChatMessage('Hello! How can I help you with your study?', false),
  ];
  var _awaitingResponse = false;

  @override
  Widget build(BuildContext context) {
    getLectureData();
    
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Chat',
          style: FlutterFlowTheme.of(context).subtitle1,
        ),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ..._messages.map(
                  (msg) => MessageBubble(
                    content: msg.content,
                    isUserMessage: msg.isUserMessage,
                  ),
                ),
              ],
            ),
          ),
          MessageComposer(
            onSubmitted: _onSubmitted,
            awaitingResponse: _awaitingResponse,
          ),
        ],
      ),
    );
  }

  Future<void> _onSubmitted(String message) async {
    setState(() {
      _messages.add(ChatMessage(message, true));
      _awaitingResponse = true;
    });
    try {
      await dotenv.load(fileName: ".env");
      final chatApiOpenAiKey = dotenv.env['OPENAI_API_KEY'] ?? '';

      final chatApi = ChatApi(chatApiOpenAiKey, dotenv.env['OPENAI_API_CHAT_TYPE'], dotenv.env['OPENAI_API_CHAT_MODEL']);
      final response = await chatApi.completeChat(_messages, _model.lectureContentArray);
      setState(() {
        _messages.add(ChatMessage(response, false));
        _awaitingResponse = false;
      });
    } catch (err) {
      // print error
      print(err);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')),
      );
      setState(() {
        _awaitingResponse = false;
      });
    }
  }

  Future<void> getLectureData() async {
    _model.lectureContentArray = [
      'Course Name: ' + widget.courseName!,
      'Lecture Title: ' + widget.courseIndexTitle!,
    ];

    queryCourseContentRecord(
      queryBuilder: (courseContentRecord) =>
        courseContentRecord.where('id', isEqualTo: widget.contentID),
        singleRecord: true,
      ).first.then((snapshot) {
      List<CourseContentRecord> scUNoteWriteCourseContentRecordList = snapshot;

      for (int i = 0; i < scUNoteWriteCourseContentRecordList.length; i++) {
        for (int j = 0; j < scUNoteWriteCourseContentRecordList[i].lectureArray!.length; j++) {
          final record = scUNoteWriteCourseContentRecordList[i];
          _model.lectureContentArray.add(record.lectureArray![j].content!);
        }
      }

    });
  }
}
