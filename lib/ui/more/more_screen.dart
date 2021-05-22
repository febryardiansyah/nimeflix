import 'package:flutter/material.dart';
import 'package:nimeflix/constants/BaseConstants.dart';

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
                    onTap: ()=>Navigator.pushNamed(context, rAboutApp),
                    child: Container(
                      child: Center(child: Text('About app'),),
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
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: Text('dikembangkan oleh Febry Ardiansyah',style: TextStyle(color: Colors.grey),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
