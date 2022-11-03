import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:my_app_sochial/layout/Home_Layout/screens/feeds/feeds.dart';
import 'package:my_app_sochial/models/chatModel.dart';
import 'package:my_app_sochial/models/postModel.dart';
import 'package:my_app_sochial/models/usersModel.dart';
import 'package:my_app_sochial/shared/Cubit/AppCubit/state.dart';

import '../../../Components/components.dart';
import '../../../layout/Home_Layout/screens/notifications/notifications.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class socialCubit extends Cubit<socialStates> {
  socialCubit() : super(socialInitialState());
  static socialCubit get(context) => BlocProvider.of(context);
  TextEditingController dateController = TextEditingController();
  String currentUid = FirebaseAuth.instance.currentUser!.uid;
  socialUsersModel? model;
  void getUserData() {
    emit(socialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(currentUid).get().then((value) {
      print(value.data());
      model = socialUsersModel.fromJson(value.data()!);
      emit(socialGetUserSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(socialGetUserErorrState(onError.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> homeScreen = [
    Feeds(),
    Notifications(),
  ];
  List<String?> title = ["الرئيسية", "الاشعارات"];
  void changeBottomNav(int? index) {
    currentIndex = index!;
    emit(socialChangebuttomNavState());
  }

  DateTime? selectedDate;
  Future SelectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1901, 1),
        lastDate: DateTime.now());
    if (picked != null || picked != selectedDate) {}
    {
      selectedDate = picked;
      dateController.value =
          TextEditingValue(text: "${picked!.day},${picked.month},${picked.year}");
      emit(socialChangeDateState());
    }
  }

  final picker = ImagePicker();
  /*---------------------------SelectProfileImage----------------------------*/
  File? profileimage;
  String? profileImageUrl;
  Future<void> getProfileImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileimage = File(image.path);

      emit(socialProfileImagePickedSuccessState());
    } else {
      emit(socialProfileImagePickedErorrState());
    }
  }

  /*-------------------Upload ProfileImage And Get Url------------------------*/
  void uploadProfileImage() {
    emit(socialUploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
          'users/${currentUid}/ProfileImage/${Uri.file(
            profileimage!.path,
          ).pathSegments.last}',
        )
        .putFile(profileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUid)
            .update({'image': value}).then((value) {});
        getUserData();
        emit(socialUploadProfileImageSuccessState());
      }).catchError((onError) {
        emit(socialUploadProfileImageErorrState());
      });
    }).catchError((onError) {
      emit(socialUploadProfileImageErorrState());
    });
  }

  /*---------------------------SelectCoverImage-------------------------------*/
  File? coverImage;
  String? coverImageUrl;
  Future<void> getCoverImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      coverImage = File(image.path);
      emit(socialProfileCoverPickedSuccessState());
    } else {
      emit(socialProfileCoverPickedErorrState());
    }
  }

/*---------------------Upload CoverImage And Get Url--------------------------*/
  void uploadCoverImage() {
    emit(socialUploadProfileCoverLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${currentUid}/CoverImage/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        FirebaseFirestore.instance
            .collection("users")
            .doc(currentUid)
            .update({'coverimage': value}).then((value) {
          getUserData();
          emit(socialUploadProfileCoverSuccessState());
        }).catchError((onError) {});
      }).catchError((onError) {
        emit(socialUploadProfileCoverErorrState());
      });
    }).catchError((onError) {
      emit(socialUploadProfileCoverErorrState());
    });
  }

/*---------------------Update DateUser--------------------------*/
  void updateData(
      {required String? name,
      required String? phone,
      required String? education,
      required String? relationship,
      required String? date,
      required String? bio}) {
    emit(socialUpdateDataLoadingState());
    FirebaseFirestore.instance.collection("users").doc(currentUid).update({
      "name": name,
      "phone": phone,
      "bio": bio,
      "education": education,
      "relationship": relationship,
      "date": date,
    }).then((value) {
      getUserData();
      emit(socialUpdateDataSuccessState());
    });
  }

