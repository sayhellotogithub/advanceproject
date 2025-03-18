// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/18
// Description: 
// -------------------------------------------------------------------
import 'package:url_launcher/url_launcher.dart';
void openWebPage(Uri url) async {
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}
