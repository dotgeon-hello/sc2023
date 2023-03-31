import 'package:internet_file/internet_file.dart';
import 'package:pdfx/pdfx.dart';

import '/backend/backend.dart';
import '/components_sc2023/edit_note/edit_note_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages_sc2023/sc_u_note_write/sc_u_note_write_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'sc_u_note_read_model.dart';
export 'sc_u_note_read_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

final openAiApiKey = dotenv.env['OPENAI_API_KEY'];
final openAiApiUrl = 'https://api.openai.com/v1/completions';

class ScUNoteReadWidget extends StatefulWidget {
  const ScUNoteReadWidget({
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
  _ScUNoteReadWidgetState createState() => _ScUNoteReadWidgetState();
}

class _ScUNoteReadWidgetState extends State<ScUNoteReadWidget>
    with TickerProviderStateMixin {
  late ScUNoteReadModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ScUNoteReadModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'sc_u_NoteRead'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      logFirebaseEvent('SC_U_NOTE_READ_sc_u_NoteRead_ON_LOAD');
      logFirebaseEvent('sc_u_NoteRead_backend_call');

      final courseIndexUpdateData = createCourseIndexRecordData(
        viewedAt: getCurrentTimestamp,
      );
      await widget.courseIndexRef!.update(courseIndexUpdateData);
    });
    if (widget.contentMediaURL != null && widget.contentMediaURL != '')
      contentMediaPDFController = PdfController(
          document: PdfDocument.openData(
              InternetFile.get(widget.contentMediaURL ?? '')));
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  late PdfController contentMediaPDFController;

  Future<String> extractHighlight(String text) async {
    final prompt =
        "Find some of the most important keywords from following text and only return keywords split by comma(','). Put the more important words in the front.\n\n$text\n\n";
    final response = await http.post(
      Uri.parse(openAiApiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $openAiApiKey'
      },
      body: jsonEncode({
        "model": "text-davinci-003",
        'prompt': prompt,
        'max_tokens': 1000,
        'temperature': 0,
        'top_p': 1,
        'frequency_penalty': 0,
        'presence_penalty': 0
      }),
    );

    Map<String, dynamic> newresponse =
        jsonDecode(utf8.decode(response.bodyBytes));

    try {
      print(newresponse['choices'][0]['text']);
      return newresponse['choices'][0]['text']
          .replaceAll(RegExp(r'^[\n\s]+'), '');
    } catch (e) {
      return '';
    }
  }

