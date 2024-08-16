import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sozluk/sozluk.dart';

void main() => runApp(MaterialApp(
      title: "Kelime Uygulaması",
      home: AnaEkran(),
    ));

class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key}) : super(key: key);

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  final sozluk = Sozluk().dictionary;
  final sozluk2 = Sozluk().zemberek;
  final AudioPlayer audioPlayer = AudioPlayer();

  String sonuc = "";
  String kelime = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Kelime Uygulaması",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color(0xff021b03),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                kelime = value;
              },
              decoration: InputDecoration(
                hintText: 'Kelimeyi girin',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            IconButton(
                onPressed: () async {
                  var answer = await sozluk.meaning(kelime); // Anlamı
                  setState(() {
                    sonuc = answer;
                  });
                },
                icon: Icon(Icons.search),
                tooltip: 'Kelimenin Anlamı'),
            IconButton(
                onPressed: () async {
                  var answer = await sozluk.proverb(kelime); // Atasözü
                  setState(() {
                    sonuc = answer;
                  });
                },
                icon: Icon(Icons.format_quote),
                tooltip: 'Atasözü'),
            IconButton(
                onPressed: () async {
                  var url =
                      await fetchAudioUrl(kelime); // ses dosyasının URL'si
                  await playAudio(url); // Ses
                },
                icon: Icon(Icons.audiotrack),
                tooltip: 'Ses'),
            SizedBox(height: 20),
            Text(
              sonuc,
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  Future<String> fetchAudioUrl(String kelime) async {
    var answer = await sozluk.audioUrl(kelime);
    return answer;
  }

  Future<void> playAudio(String url) async {
    int result = await audioPlayer.play(url, isLocal: false);
    if (result == 1) {
      // Ses başarıyla çalındı
    } else {
      // Ses çalma başarısız oldu
    }
  }
}
