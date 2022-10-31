import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app_sochial/layout/Home_Layout/screens/chats/chats.dart';
import 'package:my_app_sochial/layout/Home_Layout/screens/feeds/feeds.dart';
import 'package:my_app_sochial/models/postModel.dart';
import 'package:my_app_sochial/models/usersModel.dart';
import 'package:my_app_sochial/shared/Cubit/AppCubit/state.dart';
import 'package:my_app_sochial/shared/Cubit/LoginCubit/states.dart';

import '../../../Components/components.dart';
import '../../../layout/Home_Layout/screens/notifications/notifications.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class socialCubit extends Cubit<socialStates> {
  socialCubit() : super(socialInitialState());
  static socialCubit get(context) => BlocProvider.of(context);
  TextEditingController dateController = TextEditingController();

  socialUsersModel? model;
  void getUserData() {
    emit(socialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
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
          'users/${uId}/ProfileImage/${Uri.file(
            profileimage!.path,
          ).pathSegments.last}',
        )
        .putFile(profileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(model!.uId)
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
        .child('users/${uId}/CoverImage/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        FirebaseFirestore.instance
            .collection("users")
            .doc(model!.uId)
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
    FirebaseFirestore.instance.collection("users").doc(model!.uId).update({
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
    FirebaseFirestore.instance.collection("users").doc(uId).collection('posts').add({
      "name": model!.name,
      "image": model!.image,
      "uId": model!.uId,
      "date": DateTime.now().toString(),
      "text": text,
      "postId": "",
      'Likes': {uId: false},
      "postImage": postImage ?? '',
    }).then((value) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(uId)
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
        .doc(uId)
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
        .doc(uId)
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
        .doc('${uId}')
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
    if (Likes[index][uId] == true) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('posts')
          .doc(postId)
          .update({
        'Likes': {uId: false}
      }).then((value) {
        getPostData();
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('posts')
          .doc(postId)
          .collection("likesCount")
          .doc(uId)
          .delete();
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('posts')
          .doc(postId)
          .update({
        'Likes': {uId: true}
      }).then((value) {
        getPostData();
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('posts')
          .doc(postId)
          .collection("likesCount")
          .doc(uId)
          .set({"${uId.toString()}": true});
    }
  }

  void addCommentPost(String? postId, {String? comment}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection("posts")
        .doc('${postId}')
        .collection('comment')
        .add({
      "name": model!.name,
      "uId": model!.uId,
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
  int? commentCount = 0;
  int? likeCount = 0;
  void getCommentPost(String? postid) {
    emit(socialGetCommentPostLoadingState());
    comment = [];
    commentCount;
    likeCount;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection("posts")
        .doc('${postid}')
        .collection('comment')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        comment.add(commentModel.fromJson(element.data()));
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
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
          .doc(uId)
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
}
