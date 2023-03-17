import 'package:flutter/material.dart';

class ReconnectButton extends StatelessWidget {
  final String msg;
  final Function onReconnect;

  const ReconnectButton({Key key, this.msg, this.onReconnect}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(msg),
        Padding(
          padding: EdgeInsets.only(top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('Kembali'),
                // color: Colors.transparent,
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),side: BorderSide(color: Colors.white)),
                onPressed: ()=>Navigator.pop(context),
              ),
              ElevatedButton(
                child: Text('Muat ulang',style: TextStyle(color: Colors.red),),
                // color: Colors.transparent,
                // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),side: BorderSide(color: Colors.red)),
                onPressed: onReconnect,
              ),
            ],
          ),
        )
      ],
    );
  }
}
