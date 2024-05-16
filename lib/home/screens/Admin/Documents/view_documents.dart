import 'package:flutter/material.dart';
import 'package:intel_traffic/Backend/cloud_firebase_methods.dart';

class ViewDocs extends StatefulWidget {
  final String docType;

  const ViewDocs({Key? key, required this.docType}) : super(key: key);

  @override
  State<ViewDocs> createState() => _ViewDocsState();
}

class _ViewDocsState extends State<ViewDocs> {
  late List<String> _docImages = [];
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    fetchDocImages();
  }

  Future<void> fetchDocImages() async {
    List<String> images =
        await CloudFirestoreClass().fetchImagesByType(widget.docType);

    setState(() {
      _docImages = images;
    });
  }

  Future<void> markDocumentAsVerified(int index) async {
    String imageUrl = _docImages[index];
    await CloudFirestoreClass().markDocumentAsVerified(imageUrl);

    // After marking as verified, refresh the page
    fetchDocImages();

    // Set state to false after verification
    setState(() {
      _isVerifying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View ${widget.docType}s',
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: _docImages.isEmpty
          ? Center(
              child: Text('No ${widget.docType}s to verify'),
            )
          : ListView.builder(
              itemCount: _docImages.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Image.network(_docImages[index]),
                    subtitle: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _isVerifying = true;
                        });

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: SizedBox(
                              height: 100,
                              width: 100,
                              child: FutureBuilder(
                                future: markDocumentAsVerified(index),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // Show circular progress indicator while verifying
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.hasError) {
                                    // Show error message if any error occurs
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    // Show verification success message
                                    return Text('${widget.docType} verified');
                                  }
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      child: _isVerifying ? SizedBox() : Text('Verify'),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
