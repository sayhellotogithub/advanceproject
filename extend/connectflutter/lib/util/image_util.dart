// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/03/14
// Description:
// -------------------------------------------------------------------

class ImageUtil {
  static final iconPath = "assets/icon/";
  static final imagePath = "assets/image/";

  static getIconString(String fileName, {String format = 'svg'}) {
    return "$iconPath$fileName.$format";
  }

  static getImageString(String fileName, {String format = 'png'}) {
    return "$imagePath$fileName.$format";
  }
}
