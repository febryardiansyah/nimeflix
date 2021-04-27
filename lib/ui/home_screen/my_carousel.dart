import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MyCarousel extends StatefulWidget {
  MyCarousel({Key key}) : super(key: key);

  @override
  _MyCarouselState createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              }
          ),
          items: [
            'https://zetizen.radarcirebon.com/wp-content/uploads/2020/09/CSGO.jpg',
            'https://zetizen.radarcirebon.com/wp-content/uploads/2020/09/CSGO.jpg',
            'https://zetizen.radarcirebon.com/wp-content/uploads/2020/09/CSGO.jpg',
          ].map((e) {
            return InkWell(
              onTap: (){

              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(e),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Center(child: Text(e,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                            colors: [
                              Colors.black,
                              Colors.black.withOpacity(0.4)
                            ]
                        )
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        Row(
          children: List.generate(3, (index){
            return Container(
              width: 8,height: 8,
              margin: EdgeInsets.only(left: 6,top: 10,bottom: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index?Colors.orange:Colors.grey
              ),
            );
          }),
        )
      ],
    );
  }
}