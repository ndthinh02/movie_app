import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_bus/event_bus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/commom/event_bus/update_user.dart';
import 'package:movie_app/di.dart';
import 'package:movie_app/features/setting/domain/entities/user_entity.dart';

import '../../domain/usecase/user_use_case.dart';

part 'setting_event.dart';

part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  UserUseCase _useCase;

  SettingBloc(this._useCase) : super(SettingInitial()) {
    on<GetUser>(
      (event, emit) => _onGetUser(event, emit),
    );
    on<UpdateAvatar>(
      (event, emit) => _onUpdateAvatar(event, emit),
    );
    on<PickImage>(
      (event, emit) => _onPickImage(event, emit),
    );
  }

  String? _nameImage;
  final _picker = ImagePicker();

  File? _file;

  _onGetUser(GetUser event, Emitter emit) async {
    Future.delayed(const Duration(seconds: 2));
    final result = await _useCase.getUser();
    result.fold((err) {
      emit(UserLoadFailed());
    }, (user) {
      emit(
        UserLoadSuccess(userEntity: user),
      );
    });
  }

  _onUpdateAvatar(UpdateAvatar event, Emitter emit) async {
    try {
      emit(LoadAvatarState());
      final storageRef = FirebaseStorage.instance.ref();
      final imagesRef = storageRef.child('images/${DateTime.now()}.png');

      await imagesRef.putFile(_file!);

      final downloadUrl = await imagesRef.getDownloadURL();
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'email': FirebaseAuth.instance.currentUser?.email,
        'urlImage': downloadUrl,
        'username': event.username,
      });
      emit(
        UpdateAvatarState(
          isPickImage: false,
          file: _file,
        ),
      );
      print('---------------------$_file');
      getIt<EventBus>().fire(UpdateUser());
    } catch (e) {
      print('err update $e');
    }
  }

  _onPickImage(PickImage event, Emitter emit) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    _file = File(pickedFile?.path ??'');
    emit(
      UpdateAvatarState(
        file: _file,
        isPickImage: true,
      ),
    );
  }
}
