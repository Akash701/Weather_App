import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Josefin Slab',
  fontSize: 140,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 50.0,
);
const kTextfieldProperty = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: ('Enter city name'),
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
);
