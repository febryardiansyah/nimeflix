import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nimeflix/bloc/get_home/get_home_cubit.dart';
import 'package:nimeflix/routes.dart';
import 'package:nimeflix/widgets/my_shimmer.dart';

class MyCarousel extends StatefulWidget {
  MyCarousel({Key key}) : super(key: key);

  @override
  _MyCarouselState createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetHomeCubit,GetHomeState>(
      builder:(context,state){
        if (state is GetHomeLoading) {
          return MyCarouselShimmer();
        }
        if (state is GetHomeFailure) {
          return Text(state.msg);
        }
        if (state is GetHomeSuccess) {
          final _data = state.ongoingData;
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
                items: _data.map((e) {
                  return InkWell(
                    onTap: (){
                      print(e.id);
                      Navigator.pushNamed(context, rDetailAnime,arguments: e.id);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 500,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(e.thumb),
                                fit: BoxFit.cover
                            )
                        ),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Center(child: Text(e.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,)),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: _data.map((e){
                  int index = _data.indexOf(e);
                  return Container(
                    width: _currentIndex == index?14:8,
                    height: 8,
                    margin: EdgeInsets.only(left: 6,top: 10,bottom: 10),
                    decoration: BoxDecoration(
                        shape: _currentIndex == index?BoxShape.rectangle:BoxShape.circle,
                        color: _currentIndex == index?Colors.orange:Colors.grey,
                        borderRadius: _currentIndex == index?BorderRadius.circular(4):null 
                    ),
                  );
                }).toList(),
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}

class MyCarouselShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyShimmer(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(8),
        height: 150,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8)
        ),
      ),
    );
  }
}
