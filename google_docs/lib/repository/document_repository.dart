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
  List<DocumentModel> _documents = [];

  DocumentRepository({
    required Client client,
  }) : _client = client;

  ErrorModel getDocumentById(String id) {
    return ErrorModel(
        error: null,
        data: _documents.firstWhere((element) => element.id == id));
  }

  Future<ErrorModel> createDocument(String token) async {
    ErrorModel error =
        ErrorModel(error: "Something wrong happened!!", data: null);
    try {
      var res = await _client.post(Uri.parse('$host/doc/create'),
          body: json.encode({
            'createdAt': DateTime.now().millisecondsSinceEpoch,
          }),
          headers: {'Content-Type': 'application/json', 'x-auth-token': token});
      Map<String, dynamic> resBody = json.decode(res.body);
      switch (res.statusCode) {
        case 500:
          error = ErrorModel(error: resBody["error"], data: null);
          break;
        case 200:
          DocumentModel document = DocumentModel(
              title: resBody['title'],
              uid: resBody['uid'],
              content: resBody['content'],
              createdAt:
                  DateTime.fromMillisecondsSinceEpoch(resBody['createdAt']),
              id: resBody['_id']);
          error = ErrorModel(error: null, data: document);
          _documents.add(document);
          break;
      }
    } catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel> updateTitle(String token, String id, String title) async {
    ErrorModel error =
        ErrorModel(error: "Something wrong happened!!", data: null);
    try {
      var res = await _client.post(Uri.parse('$host/doc/title'),
          body: json.encode({'id': id, 'title': title}),
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
          _documents = getDecodedDocuments(resBody["documents"]);
          error = ErrorModel(error: null, data: _documents);
          break;
      }
    } on Exception catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  Future<ErrorModel> addDocumentById(String token, String docId) async {
    ErrorModel error =
        ErrorModel(error: "Something wrong happened!!", data: null);
    try {
      var res = await _client.post(Uri.parse('$host/doc/add'),
          body: json.encode(<String, dynamic>{'docId': docId}),
          headers: {'Content-Type': 'application/json', 'x-auth-token': token});
      Map<String, dynamic> resBody = json.decode(res.body);
      switch (res.statusCode) {
        case 500:
          error = ErrorModel(error: resBody["error"], data: null);
          break;
        case 200:
          _documents = getDecodedDocuments(resBody["documents"]);
          error = ErrorModel(error: null, data: _documents);
          break;
      }
    } on Exception catch (e) {
      error = ErrorModel(error: e.toString(), data: null);
    }
    return error;
  }

  List<DocumentModel> getDecodedDocuments(List<dynamic> documentBody) {
    List<DocumentModel> documents = [];
    for (int i = 0; i < documentBody.length; i++) {
      documents.add(DocumentModel(
          title: documentBody[i]['title'],
          uid: documentBody[i]['uid'],
          content: documentBody[i]['content'],
          createdAt:
              DateTime.fromMillisecondsSinceEpoch(documentBody[i]['createdAt']),
          id: documentBody[i]['_id']));
    }
    return documents;
  }
}
