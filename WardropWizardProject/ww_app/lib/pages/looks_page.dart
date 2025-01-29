import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';
import 'package:ww_app/api/consts.dart';
import 'dart:math';

class LooksPage extends StatefulWidget {
  const LooksPage({super.key});

  @override
  _LooksPageState createState() => _LooksPageState();
}

class _LooksPageState extends State<LooksPage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;
  List<Map<String, String>>? selectedKombin;

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Kırşehir").then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  // Kombin kategorileri ve elemanları
  final Map<String, List<List<Map<String, String>>>> kombinKategorileri = {
    "Kış Kombini": [
      [
        {"isim": "Ceket", "gorsel": "assets/ceket2.png"},
        {"isim": "Pantolon", "gorsel": "assets/pant1.png"},
        {"isim": "Ayakkabı", "gorsel": "assets/bot1.png"},
      ],
      [
        {"isim": "Ceket", "gorsel": "assets/ceket3.png"},
        {"isim": "Çanta", "gorsel": "assets/çanta1.png"},
        {"isim": "Ayakkabı", "gorsel": "assets/bot2.png"},
      ],
      [
        {"isim": "Ceket", "gorsel": "assets/ceket4.png"},
        {"isim": "Pantolon", "gorsel": "assets/pant2.png"},
        {"isim": "Çanta", "gorsel": "assets/çanta2.png"},
      ],
    ],
    "Yaz Kombini": [
      [
        {"isim": "Etek", "gorsel": "assets/etek.png"},
        {"isim": "Ayakkabı", "gorsel": "assets/ayakkabı5.png"},
        {"isim": "Çanta", "gorsel": "assets/çanta3.png"},
      ],
      [
        {"isim": "Elbise", "gorsel": "assets/elbise1.png"},
        {"isim": "Ayakkabı", "gorsel": "assets/ayakkabı6.png"},
        {"isim": "Çanta", "gorsel": "assets/çanta1.png"},
      ],
      [
        {"isim": "Etek", "gorsel": "assets/etek5.png"},
        {"isim": "Ayakkabı", "gorsel": "assets/ayakkabı5.png"},
        {"isim": "Çanta", "gorsel": "assets/çanta2.png"},
      ],
    ],
    "Günlük Kombin": [
      [
        {"isim": "Ceket", "gorsel": "assets/ceket1.png"},
        {"isim": "Pantolon", "gorsel": "assets/pant3.png"},
        {"isim": "Ayakkabı", "gorsel": "assets/ayak3.png"},
      ],
      [
        {"isim": "Gömlek", "gorsel": "assets/gömlek.png"},
        {"isim": "Pantolon", "gorsel": "assets/pant1.png"},
        {"isim": "Ayakkabı", "gorsel": "assets/bot.png"},
      ],
      [
        {"isim": "Etek", "gorsel": "assets/etk.png"},
        {"isim": "Ayakkabı", "gorsel": "assets/ayakkabı6.png"},
        {"isim": "Çanta", "gorsel": "assets/çanta1.png"},
      ],
    ],
    "Spor Kombin": [
      [
        {"isim": "Eşofman", "gorsel": "assets/eşofman.png"},
        {"isim": "Ayakkabı", "gorsel": "assets/ayakkabı6.png"},
        {"isim": "Ceket", "gorsel": "assets/ckt.png"},
      ],
      [
        {"isim": "Pantolon", "gorsel": "assets/pant2.png"},
        {"isim": "Ayakkabı", "gorsel": "assets/ayakkabı5.png"},
        {"isim": "Çanta", "gorsel": "assets/çanta3.png"},
      ],
    ],
    "Özel Gün Kombini": [
      [
        {"isim": "Ceket", "gorsel": "assets/gömlek.png"},
        {"isim": "Pantolon", "gorsel": "assets/pant1.png"},
        {"isim": "Ayakkabı", "gorsel": "assets/ayk.png"},
      ],
      [
        {"isim": "Elbise", "gorsel": "assets/elbise2.png"},
        {"isim": "Çanta", "gorsel": "assets/çanta2.png"},
        {"isim": "Ayakkabı", "gorsel": "assets/tpk.png"},
      ],
      [
        {"isim": "Elbise", "gorsel": "assets/elbise5.png"},
        {"isim": "Ayakkabı", "gorsel": "assets/tpk.png"},
        {"isim": "Çanta", "gorsel": "assets/çanta2.png"},
      ],
    ]
  };

  // Rastgele kombin seçme fonksiyonu
  List<Map<String, String>> randomKombinSec(String kombinAdi) {
    final kategoriler = kombinKategorileri[kombinAdi];
    if (kategoriler == null || kategoriler.isEmpty) {
      return [];
    }
    final random = Random();
    return kategoriler[random.nextInt(kategoriler.length)];
  }

  // Kombin oluşturma ve seçme
  void kombinOlustur(String kombinAdi) {
    final kombin = randomKombinSec(kombinAdi);
    if (kombin.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Hata"),
          content: const Text("Bu kategori için kombin bulunamadı."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Tamam"),
            ),
          ],
        ),
      );
      return;
    }
    setState(() {
      selectedKombin = kombin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                // Hava durumu kısmı
                _buildWeatherInfo(),
                const SizedBox(height: 16),
                // Başlık kısmı
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        'Kombin Oluştur',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromRGBO(185, 3, 43, 0.729),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Kombin butonları
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 16),
                      _buildKombinButton("Kış Kombini"),
                      const SizedBox(height: 16),
                      _buildKombinButton("Yaz Kombini"),
                      const SizedBox(height: 16),
                      _buildKombinButton("Günlük Kombin"),
                      const SizedBox(height: 16),
                      _buildKombinButton("Spor Kombin"),
                      const SizedBox(height: 16),
                      _buildKombinButton("Özel Gün Kombini"),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Seçilen kombin kısmı
                if (selectedKombin != null) _buildSelectedKombin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKombinButton(String kombinAdi) {
    return ElevatedButton(
      onPressed: () => kombinOlustur(kombinAdi),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(185, 3, 43, 0.729),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
      child: Text(
        kombinAdi,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildWeatherInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_weather != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('EEEE').format(DateTime.now()),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat('dd MMMM yyyy').format(DateTime.now()),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.network(
                      'https://openweathermap.org/img/w/${_weather!.weatherIcon}.png',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _weather?.weatherDescription ?? "Hava durumu bilgisi yok",
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0) ?? "N/A"}°C, Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0) ?? "N/A"}°C',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ] else ...[
            const CircularProgressIndicator()
          ],
        ],
      ),
    );
  }

  Widget _buildSelectedKombin() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Seçilen Kombin:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: selectedKombin!.length,
            itemBuilder: (context, index) {
              final parca = selectedKombin![index];
              return Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: Image.asset(
                      parca["gorsel"]!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error, color: Colors.red);
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    parca["isim"]!,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
