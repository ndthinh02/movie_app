import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:movie_app/commom/widgets/button.dart';
import 'package:movie_app/commom/widgets/text_filed.dart';
import 'package:movie_app/config/colors/app_colors.dart';

import '../../../../core/constant/constants.dart';
import '../bloc/setting_bloc.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key, this.username, this.urlImage});

  final String? urlImage;
  final String? username;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  File? _file;

  @override
  void initState() {
    super.initState();
    _userNameController.text = widget.username ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: const Text("Your Account")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _keyForm,
            child: BlocListener<SettingBloc, SettingState>(
              listener: _handleStateChanges,
              child: Column(
                children: [
                  _buildAvatar(context),
                  const SizedBox(height: 40),
                  _buildUsernameField(text),
                  const SizedBox(height: 30),
                  _buildSaveButton(context, text)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleStateChanges(BuildContext context, SettingState state) {
    if (state is UpdateAvatarState && state.isPickImage == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Update successfully!')),
      );
    }
  }

  Widget _buildCircleAvatar(File? file, String? urlImage) {
    return CircleAvatar(
      radius: 60,
      backgroundImage: file != null
          ? Image.file(File(file.path).absolute).image
          : NetworkImage(urlImage ?? defaultImg),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return InkWell(
      onTap: () => context.read<SettingBloc>().add(PickImage()),
      child: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          _file = (state is UpdateAvatarState) ? state.file : _file;
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _buildCircleAvatar(_file, widget.urlImage),
              const Align(
                child: Icon(Icons.camera_alt_outlined, size: 20),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUsernameField(AppLocalizations text) {
    return AppTextFiled(
      height: 90,
      controller: _userNameController,
      validator: (value) => value!.isEmpty ? text.do_not_empty : null,
      labelText: text.username,
      prefixIcon: Icons.person,
    );
  }

  Widget _buildSaveButton(BuildContext context, AppLocalizations text) {
    return AppButtonAccount(
      onTap: () {
        if (_keyForm.currentState!.validate()) {
          context.read<SettingBloc>().add(
                UpdateAvatar(username: _userNameController.text),
              );
        }
      },
      title: text.save,
      backGrColor: AppColors.colorGreen,
    );
  }
}
