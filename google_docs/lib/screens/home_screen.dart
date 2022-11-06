import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs/colors.dart';
import 'package:google_docs/model/document_model.dart';
import 'package:google_docs/model/error_model.dart';
import 'package:google_docs/repository/auth_repository.dart';
import 'package:google_docs/repository/document_repository.dart';
import 'package:google_docs/widgets/loader.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  Future<ErrorModel>? _future = null;
  TextEditingController _controller = TextEditingController();

  void signOut(WidgetRef ref) {
    ref.read(authRepositoryProvider).signOut();
    ref.read(userProvider.notifier).update((state) => null);
  }

  void creatDocument(BuildContext context, WidgetRef ref) async {
    String token = ref.read(userProvider)!.token;
    final navigator = Routemaster.of(context);
    final snackbar = ScaffoldMessenger.of(context);

    final errorModel =
        await ref.read(documentRepositoryProvider).createDocument(token);

    if (errorModel.data != null) {
      navigator.push('/document/${errorModel.data.id}');
    } else {
      snackbar.showSnackBar(SnackBar(content: Text(errorModel.error!)));
    }
  }

  void navigateToDocument(BuildContext ctx, String documentId, WidgetRef ref) {
    _future = null;
    NavigationResult navigationResult =
        Routemaster.of(ctx).push('/document/$documentId');
    navigationResult.result.then(
      (value) {
        _future = ref
            .read(documentRepositoryProvider)
            .getDocument(ref.watch(userProvider)!.token);
      },
    );
  }

  void addNewDocumentById(WidgetRef ref, String docId) {
    _future = ref
        .read(documentRepositoryProvider)
        .addDocumentById(ref.watch(userProvider)!.token, docId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _future = ref
        .read(documentRepositoryProvider)
        .getDocument(ref.watch(userProvider)!.token);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => creatDocument(context, ref),
              icon: const Icon(
                Icons.add,
                color: KBlackColor,
              )),
          IconButton(
              onPressed: () => signOut(ref),
              icon: const Icon(
                Icons.logout,
                color: kRedColor,
              ))
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextFormField(
                    controller: _controller,
                    cursorHeight: 25,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.only(left: 10, top: 10, bottom: 5),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: kBlueColor, width: 2))),
                  )),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                  onPressed: () =>
                      addNewDocumentById(ref, _controller.value.text),
                  icon: const Icon(Icons.add),
                  label: const Text("add"))
            ],
          ),
          Expanded(
            child: FutureBuilder<ErrorModel>(
                future: _future,
                builder: (ctx, snapshot) => snapshot.connectionState ==
                        ConnectionState.waiting
                    ? const Loader()
                    : Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: 600,
                          child: ListView.builder(
                            itemCount: snapshot.data!.data.length,
                            itemBuilder: (context, index) {
                              DocumentModel document =
                                  snapshot.data!.data[index];
                              return InkWell(
                                onTap: () =>
                                    navigateToDocument(ctx, document.id, ref),
                                child: SizedBox(
                                  height: 50,
                                  child: Card(
                                    child: Center(
                                      child: Text(
                                        document.title,
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )),
          ),
        ],
      ),
    );
  }
}
