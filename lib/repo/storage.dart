// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class StorageRepo {
  StorageRepo({required String uid}) : _uid = uid;
  final String _uid;
  // final String photoName = DateTime.now().toString();
  //final String videoName = DateTime.now().toString();

  /// Upload an avatar from file
  Future<String> uploadAvatar({
    required File file,
  }) async =>
      await _upload(
        file: file,
        path: '${FirestorePath.avatar(_uid)}/avatar.png',
        contentType: 'image/png',
      );

  Future<List<String>> uploadMultipleFiles({
    required String postId,
    required List<File> files,
  }) async {
    List<String> urls = [];
    for (File file in files) {
      final String attachmentName = DateTime.now().toString();
      String url = await _upload(
        file: file,
        path: '${FirestorePath.attachment(postId)}/$attachmentName',
        contentType: 'image/png',
      );
      urls.add(url);
    }
    return urls;
  }

  /// Generic file upload for any [path] and [contentType]
  Future<String> _upload({
    required File file,
    required String path,
    required String contentType,
  }) async {
    late final String downloadUrl;
    print('uploading to: $path');
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;

    final storageReference = storage.ref().child(path);
    final uploadTask = storageReference.putFile(
        file, firebase_storage.SettableMetadata(contentType: contentType));
    uploadTask.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
      print('Task state: ${snapshot.state}');
      print(
          'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
    }, onError: (e) {
      // The final snapshot is also available on the task via `.snapshot`,
      // this can include 2 additional states, `TaskState.error` & `TaskState.canceled`
      print(uploadTask.snapshot);

      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    });
    try {
      await uploadTask;
      print('Upload complete.');
      // Url used to download file/image
      downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
      print('downloadUrl: $downloadUrl');
      return downloadUrl;
    } on firebase_storage.FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    }
    return downloadUrl;
  }
}

// Utility Class (Pathes to upload files to)
class FirestorePath {
  static String avatar(String uid) => 'Files/avatar/$uid';
  static String attachment(String postId) => 'Files/posts/$postId/comments';
  // static String chatData() => 'Files/chatData';
}
