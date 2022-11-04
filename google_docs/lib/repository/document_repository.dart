import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs/constatnts.dart';
import 'package:google_docs/model/document_model.dart';
import 'package:google_docs/model/error_model.dart';
import 'package:http/http.dart';

final documentRepositoryProvider =
    Provider((_) => DocumentRepository(client: Client()));

class DocumentRepository {
  final Client _client;
  DocumentRepository({
    required Client client,
  }) : _client = client;

  Future<ErrorModel> createDocument(String token) async {
    ErrorModel error =
        ErrorModel(error: "Something wrong happened!!", data: null);
    try {
      var res = await _client.post(Uri.parse('$host/doc/create'),
          body: json.encode({
            'createAt': DateTime.now().millisecondsSinceEpoch,
          }),
          headers: {'Content-Type': 'application/json', 'x-auth-token': token});
      Map<String, dynamic> resBody = json.decode(res.body);
      switch (res.statusCode) {
        case 500:
          error = ErrorModel(error: resBody["error"], data: null);
          break;
        case 200:
          error = ErrorModel(
              error: null,
              data: DocumentModel(
                  title: resBody['title'],
                  uid: resBody['uid'],
                  content: resBody['content'],
                  createdAt:
                      DateTime.fromMillisecondsSinceEpoch(resBody['createdAt']),
                  id: resBody['_id']));
          break;
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel> getDocument(String token) async {
    ErrorModel error =
        ErrorModel(error: "Something wrong happened!!", data: null);
    try {
      var res = await _client
          .get(Uri.parse('$host/doc/me'), headers: {'x-auth-token': token});
      Map<String, dynamic> resBody = json.decode(res.body);
      switch (res.statusCode) {
        case 500:
          error = ErrorModel(error: resBody["error"], data: null);
          break;
        case 200:
          List<DocumentModel> documents = [];
          for (int i = 0; i < resBody.length; i++) {
            documents.add(DocumentModel(
                title: resBody[i]['title'],
                uid: resBody[i]['uid'],
                content: resBody[i]['content'],
                createdAt:
                    DateTime.fromMillisecondsSinceEpoch(resBody[i]['createdAt']),
                id: resBody[i]['_id']));
          }
          error = ErrorModel(error: null, data: documents);
          break;
      }
    } on Exception catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }
}
