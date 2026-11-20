import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/constants/app_constants.dart';
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

  static const double _frameSize = 250;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    final raw =
        capture.barcodes.isEmpty ? null : capture.barcodes.first.rawValue;

    switch (_vm.handleScan(raw)) {
      case ValidScan(:final machine):
        _openMachine(machine);
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
          Positioned(
            left: AppSpacing.md,
            right: AppSpacing.md,
            bottom: AppSpacing.xl,
            child: Text(
              'Makine üzerindeki QR kodu okut',
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
