// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cerita Rakyat Indonesia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CeritaRakyatPage(),
    );
  }
}

class CeritaRakyatPage extends StatefulWidget {
  @override
  _CeritaRakyatPageState createState() => _CeritaRakyatPageState();
}

class _CeritaRakyatPageState extends State<CeritaRakyatPage> {
  final String judul =
      "Danau Toba"; // Ubah judul sesuai cerita rakyat yang dipilih

  final String ringkasanCerita =
      "Danau Toba adalah cerita tentang asal mula danau yang terbentuk dari bekas letusan gunung berapi. "
      "Di zaman dahulu kala, di sebuah kerajaan di pedalaman Sumatera Utara, hiduplah seorang raja yang memiliki seorang putri cantik bernama Putri Toba. "
      "Suatu hari, kerajaan tersebut diserang oleh musuh dari kerajaan tetangga. Raja yang khawatir akan keselamatan putrinya memerintahkan agar Putri Toba disembunyikan di tempat yang aman. "
      "Namun, dalam kekacauan perang, Putri Toba terpisah dari pengawalnya dan terjatuh ke dalam jurang. "
      "Ternyata, jurang tersebut merupakan lubang bekas letusan gunung berapi yang besar. Air hujan pun terus mengisi lubang tersebut, membentuk danau yang sangat luas. "
      "Putri Toba yang terjatuh ke dalam lubang itu berubah menjadi ikan mas yang cantik. "
      "Hingga kini, danau yang terbentuk dari bekas lubang letusan gunung berapi itu dikenal sebagai Danau Toba, salah satu danau terbesar di dunia yang memiliki legenda dan keindahan alam yang memukau. ";

  final String audioPath =
      "Audio/DanauToba.mp3"; // Ubah path sesuai dengan lokasi file audio

  late AudioPlayer audioPlayer;
  String durasi = "00:00";
  String sisaDurasi = "00:00";
  double playbackSpeed = 1.0;
  // ignore: unused_field
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.onAudioPositionChanged.listen((duration) {
      setState(() {
        durasi = duration.toString();
      });
    });
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);
  }

  void _playAudio(String audioPath) async {
    // audioPlayer.setPlaybackSpeed(playbackSpeed);
    await audioPlayer.setPlaybackRate(playbackSpeed);
    await audioPlayer.play(audioPath);
    setState(() {
      _isPlaying = true;
    });
  }

  void _playtwo() async {
    await audioPlayer.setPlaybackRate(playbackSpeed = 2.0);
  }

  void _playone() async {
    await audioPlayer.setPlaybackRate(playbackSpeed = 1.0);
  }

  void _pauseAudio() async {
    await audioPlayer.pause();
    setState(() {
      _isPlaying = false;
      sisaDurasi = durasi;
    });
  }

  void _resumeAudio() async {
    await audioPlayer.resume();
    setState(() {
      _isPlaying = true;
    });
  }

  void _stopAudio() {
    audioPlayer.stop();
    setState(() {
      playbackSpeed = 1.0;
      _isPlaying = false;
      durasi = "00:00";
    });
  }

  @override
  void dispose() {
    audioPlayer
        .dispose(); // Pastikan untuk membebaskan sumber daya audio player
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cerita Rakyat Indonesia'),
        backgroundColor: Color.fromARGB(255, 209, 110, 255),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                color: Color.fromARGB(255, 241, 210, 255),
                elevation: 2, // Ketebalan bayangan kartu
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        judul,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10), // Menambahkan radius ke gambar
                        child: Image.asset(
                          "images/danau.jpg",
                          height: 315,
                          width: 600,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              if (_isPlaying) {
                                _pauseAudio();
                              } else if (durasi == "00:00") {
                                _playAudio(audioPath);
                              } else {
                                _resumeAudio();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 223, 155,
                                  255), // Warna latar belakang tombol
                            ),
                            child: Text(
                              _isPlaying
                                  ? 'Pause'
                                  : durasi == "00:00"
                                      ? 'Play'
                                      : 'Resume',
                              style: TextStyle(
                                color: Colors.black, // Warna teks putih
                              ),
                            ),
                          ),
                          SizedBox(
                              width: 20), // Memberi jarak antara tombol-tombol
                          ElevatedButton(
                            onPressed: _stopAudio,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 223, 155,
                                  255), // Warna latar belakang tombol
                            ),
                            child: Text(
                              'Stop',
                              style: TextStyle(
                                color: Colors.black, // Warna teks putih
                              ),
                            ),
                          ),
                          SizedBox(
                              width: 20), // Memberi jarak antara tombol-tombol
                          ElevatedButton(
                            onPressed: () {
                              if (playbackSpeed == 1.0) {
                                _playtwo();
                              } else if (playbackSpeed == 2.0) {
                                _playone();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 223, 155,
                                  255), // Warna latar belakang tombol
                            ),
                            child: Text(
                              playbackSpeed == 1.0 ? "1x" : "2x",
                              style: TextStyle(
                                color: Colors.black, // Warna teks putih
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(durasi,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                      SizedBox(height: 15),
                      Text(
                        ringkasanCerita,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
