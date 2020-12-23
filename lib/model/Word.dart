import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

enum Speech {
  n, v, adj, adv, article, pron, prep, conj, interj
}

enum Category {
  CET4, CET8, GRE, TOEFL, SAT, GMAT
}

class Word {
  final String word;
  final Speech speech;
  final String glossary;
  final String example;
  final DateTime createdAt;
  final DateTime lastReviewAt;
  final List<Category> categories;

  Word({this.word, this.speech, this.glossary, this.example,
    this.createdAt, this.lastReviewAt, this.categories});

  static void test() {
    String json = jsonEncode(Word(
      word: 'test', speech: Speech.v,
      glossary: 'test glossary',
      example: 'this is a test',
      createdAt: DateTime.parse('2020-12-23 15:25:00'),
      lastReviewAt: DateTime.parse('2020-12-23 15:25:00'),
      categories: [Category.GRE]
    ));
    //writeCounter(1);
  }

  factory Word.fromJson(Map<String, dynamic> json) {
    //test();
    return Word(
      word: json['word'] as String,
      speech: strToSpeech(json['speech'] as String),
      glossary: json['glossary'] as String,
      example: json['example'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastReviewAt: DateTime.parse(json['lastReviewAt'] as String),
      categories: (json['categories'] as List<dynamic>).map((e) =>
          strToCategory(e)).toList()
    );
  }

  Map<String, dynamic> toJson() => {
    'word': word,
    'speech': speechToStr(speech),
    'glossary': glossary,
    'example': example,
    'createdAt': DateFormat('yyyy-MM-dd HH:mm:ss').format(createdAt),
    'lastReviewAt': DateFormat('yyyy-MM-dd HH:mm:ss').format(lastReviewAt),
    'categories': categories.map((e) => categoryToStr(e)).toList()
  };

  static Speech strToSpeech(String str) {
    switch (str) {
    case 'n.':
      return Speech.n;
    case 'v.':
      return Speech.v;
    case 'adj.':
      return Speech.adj;
    case 'adv.':
      return Speech.adv;
    case 'article':
      return Speech.article;
    case 'pron.':
      return Speech.pron;
    case 'prep.':
      return Speech.prep;
    case 'conj.':
      return Speech.conj;
    case 'interj.':
      return Speech.interj;
    default:
      throw Exception('Speech string stored in json file is invalid.');
    }
  }

  static String speechToStr(Speech speech) {
    switch (speech) {
    case Speech.n:
      return 'n.';
    case Speech.v:
      return 'v.';
    case Speech.adj:
      return 'adj.';
    case Speech.adv:
      return 'adv.';
    case Speech.article:
      return 'article';
    case Speech.pron:
      return 'pron.';
    case Speech.prep:
      return 'prep.';
    case Speech.conj:
      return 'conj.';
    case Speech.interj:
      return 'interj.';
    default:
      throw Exception('Invalid speech detected.');
    }
  }

  static Category strToCategory(String str) {
    switch (str) {
    case 'CET4':
      return Category.CET4;
    case 'CET8':
      return Category.CET8;
    case 'GRE':
      return Category.GRE;
    case 'TOEFL':
      return Category.TOEFL;
    case 'SAT':
      return Category.SAT;
    case 'GMAT':
      return Category.GMAT;
    default:
      throw Exception('Category strings stored in json file is invalid.');
    }
  }

  static String categoryToStr(Category category) {
    switch (category) {
    case Category.CET4:
      return 'CET4';
    case Category.CET8:
      return 'CET8';
    case Category.GRE:
      return 'GRE';
    case Category.TOEFL:
      return 'TOEFL';
    case Category.SAT:
      return 'SAT';
    case Category.GMAT:
      return 'GMAT';
    default:
      throw Exception('Invalid category detected.');
    }
  }
}