/*---------------------Update DateUser--------------------------*/
  File? imagePost;
  String? imagePostUrl;
  Future<void> getImagePost() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePost = File(image.path);

      emit(socialImagePostPickedSuccessState());
    } else {
      emit(socialImagePostPickedErorrState());
    }
  }

  void deletePostImage() {
    imagePost = null;
    emit(socialDeletePostImageState());
  }

  void uploadPost({
    required String? text,
  }) {
    emit(socialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(imagePost!.path).pathSegments.last}')
        .putFile(imagePost!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createNewPost(
          text: text,
          postImage: value,
        );
        getPostData();
      }).catchError((onError) {});
    }).catchError((onError) {});
  }

  void createNewPost({
    required String? text,
    String? postImage,
  }) {
    emit(socialCreatePostLoadingState());
    FirebaseFirestore.instance.collection("users").doc(currentUid).collection('posts').add({
      "name": model!.name,
      "image": model!.image,
      "uId": currentUid,
      "date": DateTime.now().toString(),
      "text": text,
      "postId": "",
      'Likes': {currentUid: false},
      "postImage": postImage ?? '',
    }).then((value) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(currentUid)
          .collection('posts')
          .doc(value.id)
          .update({"postId": value.id});
      getPostData();
      emit(socialCreatePostSuccessState());
    }).catchError((onError) {
      emit(socialCreatePostErorrState());
    });
  }

  void deletePost(String? postId) {
    emit(socialDeletePostLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUid)
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value) {
      getPostData();
      emit(socialDeletePostSuccessState());
    }).catchError((onError) {
      emit(socialDeletePostErorrState());
    });
  }

  void editPost(String? postId, {String? postImage, String? text}) {
    emit(socialUPdatePostLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUid)
        .collection('posts')
        .doc(postId)
        .update({'text': text, 'postImage': postImage ?? ''}).then((value) {
      getPostData();
      emit(socialUPdatePostSuccessState());
    }).catchError((onError) {
      emit(socialUPdatePostErorrState());
    });
  }

  List posts = [];
  List Likes = [];
  List<postModel> LikePosts = [];
  void getPostData() {
    // emit(socialGetPostsLoadingState());
    posts = [];
    Likes = [];
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUid)
        .collection('posts')
        .get()
        .then((value) {
      for (var element in value.docs) {
        posts.add(postModel.fromJson(element.data()));
        Likes.add(element.data()['Likes']);
        print(Likes);
        emit(socialGetPostsSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(socialGetPostsErorrState(onError.toString()));
    });
  }

  void getLikeCommentPost(String? postid) {
    emit(socialGetLikeCommentPostLoadingState());
  }

  void likePost(String? postId, int index) {
    print(postId);
    if (Likes[index][currentUid] == true) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUid)
          .collection('posts')
          .doc(postId)
          .update({
        'Likes': {currentUid: false}
      }).then((value) {
        getPostData();
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUid)
          .collection('posts')
          .doc(postId)
          .collection("likesCount")
          .doc(currentUid)
          .delete();
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUid)
          .collection('posts')
          .doc(postId)
          .update({
        'Likes': {currentUid: true}
      }).then((value) {
        getPostData();
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUid)
          .collection('posts')
          .doc(postId)
          .collection("likesCount")
          .doc(currentUid)
          .set({"${currentUid.toString()}": true});
    }
  }

  void addCommentPost(String? postId, {String? comment}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUid)
        .collection("posts")
        .doc('${postId}')
        .collection('comment')
        .add({
      "name": model!.name,
      "uId": uId,
      'comment': comment,
      'image': model!.image,
      'date': DateTime.now().toString()
    }).then((value) {
      emit(socialCommentPostSuccessState());
    }).catchError((onError) {
      emit(socialCommentPostErorrState(onError));
    });
  }

  List<commentModel> comment = [];
  List idComment = [];
  int? commentCount = 0;
  int? likeCount = 0;
  void getCommentPost(String? postid) {
    emit(socialGetCommentPostLoadingState());
    comment = [];
    idComment = [];
    commentCount;
    likeCount;
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUid)
        .collection("posts")
        .doc('${postid}')
        .collection('comment')
        .orderBy('date')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(element.id);
        idComment.add(element.id);
        comment.add(commentModel.fromJson(element.data()));
      });
      print(currentUid);
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUid)
          .collection("posts")
          .doc('${postid}')
          .collection('comment')
          .get()
          .then((value) {
        commentCount = value.docs.length;
        emit(socialGetCommentPostSuccessState());
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentUid)
          .collection("posts")
          .doc('${postid}')
          .collection('likesCount')
          .get()
          .then((value) {
        likeCount = value.docs.length;
        emit(socialGetCommentPostSuccessState());
      });
      emit(socialGetCommentPostSuccessState());
    }).catchError((onError) {
      emit(socialGetCommentPostErorrState(onError.toString()));
    });
  }

  void deleteComment({required String? commentId, required String? postId}) {
    print(postId);
    print(commentId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUid)
        .collection('posts')
        .doc(postId)
        .collection('comment')
        .doc(commentId!)
        .delete()
        .then((value) {
      getCommentPost(postId);
    }).catchError((onError) {});
  }

  List<socialUsersModel> users = [];
  void getUsers() {
    users = [];
    emit(socialGetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != currentUid) {
          print(element.data()['uId'].toString());
          users.add(socialUsersModel.fromJson(element.data()));
        }

        emit(socialGetAllUsersSuccessState());
      });
    }).catchError((onError) {
      emit(socialGetAllUsersErorrState(onError.toString()));
    });
  }

  void sendMessage({
    required String reciverId,
    String? dateTime,
    String? imageUrl,
    required String text,
  }) {
    MessgeModel model = MessgeModel(
        senderId: currentUid,
        reciverId: reciverId,
        dateTime: DateTime.now().toString(),
        text: text,
        image: imageUrl ?? '');
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUid)
        .collection('chats')
        .doc(reciverId)
        .collection("Messges")
        .add(model.toMap())
        .then((value) {
      emit(socialSendMessgeSuccessState());
    }).catchError((onError) {
      emit(socialSendMessgeErorrState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chats')
        .doc(currentUid)
        .collection("Messges")
        .add(model.toMap())
        .then((value) {
      emit(socialSendMessgeSuccessState());
    }).catchError((onError) {
      emit(socialSendMessgeErorrState());
    });
  }

  void uploadImageMessage({
    required String reciverId,
    required String text,
  }) {
    emit(socialUploadImageMessageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('MessageImage/${currentUid}/${Uri.file(imagePost!.path).pathSegments.last}')
        .putFile(imagePost!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessage(reciverId: reciverId, text: text, imageUrl: value);
        deletePostImage();
      });
    }).catchError((onError) {});
  }

  List<MessgeModel> messagesList = [];
  void getMessages({
    required String reciverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUid)
        .collection('chats')
        .doc(reciverId)
        .collection('Messges')
        .orderBy(
          'dateTime',
        )
        .snapshots()
        .listen((event) {
      print(event.docChanges.length);
      messagesList = [];
      event.docs.forEach((element) {
        messagesList.add(MessgeModel.fromJson(element.data()));
      });
      emit(socialGetMessgeSuccessState());
    });
  }
}
