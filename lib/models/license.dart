import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screen_util.dart';

class License extends LicenseEntry{
  final packages;
  final paragraphs;

  License(this.packages, this.paragraphs);

  static load() {
    addLicense();
  }

  static void showLicensePage ({
      @required BuildContext context,
      String applicationName,
      String applicationVersion,
      Widget applicationIcon,
      String applicationLegalese,
      bool useRootNavigator = false,
    }) {
      Navigator.of(context, rootNavigator: useRootNavigator).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => 
          Theme(
            data: ThemeData(
              primaryColor: Colors.blue,
              appBarTheme: AppBarTheme(
                elevation: 1,
                color: Colors.white,
                iconTheme: IconThemeData(
                  color: Colors.black54,
                ),
                textTheme: TextTheme(
                  headline6: TextStyle(
                    fontSize: ScreenUtil().setSp(18),
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            child: LicensePage(
              applicationName: applicationName,
              applicationVersion: applicationVersion,
              applicationIcon: applicationIcon,
              applicationLegalese: applicationLegalese,
            ),
          )

    ));
  }

}

// Future<Stream<LicenseEntry>> licenses() async {

//   return Stream<LicenseEntry>.fromIterable(<LicenseEntry>[
//     const LicenseEntryWithLineBreaks(<String>['flaticon'], 'Icons made by iconixar from Flaticon')
//     //const LicenseEntryWithLineBreaks(<String>['pirate package'], 'pirate license')
//   ]);
// }

void addLicense(){

  LicenseRegistry.addLicense(()async * {
    final googleFonts = await rootBundle.loadString('assets/licenses/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], googleFonts);
  });

  LicenseRegistry.addLicense(() async * {
    yield LicenseEntryWithLineBreaks(['flaticon'], 'Icons made by iconixar from Flaticon at: https://www.flaticon.com/authors/iconixar');
  });
}