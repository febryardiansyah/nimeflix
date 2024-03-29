import 'package:flutter/material.dart';
import 'package:nimeflix/constants/BaseConstants.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../routes.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(BaseConstants.wallpaper),
                  fit: BoxFit.cover
                )
              ),
              child: Center(
                child: Container(
                  width: 150,
                  height: 70,
                  padding: EdgeInsets.all(10),
                  child: Image.asset(BaseConstants.logoAsset,fit: BoxFit.contain,width: 140,height: 60,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: GridView(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 7,crossAxisSpacing: 7,childAspectRatio: 4),
                children: [
                  GestureDetector(
                    // onTap: ()=>Navigator.pushNamed(context, rAboutApp),
                    onTap: (){
                      showAboutDialog(
                        context: context,
                        applicationName: 'Nimeflix',
                        applicationVersion: 'Versi: ${BaseConstants.appVersion}',
                        applicationIcon: Image.asset('assets/images/icon.png',height: 32,width: 32),
                      );
                    },
                    child: Container(
                      child: Center(child: Text('Tentang Aplikasi'),),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.transparent,
                        border: Border.all(color: Colors.orange)
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=>Navigator.pushNamed(context, rPrivacyPolicy),
                    child: Container(
                      child: Center(child: Text('Privacy Policy'),),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                          border: Border.all(color: Colors.orange)
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=>Navigator.pushNamed(context, rTOS),
                    child: Container(
                      child: Center(child: Text('Terms & Conditions'),),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                          border: Border.all(color: Colors.orange)
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()async{
                      await Share.share('Mau nonton anime gratis? Ayoo download aplikasi Nimelix -  Nonton Anime Subtitle Indonesia Gratis https://play.google.com/store/apps/details?id=com.febryardiansyah.nimeflix');
                    },
                    child: Container(
                      child: Center(child: Text('Bagikan Aplikasi'),),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                          border: Border.all(color: Colors.orange)
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, rHistoryAnime);
                    },
                    child: Container(
                      child: Center(child: Text('Terakhir dilihat'),),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                          border: Border.all(color: Colors.orange)
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()async{
                      await launch('mailto:februmuhammad80@gmail.com?subject=Laporan Bug Aplikasi Nimeflix&body=Hi Admin, saat menggunakan aplikasi Nimeflix saya menemukan beberapa masalah :');
                    },
                    child: Container(
                      child: Center(child: Text('Laporkan Bug'),),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                          border: Border.all(color: Colors.orange)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
