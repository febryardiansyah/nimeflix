import 'package:flutter/material.dart';

class DetailAnime extends StatefulWidget {
  DetailAnime({Key key}) : super(key: key);

  @override
  _DetailAnimeState createState() => _DetailAnimeState();
}

class _DetailAnimeState extends State<DetailAnime> {
  Size _size;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      // bottomNavigationBar: DraggableScrollableSheet(
      //   initialChildSize: 0.05,
      //   maxChildSize: 0.4,
      //   minChildSize: 0.05,
      //   builder: (context,scrollCtrl){
      //     return Container(
      //       color: Colors.red,
      //       child: ListView.builder(
      //         itemCount: 20,
      //         controller: scrollCtrl,
      //         itemBuilder: (context,i)=>Text('a $i'),
      //       ),
      //     );
      //   },
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: _size.width,
                  height: _size.height * 0.4,
                ),
                Container(
                  width: _size.width,
                  height: _size.height * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://zetizen.radarcirebon.com/wp-content/uploads/2020/09/CSGO.jpg'),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(0.6),
                    child: Icon(Icons.bookmark_border,color: Colors.white,),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: _size.height * 0.15),
                    width: 100,
                    height: 140,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage('https://zetizen.radarcirebon.com/wp-content/uploads/2020/09/CSGO.jpg'),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Text('Counter Strike Global Offensive',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20,left: 10,right: 10),
              child: Table(
                children: [
                  TableRow(
                    children: [
                      TableCell(child: Text('Judul jepang'),),
                      TableCell(child: Text(': フルーツバスケット The Final'),),
                    ]
                  ),
                  TableRow(
                      children: [
                        TableCell(child: Text('Score'),),
                        TableCell(child: Text(': 9.92'),),
                      ]
                  ),
                  TableRow(
                      children: [
                        TableCell(child: Text('Studio'),),
                        TableCell(child: Text(': Kaedenoki'),),
                      ]
                  ),
                  TableRow(
                      children: [
                        TableCell(child: Text('Status'),),
                        TableCell(child: Text(': complete'),),
                      ]
                  ),
                  TableRow(
                      children: [
                        TableCell(child: Text('Duration'),),
                        TableCell(child: Text(': 1 tahun'),),
                      ]
                  ),
                  TableRow(
                      children: [
                        TableCell(child: Text('Tanggal rilis'),),
                        TableCell(child: Text(': 69 januari 2020'),),
                      ]
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: Text('Sinopsis',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
              child: Text('''Setelah 2000 tahun berlalu, raja iblis yang dulunya kejam direinkarnasi kembali. Namun bakatnya di akademi untuk menjadi kandidat raja iblis dikatakan tidak layak. Dahulu ia mampu menghancurkan manusia, elemental, dan dewa.

Setelah melalui pertarungan panjang, Arnos sang raja iblis muak dan lelah dengan hal tersebut. Ia merindukan dunia  yang damai dan memutuskan untuk bereinkarnasi ke masa depan. Namun apa yang menanti setelah ia reikarnasi adalah dunia yang biasa yang penuh dengan kedamaian sehingga keturunannya menjadi terlalu lemah karena melemahnya kekuatan sihir.'''),
            )
          ],
        ),
      ),
    );
  }
}