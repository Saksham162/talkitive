import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


import './call.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Talkitive'),
      ),
      body: SingleChildScrollView(
              child: Center(



                 child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 400,
            child: Column(
              children: <Widget>[

                SizedBox(height: 12,),

                Text(
                  "Dev by S25Sol. (SAKSHAM)",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.red
                  ),

                ),


              Text(
                  "MADE IN INDIA",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.red
                  ),

                ),

//Image(
//  image: NetworkImage("https://cdn3.iconfinder.com/data/icons/finalflags/256/India-Flag.png" )
  


  
  
  //),


  Image.network(
    "https://cdn3.iconfinder.com/data/icons/finalflags/256/India-Flag.png",
    fit: BoxFit.contain,
    height: 30,
    width: 30,
    
    
    ),

                SizedBox(height: 28,),


                Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                      controller: _channelController,
                      decoration: InputDecoration(
                        errorText:
                            _validateError ? 'Channel name is mandatory' : null,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                        hintText: 'Channel name',
                      ),
                    ))
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                     // title: Text(ClientRole.Broadcaster.toString()),
                     title: Text('Act as a Broadcaster'),
                      leading: Radio(
                        value: ClientRole.Broadcaster,
                        groupValue: _role,
                        onChanged: (ClientRole value) {
                          setState(() {
                            _role = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                     // title: Text(ClientRole.Audience.toString()),
                     
                     title: Text('Act as a Audience'),
                      leading: Radio(
                        value: ClientRole.Audience,
                        groupValue: _role,
                        onChanged: (ClientRole value) {
                          setState(() {
                            _role = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  
                  child: Container(
                    
                  
                  child: Row(
                    children: <Widget>[

                     
                      Expanded(
                        child: RaisedButton(
                          onPressed: onJoin,
                          child: Text('Join'),
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          
                        ),

                     

                      )
                 







                  

                    ],
                   
                  ),

              
                )

                )
                                       
              ],
            ),

           
          ),

     




        



                 
    ),
      )
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: _role,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
