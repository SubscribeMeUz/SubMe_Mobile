import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_pro/components/bottom_button_bar.dart';
import 'package:gym_pro/components/custom_app_bar.dart';
import 'package:gym_pro/components/custom_text_field.dart';
import 'package:gym_pro/config/enums/bloc_status.dart';
import 'package:gym_pro/config/mixin/logout_mixin.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/config/utils/frequent_methods.dart';
import 'package:gym_pro/domain/entity/user_entity.dart';
import 'package:gym_pro/presentation/bloc/user/user_bloc.dart';
import 'package:gym_pro/presentation/pages/profile/widgets/avatar_widget.dart';

class EditProfilePage extends StatefulWidget {
  final UserEntity userEntity;
  const EditProfilePage({super.key, required this.userEntity});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> with LogoutMixin {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userEntity.fullName);
    _phoneController = TextEditingController(text: widget.userEntity.phone);
    _usernameController = TextEditingController(text: widget.userEntity.username);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.status == BlocStatus.error && state.errorMessage != null) {
          FrequentMethods.showSnackBar(context, state.errorMessage!);
        } else if (state.status == BlocStatus.success) {
          context.pop(true);
        }
      },

      child: Scaffold(
        appBar: CustomAppBar(
          actions: [
            GestureDetector(
              onTap: () async {
                FrequentMethods.showAlertDialog(
                  context,
                  'Log out',
                  'Are you sure you want to log out?',
                  noButtonText: 'Cancel',
                  yesButtonText: 'Yes, Log out',
                  onYesTap: () async {
                    await logout();
                  },
                );
              },
              behavior: HitTestBehavior.opaque,
              child: Text(
                'Exit',
                style: context.textStyle.sfProRegular.copyWith(
                  color: context.colors.redColor,
                  fontSize: 17,
                ),
              ),
            ),
            const Gap(16),
          ],
        ),
        bottomNavigationBar: BlocBuilder<UserBloc, UserState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            return BottomButtonBar(
              onTap: () {
                context.read<UserBloc>().add(UpdateUserEvent());
              },
              buttonText: 'Done',
              isLoading: state.status == BlocStatus.loading,
            );
          },
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(48),
              Center(
                child: AvatarWidget(letter: widget.userEntity.fullName?.substring(0, 1) ?? ''),
              ),
              const Gap(24),
              Text(
                'Name',
                style: context.textStyle.sfProRegular.copyWith(color: context.colors.whiteColor),
              ),
              const Gap(4),
              CustomTextField(controller: _nameController),
              const Gap(16),
              Text(
                'Phone',
                style: context.textStyle.sfProRegular.copyWith(color: context.colors.whiteColor),
              ),
              const Gap(4),
              CustomTextField(controller: _phoneController),
              const Gap(16),
              Text(
                'Username',
                style: context.textStyle.sfProRegular.copyWith(color: context.colors.whiteColor),
              ),
              const Gap(4),
              CustomTextField(controller: _usernameController),
            ],
          ),
        ),
      ),
    );
  }
}
