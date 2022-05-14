import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:handball_ergebnisse/domain/game.dart';
import "package:http/http.dart" as http;
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

import '../widgets/handball_progress_indicator.dart';

class GamePdfPage extends StatefulWidget {
  final Game game;

  GamePdfPage(this.game);

  _GamePdfPageState createState() => _GamePdfPageState();
}

class _GamePdfPageState extends State<GamePdfPage> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  Uint8List? pdfData;
  bool isReady = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    _loadGamePdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.game.teams.home.name} vs ${widget.game.teams.guest.name}",
        ),
      ),
      body: pdfData != null
          ? Stack(
              children: <Widget>[
                PDFView(
                  pdfData: pdfData,
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: false,
                  pageFling: true,
                  pageSnap: true,
                  fitPolicy: FitPolicy.BOTH,
                  preventLinkNavigation: false,
                  onRender: (_pages) {
                    setState(() {
                      isReady = true;
                    });
                  },
                  onError: (error) {
                    setState(() {
                      errorMessage = error.toString();
                    });
                    print(error.toString());
                  },
                  onPageError: (page, error) {
                    setState(() {
                      errorMessage = '$page: ${error.toString()}';
                    });
                    print('$page: ${error.toString()}');
                  },
                  onViewCreated: (PDFViewController pdfViewController) {
                    _controller.complete(pdfViewController);
                  },
                ),
                errorMessage.isEmpty
                    ? !isReady
                        ? Center(child: HandballProgressIndicator())
                        : Container()
                    : Center(child: Text(errorMessage))
              ],
            )
          : Center(child: HandballProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.share),
        onPressed: () => _shareGamePdf(),
      ),
    );
  }

  void _shareGamePdf() async {
    final tempDirectory = await getTemporaryDirectory();
    final file = await File(
            '${tempDirectory.path}/spielbericht_${widget.game.h4aId}.pdf')
        .writeAsBytes(pdfData!);

    Share.shareFiles(
      [file.path],
      subject:
          "Spielbericht ${widget.game.teams.home.name} gegen ${widget.game.teams.guest.name}",
      text:
          "Hier ist der Spielbericht vom Spiel ${widget.game.teams.home.name} gegen ${widget.game.teams.guest.name}, dass ${widget.game.teams.home.goals}:${widget.game.teams.guest.goals} ausgegangen ist.",
    );
  }

  void _loadGamePdf() async {
    final data = await _loadPdfData(widget.game.reportUrl);

    setState(() {
      pdfData = data;
    });
  }

  Future<Uint8List> _loadPdfData(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return response.bodyBytes;
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
  }
}
