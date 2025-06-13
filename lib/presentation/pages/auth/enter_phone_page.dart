import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_pro/components/bottom_button_bar.dart';
import 'package:gym_pro/components/custom_app_bar.dart';
import 'package:gym_pro/components/custom_text_field.dart';
import 'package:gym_pro/config/enums/bloc_status.dart';
import 'package:gym_pro/config/localisation/app_localisation.dart';
import 'package:gym_pro/config/localisation/localisation_keys.dart';
import 'package:gym_pro/config/router/route_name.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/config/utils/frequent_methods.dart';
import 'package:gym_pro/presentation/bloc/auth/auth_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EnterPhonePage extends StatefulWidget {
  const EnterPhonePage({super.key});

  @override
  State<EnterPhonePage> createState() => _EnterPhonePageState();
}

class _EnterPhonePageState extends State<EnterPhonePage> {
  final _phoneController = TextEditingController();
  late final MaskTextInputFormatter phoneFormatter;

  @override
  void initState() {
    super.initState();
    phoneFormatter = MaskTextInputFormatter(mask: '## ###-##-##', filter: {'#': RegExp(r'[0-9]')});
  }

  @override
  void dispose() {
    _phoneController.dispose();
    phoneFormatter.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == BlocStatus.failure) {
          FrequentMethods.showSnackBar(context, state.errorMessage ?? '');
        } else if (state.status == BlocStatus.success) {
          context.goNamed(
            RouteName.confirmAuthRoute,
            extra: '998${phoneFormatter.getUnmaskedText()}',
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(),
        bottomNavigationBar: BottomButtonBar(
          buttonText: context.tr(LocalisationKeys.start),
          onTap: () {
            final phoneNumber = phoneFormatter.getUnmaskedText();
            context.read<AuthBloc>().add(SendPhoneNumberEvent(phone: '998$phoneNumber'));
          },
        ),
        body: Column(
          children: [
            const Gap(16),
            Text(
              context.tr(LocalisationKeys.phone_number),
              style: context.textStyle.sfProBold.copyWith(
                color: context.colors.whiteColor,
                fontSize: 28,
              ),
            ),
            const Gap(8),
            Text(
              context.tr(LocalisationKeys.code_for_verification),
              style: context.textStyle.sfProMedium.copyWith(
                color: context.colors.disabledColor.withAlpha(70),
                fontSize: 16,
              ),
            ),
            const Gap(32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomTextField(
                controller: _phoneController,
                isFocused: true,
                prefixText: '+998 ',
                labelText: context.tr(LocalisationKeys.phone_number),
                inputType: TextInputType.phone,
                inputFormatters: [phoneFormatter],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
