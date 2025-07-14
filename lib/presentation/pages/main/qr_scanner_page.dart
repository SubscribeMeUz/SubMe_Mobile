import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_pro/assets/assets.dart';
import 'package:gym_pro/components/custom_app_bar.dart';
import 'package:gym_pro/components/success_page.dart';
import 'package:gym_pro/config/enums/bloc_status.dart';
import 'package:gym_pro/config/router/route_name.dart';
import 'package:gym_pro/config/style/app_colors.dart';
import 'package:gym_pro/config/style/app_text_style.dart';
import 'package:gym_pro/config/utils/frequent_methods.dart';
import 'package:gym_pro/domain/entity/my_subscription_entity.dart';
import 'package:gym_pro/presentation/bloc/visit/visit_bloc.dart';
import 'package:gym_pro/presentation/pages/home/widgets/my_abonement_widget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> with WidgetsBindingObserver {
  final controller = MobileScannerController(autoStart: false);

  StreamSubscription<Object?>? _subscription;
  bool isFlashOn = false;
  @override
  void initState() {
    super.initState();
    // Start listening to lifecycle changes.
    WidgetsBinding.instance.addObserver(this);

    // Start listening to the barcode events.
    _subscription = controller.barcodes.listen(_handleBarcode);
    // Finally, start the scanner itself.
    unawaited(controller.start());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _subscription = controller.barcodes.listen(_handleBarcode);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  bool isScanned = false;
  void _handleBarcode(BarcodeCapture barcodes) async {
    if (mounted) {
      final providerId = barcodes.barcodes.firstOrNull?.rawValue;
      print('PROVIDER ID $providerId');
      if (providerId != null && isScanned == false) {
        isScanned = true;
        await controller.stop();
        if (mounted) {
          context.read<VisitBloc>().add(GetMyAbonementsOfProviderEvent(providerId: providerId));
        }
      }
    }
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await controller.dispose();
  }

  late final scanWindow = Rect.fromCenter(
    center: MediaQuery.sizeOf(context).center(Offset(0, -kToolbarHeight)),
    width: 250,
    height: 250,
  );

  showAbonsDialog(
    BuildContext context,
    List<MySubscriptionEntity> abonList,
    Function(int) onTapIndex,
  ) async {
    final isTapped = await showModalBottomSheet<bool?>(
      context: context,
      backgroundColor: context.colors.containerDark,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (innerContext) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 8,
              left: 16,
              right: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                abonList.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(innerContext, true);
                      onTapIndex(index);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: MyAbonementItemWidget(entity: abonList[0]),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    if (isTapped == null) {
      isScanned = false;
      controller.start();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VisitBloc, VisitState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) async {
        if (state.status == BlocStatus.error) {
          FrequentMethods.showSnackBar(context, state.errorMessage ?? '');
        } else if (state.status == BlocStatus.success) {
          final abonList = state.myAbonementsInProvider;

          if (state.providerId == null) {
            FrequentMethods.showSnackBar(context, 'Error, check QR code');
            context.pop();
            return;
          }
          if (abonList.isEmpty) {
            FrequentMethods.showAlertDialog(
              context,
              'Error',
              "You don't have any abonements from this provider",
              onYesTap: () {
                context.pop();
              },
            );
          } else if (abonList.length == 1) {
            context.read<VisitBloc>().add(
              SendVisitEvent(providerId: state.providerId!, abonementId: abonList.first.id),
            );
          } else if (abonList.length > 1) {
            showAbonsDialog(context, abonList, (i) {
              context.read<VisitBloc>().add(
                SendVisitEvent(providerId: state.providerId!, abonementId: abonList[i].id),
              );
            });
          }
        }
      },
      child: BlocListener<VisitBloc, VisitState>(
        listenWhen: (previous, current) => previous.visitStatus != current.visitStatus,
        listener: (context, state) {
          if (state.visitStatus == BlocStatus.success) {
            context.goNamed(
              RouteName.successRoute,
              extra: SuccessPageArgs(
                iconPath: Assets.svgSuccessTick,
                noIconPadding: true,
                title: 'The request has been received',
                subtitle: 'Today, the opportunities are on your side.',
                onSubmit: (successContext) {
                  successContext.goNamed(RouteName.homeRoute);
                },
                buttonText: 'Go to Home',
              ),
            );
          }
          if (state.visitStatus == BlocStatus.error) {
            FrequentMethods.showSnackBar(context, state.errorMessage ?? '');
            context.pop();
          }
        },
        child: Scaffold(
          appBar: CustomAppBar(),
          body: Stack(
            children: [
              MobileScanner(
                scanWindow: scanWindow,
                controller: controller,
                onDetect: _handleBarcode,
              ),

              ScanWindowOverlay(
                scanWindow: scanWindow,
                controller: controller,
                borderRadius: BorderRadius.circular(20),
                borderColor: context.colors.primaryColor,
                borderWidth: 4,
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height / 3.1 - kToolbarHeight,
                left: 0,
                right: 0,
                child: Text(
                  'Scan QR code',
                  textAlign: TextAlign.center,
                  style: context.textStyle.sfProSemiBold.copyWith(color: context.colors.whiteColor),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () async {
                    await controller.toggleTorch();
                    isFlashOn = !isFlashOn;
                    setState(() {});
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.colors.containerDark,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFlashOn ? Icons.flashlight_on_rounded : Icons.flashlight_off_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),

              BlocBuilder<VisitBloc, VisitState>(
                builder: (context, state) {
                  if (state.visitStatus == BlocStatus.loading ||
                      state.status == BlocStatus.loading) {
                    return IgnorePointer(
                      ignoring: true,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black.withAlpha(255 * 50),
                        child: CupertinoActivityIndicator(
                          color: context.colors.primaryColor,
                          radius: 30,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
