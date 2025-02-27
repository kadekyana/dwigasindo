import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class NoteForm extends StatefulWidget {
  final quill.QuillController controller;

  const NoteForm({super.key, required this.controller});

  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width,
      height: height * 0.3,
      child: Column(
        children: [
          quill.QuillToolbar.simple(
            controller: widget.controller,
            configurations: const quill.QuillSimpleToolbarConfigurations(
              showBoldButton: false,
              showItalicButton: false,
              showUnderLineButton: false,
              showStrikeThrough: false,
              showColorButton: false,
              showBackgroundColorButton: false,
              showClearFormat: false,
              showHeaderStyle: false,
              showFontFamily: false,
              showFontSize: false,
              showListCheck: false,
              showCodeBlock: false,
              showQuote: false,
              showInlineCode: false,
              showLink: false,
              showUndo: false,
              showRedo: false,
              showDividers: false,
              showSearchButton: false,
              showIndent: false,
              multiRowsDisplay: false,
              showSuperscript: false,
              showSubscript: false,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            height: height * 0.2,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: quill.QuillEditor.basic(
              controller: widget.controller,
            ),
          ),
        ],
      ),
    );
  }
}
