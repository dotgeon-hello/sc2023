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

import 'sc_u_note_write_model.dart';
export 'sc_u_note_write_model.dart';

// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';

import 'dart:async';

// import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_speech/google_speech.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sound_stream/sound_stream.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ScUNoteWriteWidget extends StatefulWidget {
  const ScUNoteWriteWidget({
    Key? key,
    this.courseName,
    this.courseIndexTitle,
    this.contentID,
    this.contentMediaURL,
    this.courseIndexRef,
  }) : super(key: key);

  final String? courseName;
  final String? courseIndexTitle;
  final String? contentID;
  final String? contentMediaURL;
  final DocumentReference? courseIndexRef;

  @override
  _ScUNoteWriteWidgetState createState() => _ScUNoteWriteWidgetState();
}

class _ScUNoteWriteWidgetState extends State<ScUNoteWriteWidget>
    with TickerProviderStateMixin {
  late ScUNoteWriteModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final RecorderStream _recorder = RecorderStream();

  bool recognizing = false;
  bool recognizeFinished = false;
  String text = '';
  StreamSubscription<List<int>>? _audioStreamSubscription;
  BehaviorSubject<List<int>>? _audioStream;
  StreamSubscription<cloud_speech.StreamingRecognizeResponse>?
      _recognizeSubscription;

  @override
  void initState() {
    super.initState();

    _model = createModel(context, () => ScUNoteWriteModel());

    _recorder.initialize().then((_) {
      print("success");
    }).catchError((err) {
      print(err);
    });

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.contentMediaURL = widget.contentMediaURL;

        if (_model.contentMediaURL != null && _model.contentMediaURL != '')
          contentMediaPDFController = PdfController(
              document: PdfDocument.openData(
                  InternetFile.get(_model.contentMediaURL!)));
      });
    });

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'sc_u_NoteWrite'});
  }

  Future<void> streamingRecognize() async {
    await dotenv.load(fileName: ".env");
    final googleCloudCredentials =
        dotenv.env['GOOGLECLOUD_CREDENTIALS'] ?? '{}';

    _audioStream = BehaviorSubject<List<int>>();
    _audioStreamSubscription = _recorder.audioStream.listen((event) {
      _audioStream!.add(event);
    });

    await _recorder.start();

    setState(() {
      recognizing = true;
    }); // aaa
    // final accountJson =
    //    await rootBundle.loadString('assets/keys/test_service_account.json');
    // final serviceAccount = ServiceAccount.fromString(await rootBundle.loadString('assets/keys/test_service_account.json')
    //     (a));
    //final serviceAccount = ServiceAccount.fromString(accountJson);

    final serviceAccount = ServiceAccount.fromString(googleCloudCredentials);
    final speechToText = SpeechToText.viaServiceAccount(serviceAccount);
    final config = _getConfig();

    final responseStream = speechToText.streamingRecognize(
        StreamingRecognitionConfig(config: config, interimResults: true),
        _audioStream!);

    _recognizeSubscription = responseStream.listen((data) {
      final currentText =
          data.results.map((e) => e.alternatives.first.transcript).join('');

      if (data.results.first.isFinal) {
        if (currentText.isNotEmpty) addNoteLine(currentText, null);

        setState(() {
          recognizeFinished = true;
          _model.liveScript = "";
        });
      } else {
        setState(() {
          _model.liveScript = currentText;

          recognizeFinished = true;
        });
      }
    }, onDone: () {
      setState(() {
        recognizing = false;
      });
    });
  }

  Future<void> stopRecording() async {
    await _recorder.stop();
    await _audioStreamSubscription?.cancel();
    await _audioStream?.close();
    setState(() {
      recognizing = false;
    });
  }

  Future<void> onQuestion(bool question) async {
    await stopRecording();
    _recognizeSubscription?.onDone(() {
      setState(() {
        _model.isQuestioning = question;
      });
    });
    await streamingRecognize();
  }

  RecognitionConfig _getConfig() => RecognitionConfig(
      encoding: AudioEncoding.LINEAR16,
      model: RecognitionModel.basic,
      enableAutomaticPunctuation: true,
      sampleRateHertz: 16000,
      languageCode: _model.languageCode);

  void onStatusChange() {
    if (_model.isRecording) {
      if (_model.isPaused) {
        stopRecording();
      } else {
        streamingRecognize();
      }
    } else {
      if (recognizing) {
        stopRecording();
      }
    }
  }

  void addNoteLine(String script, int? contentMediaPage) {
    logFirebaseEvent('SC_U_NOTE_WRITE_[TEST]_ADD_LECTURE_BTN_O');
    logFirebaseEvent('Button_backend_call');

    queryCourseContentRecord(
      queryBuilder: (courseContentRecord) =>
          courseContentRecord.where('id', isEqualTo: widget.contentID),
      singleRecord: true,
    ).first.then((snapshot) {
      List<CourseContentRecord> scUNoteWriteCourseContentRecordList = snapshot;

      final scUNoteWriteCourseContentRecord =
          scUNoteWriteCourseContentRecordList.isNotEmpty
              ? scUNoteWriteCourseContentRecordList.first
              : null;

      final courseContentUpdateData = {
        'lectureArray': FieldValue.arrayUnion([
          getLectureArrayElementFirestoreData(
            createLectureArrayElementStruct(
              content: script,
              isQuestion: _model.isQuestioning,
              timestamp: getCurrentTimestamp,
              contentMediaPage: contentMediaPage ?? _model.contentMediaPage,
              clearUnsetFields: false,
            ),
            true,
          )
        ]),
      };

      scUNoteWriteCourseContentRecord!.reference
          .update(courseContentUpdateData);
    });
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  late PdfController contentMediaPDFController;

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = 70;
    bool isContentMediaAvailable =
        (_model.contentMediaURL != null && _model.contentMediaURL != '');

    return StreamBuilder<List<CourseContentRecord>>(
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
        List<CourseContentRecord> scUNoteWriteCourseContentRecordList =
            snapshot.data!;
        final scUNoteWriteCourseContentRecord =
            scUNoteWriteCourseContentRecordList.isNotEmpty
                ? scUNoteWriteCourseContentRecordList.first
                : null;
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
            actions: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                child: FFButtonWidget(
                  onPressed: (!_model.isRecording || _model.isPaused)
                      ? () {
                          switch (_model.languageCode) {
                            case 'en-US':
                              setState(() {
                                _model.languageCode = 'ko-KR';
                              });
                              break;
                            default:
                              setState(() {
                                _model.languageCode = 'en-US';
                              });
                          }
                        }
                      : null,
                  text: getLanguageName(_model.languageCode),
                  options: FFButtonOptions(
                    // disable : decrease opacity
                    disabledColor: FlutterFlowTheme.of(context).secondaryColor,
                    disabledTextColor:
                        FlutterFlowTheme.of(context).white.withAlpha(127),
                    width: 100.0,
                    height: 40.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).secondaryColor,
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
            centerTitle: false,
            elevation: 0.0,
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (isContentMediaAvailable)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: PdfView(
                      controller: contentMediaPDFController,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (int page) {
                        if (_model.isRecording &&
                            !_model.isPaused &&
                            _model.liveScript.isNotEmpty)
                          addNoteLine(_model.liveScript + "...",
                              _model.contentMediaPage);
                        setState(() {
                          _model.contentMediaPage = page;
                        });
                      },
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 2.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (!isContentMediaAvailable)
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).gray200,
                                ),
                              ),
                              child: FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30,
                                borderWidth: 1,
                                buttonSize: 30,
                                icon: Icon(
                                  Icons.upload_file,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 30,
                                ),
                                onPressed: () async {
                                  // print('ContentMediaUploadButton pressed ...');
                                  // FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
                                  uploadContentMedia(widget.contentID,
                                          widget.courseIndexRef)
                                      .then((String result) {
                                    setState(() {
                                      _model.contentMediaURL = result;
                                      contentMediaPDFController = PdfController(
                                          document: PdfDocument.openData(
                                              InternetFile.get(
                                                  _model.contentMediaURL!)));

                                      // Navigator.pop(context);
                                    });
                                  });
                                },
                              ),
                              margin: EdgeInsets.only(bottom: 10),
                            ),
                          if (_model.isRecording)
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: _model.liveScript,
                                        style: TextStyle(
                                            color: _model.isQuestioning
                                                ? FlutterFlowTheme.of(context)
                                                    .secondaryColor
                                                : FlutterFlowTheme.of(context)
                                                    .primaryText),
                                      )
                                    ],
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Outfit',
                                          fontSize: 20.0,
                                        ),
                                  ),
                                ),
                                Divider(
                                  thickness: 1.5,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryColor,
                                ),
                              ],
                            ),
                          Builder(
                            builder: (context) {
                              final lectureArray =
                                  functions.filterLectureArrayByPage(
                                      functions
                                          .sortLectureArray(
                                              scUNoteWriteCourseContentRecord!
                                                  .lectureArray!
                                                  .toList(),
                                              true)
                                          .map((e) => e)
                                          .toList(),
                                      _model.contentMediaPage);
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: lectureArray.length,
                                itemBuilder: (context, lectureArrayIndex) {
                                  final lectureArrayItem =
                                      lectureArray[lectureArrayIndex];
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width * 1.0,
                                    decoration: BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            logFirebaseEvent(
                                                'SC_U_NOTE_WRITE_Container_sfh9nrwp_ON_TA');
                                            logFirebaseEvent(
                                                'Container_bottom_sheet');
                                            await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              enableDrag: false,
                                              context: context,
                                              builder: (context) {
                                                return Padding(
                                                  padding:
                                                      MediaQuery.of(context)
                                                          .viewInsets,
                                                  child: EditNoteWidget(
                                                    courseContentRef:
                                                        scUNoteWriteCourseContentRecord!
                                                            .reference,
                                                    lectureArray:
                                                        scUNoteWriteCourseContentRecord!
                                                            .lectureArray!
                                                            .toList(),
                                                    targetTimestamp:
                                                        lectureArrayItem
                                                            .timestamp,
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1.0,
                                            decoration: BoxDecoration(),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 8.0),
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: lectureArrayItem
                                                          .content!,
                                                      style: TextStyle(),
                                                    )
                                                  ],
                                                  style:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyText1
                                                          .override(
                                                            fontFamily:
                                                                'Outfit',
                                                            color: lectureArrayItem.isQuestion!
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryColor
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                            fontSize: 20.0,
                                                          ),
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1.0,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_model.isRecording &&
                    _model.isPaused &&
                    !_model.isQuestioning)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            logFirebaseEvent(
                                'SC_U_NOTE_WRITE_Container_f93ez66d_ON_TA');
                            logFirebaseEvent('Container_update_widget_state');
                            setState(() {
                              _model.isPaused = false;
                              onStatusChange();
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: buttonHeight,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x28000000),
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
                            alignment:
                                AlignmentDirectional(0.0, -0.44999999999999996),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 8.0, 0.0),
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    color: FlutterFlowTheme.of(context).white,
                                    size: 36.0,
                                  ),
                                ),
                                Text(
                                  'Resume',
                                  style: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            logFirebaseEvent(
                                'SC_U_NOTE_WRITE_Container_twb2cunm_ON_TA');
                            logFirebaseEvent('Container_update_widget_state');
                            setState(() {
                              _model.isRecording = false;
                              _model.isPaused = false;
                              _model.isQuestioning = false;
                              onStatusChange();
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: buttonHeight,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).tertiaryColor,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x28000000),
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
                            alignment:
                                AlignmentDirectional(0.0, -0.44999999999999996),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 8.0, 0.0),
                                  child: Icon(
                                    Icons.stop,
                                    color: FlutterFlowTheme.of(context).white,
                                    size: 24.0,
                                  ),
                                ),
                                Text(
                                  'Stop',
                                  style: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (_model.isRecording &&
                    !_model.isPaused &&
                    !_model.isQuestioning)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            logFirebaseEvent(
                                'SC_U_NOTE_WRITE_Container_igtdid0c_ON_TA');
                            logFirebaseEvent('Container_update_widget_state');
                            setState(() {
                              _model.isPaused = true;
                              onStatusChange();

                              ///_speechToText.isNotListening ? _startListening() : _stopListening();
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: buttonHeight,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).tertiaryColor,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x28000000),
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
                            alignment:
                                AlignmentDirectional(0.0, -0.44999999999999996),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 8.0, 0.0),
                                  child: Icon(
                                    Icons.pause,
                                    color: FlutterFlowTheme.of(context).white,
                                    size: 24.0,
                                  ),
                                ),
                                Text(
                                  'Pause',
                                  style: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            logFirebaseEvent(
                                'SC_U_NOTE_WRITE_Container_startQ_ON_TA');
                            logFirebaseEvent('Container_update_widget_state');
                            await onQuestion(true);
                            setState(() {
                              _model.isRecording = true;
                              _model.isPaused = false;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: buttonHeight,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).alternate,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x28000000),
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
                            alignment:
                                AlignmentDirectional(0.0, -0.44999999999999996),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 8.0, 0.0),
                                  child: Icon(
                                    Icons.question_answer,
                                    color: FlutterFlowTheme.of(context).white,
                                    size: 24.0,
                                  ),
                                ),
                                Text(
                                  'Question',
                                  style: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (!_model.isRecording &&
                    !_model.isPaused &&
                    !_model.isQuestioning)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            logFirebaseEvent(
                                'SC_U_NOTE_WRITE_Container_rhfz0r3n_ON_TA');
                            logFirebaseEvent('Container_update_widget_state');
                            setState(() {
                              _model.isRecording = true;
                              _model.isPaused = false;
                              _model.isQuestioning = false;
                              onStatusChange();
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: buttonHeight,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).primaryColor,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x28000000),
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
                            alignment:
                                AlignmentDirectional(0.0, -0.44999999999999996),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 8.0, 0.0),
                                  child: Icon(
                                    Icons.mic,
                                    color: FlutterFlowTheme.of(context).white,
                                    size: 24.0,
                                  ),
                                ),
                                Text(
                                  'Record',
                                  style: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (_model.isRecording &&
                    !_model.isPaused &&
                    _model.isQuestioning)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            logFirebaseEvent(
                                'SC_U_NOTE_WRITE_Container_stopQ_ON_TA');
                            logFirebaseEvent('Container_update_widget_state');
                            onQuestion(false);
                            setState(() {
                              _model.isRecording = true;
                              _model.isPaused = false;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            height: buttonHeight,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).tertiaryColor,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x28000000),
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
                            alignment:
                                AlignmentDirectional(0.0, -0.44999999999999996),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 8.0, 0.0),
                                  child: Icon(
                                    Icons.close,
                                    color: FlutterFlowTheme.of(context).white,
                                    size: 24.0,
                                  ),
                                ),
                                Text(
                                  'Stop Question',
                                  style: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
