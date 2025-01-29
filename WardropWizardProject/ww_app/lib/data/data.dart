import 'package:flutter/material.dart';

class Product {
  final String productName;
  final String productImageUrl;
  final String productPUrl;
  bool isLiked;
  int likesCount;
  final bool isKadin;

  Product({
    required this.productName,
    required this.productImageUrl,
    required this.productPUrl,
    required this.isLiked,
    required this.likesCount,
    required this.isKadin,
  });

  // isLiked ve likesCount'ı değiştirmek için copyWith metodu
  Product copyWith({
    String? productName,
    String? productImageUrl,
    String? productPUrl,
    bool? isLiked,
    int? likesCount,
    bool? isKadin,
  }) {
    return Product(
      productName: productName ?? this.productName,
      productImageUrl: productImageUrl ?? this.productImageUrl,
      productPUrl: productPUrl ?? this.productPUrl,
      isLiked: isLiked ?? this.isLiked,
      likesCount: likesCount ?? this.likesCount,
      isKadin: isKadin ?? this.isKadin,
    );
  }

  // Beğeni geri almak için bir fonksiyon ekleyelim
  void toggleLike() {
    isLiked = !isLiked; // isLiked değerini tersine çeviriyoruz
    likesCount = isLiked
        ? likesCount + 1
        : likesCount -
            1; // Eğer beğendi ise beğeni sayısını arttır, değilse azalt
  }
}

