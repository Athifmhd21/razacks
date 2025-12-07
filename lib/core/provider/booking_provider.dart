import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingProvider with ChangeNotifier {
  Future<void> callNumber(String number) async {
    final Uri callUri = Uri(scheme: 'tel', path: number);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'Could not launch $number';
    }
  }

  Future<void> openWhatsApp(String number, String message) async {
    final String encodedMessage = Uri.encodeComponent(message);

    const String whatsappPackage = "com.whatsapp";

    final Uri whatsappUri = Uri.parse(
      "whatsapp://send?phone=$number&text=$encodedMessage",
    );

    // Try launching WhatsApp directly
    final bool canOpenWhatsapp = await canLaunchUrl(whatsappUri);

    if (canOpenWhatsapp) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      // Web fallback
      final Uri webFallback = Uri.parse(
        "https://wa.me/$number?text=$encodedMessage",
      );
      if (await canLaunchUrl(webFallback)) {
        await launchUrl(webFallback, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not open WhatsApp or web fallback';
      }
    }
  }
}
