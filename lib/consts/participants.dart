import 'package:flutter/material.dart';

List<Map<String, dynamic>> participants = [
    {
      "name": "Richard Hendricks",
      "image":
          "https://d2ekxuuyaakxli.cloudfront.net/media/public/images/thomas-2016-04-08T01-12-49-483Z.jpg",
      "party-image":"https://ih1.redbubble.net/image.538431168.1686/flat,750x1000,075,f.u4.jpg",
      "party":"Pied Piper"
    },
    {
      "name": "Mark Zuckerberg",
      "image":
          "https://i.insider.com/5ec7fcf62618b96a58135c38?width=700",
      "party-image":"https://1000logos.net/wp-content/uploads/2021/04/Facebook-logo.png",
      "party":"Facebook"
    },
    {
      "name":"Elon Musk",
      "image":"https://static.theceomagazine.net/wp-content/uploads/2018/10/15093202/elon-musk.jpg",
      "party-image":"https://www.logodesignlove.com/images/monograms/tesla-symbol.jpg",
      "party":"Tesla"
    },
    {
      "name":"Steve Jobs",
      "image":"https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Steve_Jobs_Headshot_2010-CROP_%28cropped_2%29.jpg/330px-Steve_Jobs_Headshot_2010-CROP_%28cropped_2%29.jpg",
      "party-image":"https://cdn-0.idownloadblog.com/wp-content/uploads/2018/07/Apple-logo-black-and-white.png",
      
      "party":"Apple"
    },
    
  ];
  List<Map<String,dynamic>> headerValues = [
    {
      "header":"Current IP address should be used while voting",
      "icon":Icons.network_wifi,
      "body":"You current IP address (Intrenet Connection) will be registered and you must be connected to this connection in order to vote"
    },{
      "header":"Vote from current location",
      "icon":Icons.location_on,
      "body":"You must be close to your current location in order to vote.You cannot change your location while voting"
    },{
      "header":"Current device must be used to vote",
      "icon":Icons.phone_android,
      "body":"You cannot change your device used to vote once you have registered to vote. The app registers your MAC address and will verify it while voting"
    }
  ];