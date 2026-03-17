import 'package:flutter/material.dart';
import 'package:hydex/core/ui/type.dart';
import 'package:hydex/src/widgets/primary_btn.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgetResponse extends StatelessWidget {
  const ForgetResponse({super.key, this.isPhone = false});
  final bool isPhone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isPhone
            ? MessageResponse(
                onTap: () {
                  _launchUrl("https://wa.me/");
                },
                heading: "Check your WhatsApp",
                description:
                    "A reset link has been sent. Check your messages to reset your password",
                buttonText: 'Open Whatsapp',
              )
            : MessageResponse(
                onTap: () async {
                  final Uri emailLaunchUri = Uri(scheme: 'mailto', path: '');
                  if (await canLaunchUrl(emailLaunchUri)) {
                    await launchUrl(emailLaunchUri);
                  } else {
                    // Show error message
                  }
                },
                heading: "Check your Email",
                description:
                    "If the email exists, a reset link has been sent, check your inbox to reset your password.",
                buttonText: 'Open Email',
              ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url;');
    }
  }
}

class MessageResponse extends StatelessWidget {
  const MessageResponse({
    super.key,
    required this.heading,
    required this.description,
    required this.buttonText,
    required this.onTap,
  });

  final String heading, description, buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 210),
        Text(
          heading,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: AppTextStyles(context).accumulator * 30,
          ),
        ),
        Text(
          description,
          style: AppTextStyles(context).secondaryRegular.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        Spacer(),
        PrimaryButton(onTap: () async => onTap(), title: buttonText),
      ],
    );
  }
}
