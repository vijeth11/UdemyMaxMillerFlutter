import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs/colors.dart';
import 'package:google_docs/model/document_model.dart';
import 'package:google_docs/model/error_model.dart';
import 'package:google_docs/repository/auth_repository.dart';
import 'package:google_docs/repository/document_repository.dart';
import 'package:google_docs/repository/socket_repository.dart';
import 'package:google_docs/widgets/loader.dart';
import 'package:routemaster/routemaster.dart';

class DocumentScreen extends ConsumerStatefulWidget {
  final String id;
  const DocumentScreen({Key? key, required this.id}) : super(key: key);

  @override
  ConsumerState<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends ConsumerState<DocumentScreen> {
  TextEditingController titleController =
      TextEditingController(text: 'Untitled Document');
  ErrorModel? errorModel;
  SocketRepository socketRepository = SocketRepository();
  quill.QuillController? _controller;

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  void initState() {
    socketRepository.joinRoom(widget.id);
    errorModel =
        ref.read(documentRepositoryProvider).getDocumentById(widget.id);
    titleController.text = (errorModel!.data as DocumentModel).title.isNotEmpty
        ? (errorModel!.data as DocumentModel).title
        : 'Untitled Document';
    if (errorModel!.data != null) {
      DocumentModel document = errorModel!.data;
      _controller = quill.QuillController(
          document: document.content.isEmpty
              ? quill.Document()
              : quill.Document.fromDelta(
                  quill.Delta.fromJson(document.content)),
          selection: const TextSelection.collapsed(offset: 0));
    }

    // listen to the changes made by user
    _controller!.document.changes.listen((event) {
      if (event.item3 == quill.ChangeSource.LOCAL) {
        Map<String, dynamic> map = {'delta': event.item2, 'room': widget.id};
        socketRepository.typing(map);
      }
    });

    // update document when changes made by other
    socketRepository.changeListner((data) {
      _controller?.compose(
          quill.Delta.fromJson(data['delta']),
          _controller?.selection ?? const TextSelection.collapsed(offset: 0),
          quill.ChangeSource.REMOTE);
    });

    //auto save the document
    Timer.periodic(const Duration(seconds: 3), (timer) {
      socketRepository.autoSave(<String, dynamic>{
        'delta': _controller!.document.toDelta(),
        'docId': widget.id
      });
    });
    super.initState();
  }

  void updateTitle(WidgetRef ref, String title) async {
    errorModel = await ref
        .read(documentRepositoryProvider)
        .updateTitle(ref.read(userProvider)!.token, widget.id, title);
    if (errorModel!.data != null) {
      titleController.text = (errorModel!.data as DocumentModel).title;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      return const Scaffold(
        body: Loader(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: widget.id))
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Document Id copied copied!')));
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: kBlueColor),
                icon: const Icon(
                  Icons.lock,
                  size: 16,
                  color: KBlackColor,
                ),
                label: const Text('Share')),
          )
        ],
        leadingWidth: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Routemaster.of(context).replace('/'),
                child: Image.asset(
                  'assets/images/docs-logo.png',
                  height: 40,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 180,
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kBlueColor)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 10)),
                  onSubmitted: (value) => updateTitle(ref, value),
                ),
              )
            ],
          ),
        ),
        bottom: PreferredSize(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: kGreyColor, width: 0.1)),
          ),
          preferredSize: const Size.fromHeight(1),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            quill.QuillToolbar.basic(controller: _controller!),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SizedBox(
                  width: 750,
                  child: Card(
                    color: kWhiteColor,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: quill.QuillEditor.basic(
                          controller: _controller!, readOnly: false),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