  List<String> parseHighlight(String highlight) {
    return highlight
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s,\uAC00-\uD7A3]'), '')
        .replaceAll("\n", "")
        .split(RegExp(r',\s*'))
        .where((word) => word.isNotEmpty)
        .toList();
  }

  List<InlineSpan> highlightText(String content, List<String> highlightWords) {
    List<InlineSpan> result = [];
    int currentIndex = 0;

    int wordsToUse = (content.length / 120).ceil();
    wordsToUse =
        wordsToUse > highlightWords.length ? highlightWords.length : wordsToUse;
    List<String> selectedWords = highlightWords.take(wordsToUse).toList();

    if (highlightWords.isEmpty) {
      result.add(TextSpan(text: content));
      return result;
    }

    while (currentIndex < content.length) {
      int highlightedWordIndex = -1;
      int highlightedWordLength = 0;
      String foundWord = "";

      for (String word in selectedWords) {
        int wordIndex =
            content.toLowerCase().indexOf(word.toLowerCase(), currentIndex);
        if (wordIndex >= 0 &&
            (highlightedWordIndex == -1 || wordIndex < highlightedWordIndex)) {
          highlightedWordIndex = wordIndex;
          highlightedWordLength = word.length;
          foundWord = word;
        }
      }

      if (highlightedWordIndex >= 0) {
        if (highlightedWordIndex > currentIndex) {
          result.add(TextSpan(
              text: content.substring(currentIndex, highlightedWordIndex)));
        }
        result.add(TextSpan(
          text: content.substring(highlightedWordIndex,
              highlightedWordIndex + highlightedWordLength),
          style: TextStyle(backgroundColor: Colors.yellow[200]),
        ));
        currentIndex = highlightedWordIndex + highlightedWordLength;
        selectedWords.remove(foundWord);
      } else {
        result.add(TextSpan(text: content.substring(currentIndex)));
        break;
      }
    }
    return result;
  }

  Future<String> summerize(String text) async {
    final prompt = "Please create a summary of the following text.\n$text\n\n";
    final response = await http.post(
      Uri.parse(openAiApiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $openAiApiKey'
      },
      body: jsonEncode({
        "model": "text-davinci-003",
        'prompt': prompt,
        'max_tokens': 1000,
        'temperature': 0,
        'top_p': 1,
        'frequency_penalty': 0,
        'presence_penalty': 0
      }),
    );

    Map<String, dynamic> newresponse =
        jsonDecode(utf8.decode(response.bodyBytes));

    try {
      return newresponse['choices'][0]['text']
          .replaceAll(RegExp(r'^[\n\s]+'), '');
    } catch (e) {
      return 'Sorry, something went wrong.';
    }
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
        centerTitle: false,
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (widget.contentMediaURL != null && widget.contentMediaURL != '')
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
                    setState(() {
                      _model.contentMediaPage = page;
                    });
                  },
                ),
              ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 2.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (widget.contentMediaURL == null ||
                          widget.contentMediaURL == '') ...[
                        Text(
                          widget.courseName!,
                          style: FlutterFlowTheme.of(context).title2,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 8.0),
                          child: Text(
                            widget.courseIndexTitle!,
                            style: FlutterFlowTheme.of(context).subtitle2,
                          ),
                        ),
                      ],
                      if (!_model.isSummary)
                        StreamBuilder<List<CourseContentRecord>>(
                          stream: queryCourseContentRecord(
                            queryBuilder: (courseContentRecord) =>
                                courseContentRecord.where('id',
                                    isEqualTo: widget.contentID),
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                  ),
                                ),
                              );
                            }
                            List<CourseContentRecord>
                                listViewLectureCourseContentRecordList =
                                snapshot.data!;
                            // Return an empty Container when the item does not exist.
                            if (snapshot.data!.isEmpty) {
                              return Container();
                            }
                            final listViewLectureCourseContentRecord =
                                listViewLectureCourseContentRecordList
                                        .isNotEmpty
                                    ? listViewLectureCourseContentRecordList
                                        .first
                                    : null;
                            return Builder(
                              builder: (context) {
                                final sortedArray = functions
                                    .sortLectureArray(
                                        listViewLectureCourseContentRecord!
                                            .lectureArray!
                                            .toList(),
                                        false)
                                    .map((e) => e)
                                    .toList();
                                final lectureArray = widget.contentMediaURL !=
                                            null &&
                                        widget.contentMediaURL != ''
                                    ? functions.filterLectureArrayByPage(
                                        sortedArray, _model.contentMediaPage)
                                    : sortedArray;
                                functions.filterLectureArrayByPage(
                                    sortedArray, _model.contentMediaPage);
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
                                      width: MediaQuery.of(context).size.width *
                                          1.0,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onLongPress: () async {
                                              logFirebaseEvent(
                                                  'SC_U_NOTE_READ_Container_u7vyui6h_ON_LON');
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
                                                          listViewLectureCourseContentRecord!
                                                              .reference,
                                                      lectureArray:
                                                          listViewLectureCourseContentRecord!
                                                              .lectureArray!
                                                              .toList(),
                                                      targetTimestamp:
                                                          lectureArrayItem
                                                              .timestamp,
                                                    ),
                                                  );
                                                },
                                              ).then(
                                                  (value) => setState(() {}));
                                            },
                                            child: FutureBuilder<String>(
                                              future: extractHighlight(
                                                  lectureArrayItem.content!),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<String>
                                                      snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            1.0,
                                                    decoration: BoxDecoration(),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  8.0,
                                                                  0.0,
                                                                  8.0),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                                text: lectureArrayItem
                                                                    .content!)
                                                          ],
                                                          style: FlutterFlowTheme
                                                                  .of(context)
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
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                if (snapshot.hasError) {
                                                  return Text(
                                                      'Error: ${snapshot.error}');
                                                }

                                                final highlightWords =
                                                    parseHighlight(
                                                        snapshot.data!);

                                                return Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      1.0,
                                                  decoration: BoxDecoration(),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 8.0,
                                                                0.0, 8.0),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        children: highlightText(
                                                            lectureArrayItem
                                                                .content!,
                                                            highlightWords),
                                                        style: FlutterFlowTheme
                                                                .of(context)
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
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                );
                                              },
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
                            );
                          },
                        ),
                      if (_model.isSummary)
                        StreamBuilder<List<CourseContentRecord>>(
                          stream: queryCourseContentRecord(
                            queryBuilder: (courseContentRecord) =>
                                courseContentRecord.where('id',
                                    isEqualTo: widget.contentID),
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
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
                                  ),
                                ),
                              );
                            }
                            List<CourseContentRecord>
                                listViewLectureCourseContentRecordList =
                                snapshot.data!;
                            // Return an empty Container when the item does not exist.
                            if (snapshot.data!.isEmpty) {
                              return Container();
                            }
                            final listViewLectureCourseContentRecord =
                                listViewLectureCourseContentRecordList
                                        .isNotEmpty
                                    ? listViewLectureCourseContentRecordList
                                        .first
                                    : null;
                            return Builder(
                              builder: (context) {
                                final sortedArray = functions
                                    .sortLectureArray(
                                        listViewLectureCourseContentRecord!
                                            .lectureArray!
                                            .toList(),
                                        false)
                                    .map((e) => e)
                                    .toList();
                                final lectureArray = widget.contentMediaURL !=
                                            null &&
                                        widget.contentMediaURL != ''
                                    ? functions.filterLectureArrayByPage(
                                        sortedArray, _model.contentMediaPage)
                                    : sortedArray;
                                functions.filterLectureArrayByPage(
                                    sortedArray, _model.contentMediaPage);
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
                                      width: MediaQuery.of(context).size.width *
                                          1.0,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onLongPress: () async {
                                              logFirebaseEvent(
                                                  'SC_U_NOTE_READ_Container_u7vyui6h_ON_LON');
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
                                                          listViewLectureCourseContentRecord!
                                                              .reference,
                                                      lectureArray:
                                                          listViewLectureCourseContentRecord!
                                                              .lectureArray!
                                                              .toList(),
                                                      targetTimestamp:
                                                          lectureArrayItem
                                                              .timestamp,
                                                    ),
                                                  );
                                                },
                                              ).then(
                                                  (value) => setState(() {}));
                                            },
                                            child: FutureBuilder<String>(
                                              future: summerize(
                                                  lectureArrayItem.content!),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<String>
                                                      snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                                if (snapshot.hasError) {
                                                  return Text(
                                                      'Error: ${snapshot.error}');
                                                }

                                                return Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      1.0,
                                                  decoration: BoxDecoration(),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 8.0,
                                                                0.0, 8.0),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text: snapshot.data,
                                                        style: FlutterFlowTheme
                                                                .of(context)
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
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                );
                                              },
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
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 70.0,
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
                    alignment: AlignmentDirectional(0.0, -0.44999999999999996),
                    child: InkWell(
                      onTap: () async {
                        logFirebaseEvent('SC_U_NOTE_READ_PAGE_Button_ON_TAP');
                        logFirebaseEvent('Button_update_widget_state');
                        setState(() {
                          _model.isSummary = !_model.isSummary;
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 8.0, 0.0),
                            child: Icon(
                              Icons.library_books,
                              color: FlutterFlowTheme.of(context).white,
                              size: 24.0,
                            ),
                          ),
                          if (_model.isSummary)
                            Text(
                              'Full Text',
                              style:
                                  FlutterFlowTheme.of(context).title3.override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                      ),
                            ),
                          if (!_model.isSummary)
                            Text(
                              'Summary',
                              style:
                                  FlutterFlowTheme.of(context).title3.override(
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
                          'SC_U_NOTE_READ_Container_6ah6vngq_ON_TAP');
                      logFirebaseEvent('Container_backend_call');

                      final courseIndexUpdateData = createCourseIndexRecordData(
                        viewedAt: getCurrentTimestamp,
                      );
                      await widget.courseIndexRef!
                          .update(courseIndexUpdateData);
                      logFirebaseEvent('Container_navigate_to');
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScUNoteWriteWidget(
                            courseName: widget.courseName,
                            courseIndexTitle: widget.courseIndexTitle,
                            contentID: widget.contentID,
                            contentMediaURL: widget.contentMediaURL,
                            courseIndexRef: widget.courseIndexRef,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 70.0,
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
                              Icons.edit,
                              color: FlutterFlowTheme.of(context).white,
                              size: 24.0,
                            ),
                          ),
                          Text(
                            'Edit',
                            style: FlutterFlowTheme.of(context).title3.override(
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
  }
}
