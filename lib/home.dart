import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:textts/SignIn/signin.dart';

class Home extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

enum TtsState { playing, stopped }

class _MyAppState extends State<Home> {
  FlutterTts flutterTts;
  dynamic schs;
  dynamic languages;
  dynamic voices;
  String language;
  String voice;
  String sch;

  String _newVoiceText;
   var sScheme = {'name': 'Scheme 1', 'sch': 'The birch canoe slid on the smooth planks', 'jeet' : 'jeet hamara neetaa hai ' };
  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;

  @override
  initState() {
    super.initState();
    initTts();
 

  }

  initTts() {
    flutterTts = FlutterTts();
     Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }
    //flutterTts.speak("bhai bhai");
    //flutterTts.setLanguage('hi-IN');
    getSchemeItems();
    _getLanguages();
        
        _getVoices();
  //  if (Platform.isAndroid) {
    //  flutterTts.speak("bitch lasagna");
    //   flutterTts.ttsInitHandler(() {
    //     flutterTts.speak('language list mila');

    //     getSchemeItems();
    //     _getLanguages();
        
    //     _getVoices();
    //   });
    // } else if (Platform.isIOS) {
    //   _getLanguages();
    //   _getVoices();
    // }

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }

  Future _getVoices() async {
    voices = await flutterTts.getVoices;
    if (voices != null) setState(() => voices);
  }

  Future _speak() async {
    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        var result = await flutterTts.speak(_newVoiceText);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }
   
  List<DropdownMenuItem<String>> getSchemeItems() {
    var items = List<DropdownMenuItem<String>>();
    for (String abc in sScheme.keys )
    {
      items.add(DropdownMenuItem(value: abc, child: Text(abc)));
    }
    return items;
  }

   List<DropdownMenuItem<String>> getLanguageDropDownMenuItems() {
    var items = List<DropdownMenuItem<String>>();
    //print(languages.length);
    for (String type in languages) {
      //print(type);
      items.add(DropdownMenuItem(value: type, child: Text(type)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getVoiceDropDownMenuItems() {
    var items = List<DropdownMenuItem<String>>();
    for (String type in voices) {
      items.add(DropdownMenuItem(value: type, child: Text(type)));
    }
    return items;
  }

  void changedSchemeDropDownItem(String scheme){
    setState(() {
      sch = scheme;
      _newVoiceText = sScheme[scheme];
    });
  }

  void changedLanguageDropDownItem(String selectedType) {
    setState(() {
      language = selectedType;
      flutterTts.setLanguage(language);
    });
  }

  void changedVoiceDropDownItem(String selectedType) {
    setState(() {
      voice = selectedType;
      flutterTts.setVoice(voice);
    });
  }

  // void _onChange(String text) {
  //   setState(() {
  //     _newVoiceText = text;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  home:// LoginPage()
        //  Scaffold(
            appBar: AppBar(
              title: Text('Flutter TTS'),
            ),
            body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  // inputSection(),
                  btnSection(),
                   schemeDropDownSection() ,
                 languages != null ? languageDropDownSection() : Text(""),
                //voiceDropDownSection() 
                ]))
                );
  }

  // Widget inputSection() => Container(
  //     alignment: Alignment.topCenter,
  //     padding: EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
  //     child: TextField(
  //       onChanged: (String value) {
  //         _onChange(value);
  //       },
  //     ));

  Widget btnSection() => Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _buildButtonColumn(
            Colors.green, Colors.greenAccent, Icons.play_arrow, 'PLAY', _speak),
        _buildButtonColumn(
            Colors.red, Colors.redAccent, Icons.stop, 'STOP', _stop)
      ]));

  Widget schemeDropDownSection() => Container(
    padding: EdgeInsets.only(top: 50.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        DropdownButton(
         value: sch,
         items: getSchemeItems(),
        onChanged: changedSchemeDropDownItem,
        )
      ])

  );

  Widget languageDropDownSection() => Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        DropdownButton(
          value: language,
          items: getLanguageDropDownMenuItems(),
          onChanged: changedLanguageDropDownItem,
        )
      ]));

  Widget voiceDropDownSection() => Container(
      padding: EdgeInsets.only(top: 50.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        DropdownButton(
          value: voice,
          items: getVoiceDropDownMenuItems(),
          onChanged: changedVoiceDropDownItem,
        )
      ]));

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(icon),
              color: color,
              splashColor: splashColor,
              onPressed: () => func()),
          Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Text(label,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: color)))
        ]);
  }
}