import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PdfUploadWidget extends StatefulWidget {
  final Function(String) onFilePicked; // Callback for when a file is picked

  const PdfUploadWidget({required this.onFilePicked, super.key});

  @override
  _PdfUploadWidgetState createState() => _PdfUploadWidgetState();
}

class _PdfUploadWidgetState extends State<PdfUploadWidget> {
  String? _filePath;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _filePath = result.files.single.path;
      });
      widget
          .onFilePicked(_filePath!); // Send the file path to the parent widget
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickFile,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            const SizedBox(height: 10),
            ListTile(
              title: const Text('Upload PDF',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                _filePath == null ? 'No file selected' : _filePath!,
                style: TextStyle(
                    color: _filePath == null ? Colors.red : Colors.green),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.upload_file),
                onPressed: _pickFile,
              ),
            ),
            if (_filePath != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _filePath =
                          null; // Reset the file path when user decides to remove it
                    });
                  },
                  child: const Text('Remove PDF'),
                ),
              ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
