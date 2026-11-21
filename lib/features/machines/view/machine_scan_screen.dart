import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_constants.dart';
import '../../auth/viewmodel/auth_viewmodel.dart';
import '../../gate_entry/repository/gate_repository.dart';
import '../../gate_entry/viewmodel/gate_entry_viewmodel.dart';
import '../model/machine.dart';
import '../viewmodel/machine_scan_viewmodel.dart';
import 'machine_detail_screen.dart';

/// Tara sekmesi: kamera ile makine QR kodu okuma.
class MachineScanScreen extends StatefulWidget {
  const MachineScanScreen({super.key});

  @override
  State<MachineScanScreen> createState() => _MachineScanScreenState();
}

class _MachineScanScreenState extends State<MachineScanScreen> {
  final _controller = MobileScannerController();
  final _vm = MachineScanViewModel();
  late final GateEntryViewModel _gateVm;

  static const double _frameSize = 250;

  @override
  void initState() {
    super.initState();
    _gateVm = GateEntryViewModel(
      repository: context.read<GateRepository>(),
      userId: context.read<AuthViewModel>().currentUserId!,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _gateVm.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    final raw = capture.barcodes.isEmpty
        ? null
        : capture.barcodes.first.rawValue;

    switch (_vm.handleScan(raw)) {
      case ValidScan(:final machine):
        _openMachine(machine);
      case GateScan(:final gate):
        _handleGate(gate.gymId);
      case InvalidScan():
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(const SnackBar(content: Text('Geçersiz QR kodu')));
      case IgnoredScan():
        break;
    }
  }

  /// Kamerayı durdur, detaya git; geri dönünce kamerayı yeniden başlat.
  Future<void> _openMachine(Machine machine) async {
    await _controller.stop();
    if (!mounted) return;

    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => MachineDetailScreen(machine: machine)),
    );

    if (!mounted) return;
    _vm.resume();
    await _controller.start();
  }

  /// Turnike QR'ı: giriş/çıkış yap ve sonucu göster. Kamera açık kalır;
  /// aynı kodun tekrar sayılmasını GateEntryViewModel engeller.
  Future<void> _handleGate(String gymId) async {
    final message = await _gateVm.handleGate(gymId);
    if (!mounted) return;

    if (message != null) {
      final scheme = Theme.of(context).colorScheme;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: message.isError ? scheme.errorContainer : null,
            content: Row(
              children: [
                Icon(
                  message.isError ? Icons.error_outline : Icons.check_circle,
                  color: message.isError
                      ? scheme.onErrorContainer
                      : scheme.inversePrimary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    message.text,
                    style: message.isError
                        ? TextStyle(color: scheme.onErrorContainer)
                        : null,
                  ),
                ),
              ],
            ),
          ),
        );
    }
    _vm.resume();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Tara')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
            errorBuilder: _buildError,
          ),
          // Ortadaki kare tarama çerçevesi
          Center(
            child: Container(
              width: _frameSize,
              height: _frameSize,
              decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.primary, width: 3),
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              ),
            ),
          ),
          // Turnike işlemi sürerken yükleniyor göstergesi
          ListenableBuilder(
            listenable: _gateVm,
            builder: (context, _) => _gateVm.isProcessing
                ? const ColoredBox(
                    color: Colors.black54,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox.shrink(),
          ),
          Positioned(
            left: AppSpacing.md,
            right: AppSpacing.md,
            bottom: AppSpacing.xl,
            child: Text(
              'Makine ya da turnike QR kodunu okut',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                shadows: const [Shadow(blurRadius: 4)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Kamera açılamazsa (ör. izin reddedildi) gösterilecek ekran.
  Widget _buildError(BuildContext context, MobileScannerException error) {
    final isPermission =
        error.errorCode == MobileScannerErrorCode.permissionDenied;

    final message = isPermission
        ? 'Kamera izni verilmedi.\n\nMakine QR kodlarını okutabilmek için '
              'telefonunun Ayarlar > Uygulamalar > FitPulse QR > İzinler '
              'bölümünden kamera iznini aç.'
        : 'Kamera açılamadı. Lütfen tekrar dene.';

    return ColoredBox(
      color: AppColors.background,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isPermission ? Icons.no_photography : Icons.error_outline,
                size: 64,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.lg),
              FilledButton(
                onPressed: () => _controller.start(),
                child: const Text('Tekrar dene'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
