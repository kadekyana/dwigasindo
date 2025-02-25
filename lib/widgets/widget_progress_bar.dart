import 'package:dwigasindo/const/const_color.dart';
import 'package:dwigasindo/const/const_font.dart';
import 'package:dwigasindo/providers/provider_distribusi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WidgetProgressBar extends StatelessWidget {
  const WidgetProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderDistribusi>(
      builder: (context, progressNotifier, child) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            LinearProgressIndicator(
              value: progressNotifier.progress,
              backgroundColor: SECONDARY_COLOR,
              color: const Color.fromARGB(255, 41, 53, 148),
              minHeight: 25,
              borderRadius: BorderRadius.circular(12),
            ),
            Center(
              child: SizedBox(
                height: 25,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Progress ${(progressNotifier.progress * 100).toStringAsFixed(0)}%',
                    style: minisubtitleText,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