final products = [
  Product(
      productName: 'Başak Köseoğlu',
      productImageUrl: 'assets/k1.jpg',
      productPUrl: 'assets/p12.png',
      isLiked: false,
      isKadin: true,
      likesCount: 300),
  Product(
      productName: 'Canan Sarıkaya',
      productImageUrl: 'assets/k2.jpg',
      productPUrl: 'assets/p13.png',
      likesCount: 250,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Sertap Koç',
      productImageUrl: 'assets/k3.jpg',
      productPUrl: 'assets/p1.jpg',
      likesCount: 56,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Selin Şeker',
      productImageUrl: 'assets/k4.jpg',
      productPUrl: 'assets/p2.jpg',
      likesCount: 78,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Bade Adalı',
      productImageUrl: 'assets/k5.jpg',
      productPUrl: 'assets/p3.jpg',
      likesCount: 125,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Pınar İleri',
      productImageUrl: 'assets/k6.jpg',
      productPUrl: 'assets/p15.png',
      likesCount: 3,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Sibel Şirin',
      productImageUrl: 'assets/k7.jpg',
      productPUrl: 'assets/p4.jpg',
      likesCount: 358,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Elif Yılmaz',
      productImageUrl: 'assets/k8.jpg',
      productPUrl: 'assets/p5.jpg',
      likesCount: 15,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Zeynep İmzaoğlu',
      productImageUrl: 'assets/k9.jpg',
      productPUrl: 'assets/p20.png',
      likesCount: 452,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Eda Çetin',
      productImageUrl: 'assets/k10.png',
      productPUrl: 'assets/p6.jpg',
      likesCount: 98,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Burçin Güngör',
      productImageUrl: 'assets/k11.jpg',
      productPUrl: 'assets/p12.png',
      likesCount: 83,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Rabia Yulalı',
      productImageUrl: 'assets/k12.jpg',
      productPUrl: 'assets/p16.png',
      likesCount: 200,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Aylin Demir',
      productImageUrl: 'assets/k13.png',
      productPUrl: 'assets/p7.jpg',
      likesCount: 120,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Derya Çelik',
      productImageUrl: 'assets/k14.jpg',
      productPUrl: 'assets/p8.jpg',
      likesCount: 69,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Melis Arslan',
      productImageUrl: 'assets/k15.jpg',
      productPUrl: 'assets/p18.png',
      likesCount: 87,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'İrem Özdemir',
      productImageUrl: 'assets/k16.jpg',
      productPUrl: 'assets/p9.jpg',
      likesCount: 90,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Büşra Yıldız',
      productImageUrl: 'assets/k17.jpg',
      productPUrl: 'assets/p12.png',
      likesCount: 33,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Sena Gökçe',
      productImageUrl: 'assets/k18.jpg',
      productPUrl: 'assets/p17.png',
      likesCount: 28,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Eda Karaca',
      productImageUrl: 'assets/k20.jpg',
      productPUrl: 'assets/p11.jpg',
      likesCount: 63,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Hande Korkmaz',
      productImageUrl: 'assets/k21.jpg',
      productPUrl: 'assets/p19.png',
      likesCount: 88,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Hülya Şahin',
      productImageUrl: 'assets/k23.jpg',
      productPUrl: 'assets/p6.jpg',
      likesCount: 7,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Yasemin Çetin',
      productImageUrl: 'assets/k24.jpg',
      productPUrl: 'assets/p2.jpg',
      likesCount: 20,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Berna Ekinci',
      productImageUrl: 'assets/k25.jpg',
      productPUrl: 'assets/p12.png',
      likesCount: 23,
      isLiked: false,
      isKadin: true),
  Product(
      productName: 'Deniz Kural',
      productImageUrl: 'assets/e1.jpg',
      productPUrl: 'assets/p10.jpg',
      likesCount: 233,
      isLiked: false,
      isKadin: false),
  Product(
      productName: 'Levent Aslan',
      productImageUrl: 'assets/e2.jpg',
      productPUrl: 'assets/p21.png',
      likesCount: 109,
      isLiked: false,
      isKadin: false),
  Product(
      productName: 'Sedef Çelen',
      productImageUrl: 'assets/e3.jpg',
      productPUrl: 'assets/p17.png',
      likesCount: 325,
      isLiked: false,
      isKadin: false),
  Product(
      productName: 'Zeynep Ekinci',
      productImageUrl: 'assets/e4.jpg',
      productPUrl: 'assets/p8.jpg',
      likesCount: 71,
      isLiked: false,
      isKadin: false),
  Product(
      productName: 'Berkay Akman',
      productImageUrl: 'assets/e5.jpg',
      productPUrl: 'assets/p12.png',
      likesCount: 36,
      isLiked: false,
      isKadin: false),
  Product(
      productName: 'Emir Yüce',
      productImageUrl: 'assets/e6.jpg',
      productPUrl: 'assets/p10.jpg',
      likesCount: 28,
      isLiked: false,
      isKadin: false),
  Product(
      productName: 'Baran Demirtaş',
      productImageUrl: 'assets/e8.jpg',
      productPUrl: 'assets/p12.png',
      likesCount: 142,
      isLiked: false,
      isKadin: false),
  Product(
      productName: 'Kaan Karadeniz',
      productImageUrl: 'assets/e9.jpg',
      productPUrl: 'assets/p10.jpg',
      likesCount: 88,
      isLiked: false,
      isKadin: false),
  Product(
      productName: 'Oya Aydın',
      productImageUrl: 'assets/e10.jpg',
      productPUrl: 'assets/p22.png',
      likesCount: 263,
      isLiked: false,
      isKadin: false),
  Product(
      productName: 'Mert Karataş',
      productImageUrl: 'assets/e11.jpg',
      productPUrl: 'assets/p18.png',
      likesCount: 132,
      isLiked: false,
      isKadin: false),
  Product(
      productName: 'Duru Aktaş',
      productImageUrl: 'assets/e12.jpg',
      productPUrl: 'assets/p10.jpg',
      likesCount: 214,
      isLiked: false,
      isKadin: false),
  Product(
      productName: 'İrem Soylu',
      productImageUrl: 'assets/e13.png',
      productPUrl: 'assets/p8.jpg',
      likesCount: 96,
      isLiked: false,
      isKadin: false),
  Product(
      productName: 'Selim Alkan',
      productImageUrl: 'assets/e14.jpg',
      productPUrl: 'assets/p17.png',
      likesCount: 127,
      isLiked: false,
      isKadin: false),
  Product(
      productName: 'Okan Şahin',
      productImageUrl: 'assets/e15.jpg',
      productPUrl: 'assets/p22.png',
      likesCount: 230,
      isLiked: false,
      isKadin: false),
  Product(
      productName: 'Deniz Ege Arslan',
      productImageUrl: 'assets/e16.jpg',
      productPUrl: 'assets/p10.jpg',
      likesCount: 90,
      isLiked: false,
      isKadin: false),
  Product(
      productName: 'Cenk Efe Can',
      productImageUrl: 'assets/e17.jpg',
      productPUrl: 'assets/p13.png',
      likesCount: 0,
      isLiked: false,
      isKadin: false),
  Product(
      productName: 'Alara Demir',
      productImageUrl: 'assets/e18.jpg',
      productPUrl: 'assets/p1.jpg',
      likesCount: 78,
      isLiked: false,
      isKadin: false),
  Product(
      productName: 'Gülben Kara',
      productImageUrl: 'assets/e19jpg.jpg',
      productPUrl: 'assets/p7.jpg',
      likesCount: 123,
      isLiked: false,
      isKadin: false),
  Product(
      productName: 'Burak Aslaner',
      productImageUrl: 'assets/e20.jpg',
      productPUrl: 'assets/p12.png',
      likesCount: 30,
      isLiked: false,
      isKadin: false),
];
