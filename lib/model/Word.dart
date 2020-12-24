import 'package:intl/intl.dart';

enum Speech {
  n, v, adj, adv, article, pron, prep, conj, interj
}

enum Category {
  CET4, CET8, GRE, TOEFL, SAT, GMAT
}

class Word {
  String word;
  Speech speech;
  String glossary;
  String example;
  DateTime createdAt;
  DateTime lastReviewAt;
  int expectedInterval;
  List<Category> categories;

  Word({this.word, this.speech, this.glossary, this.example,
    this.createdAt, this.lastReviewAt, this.expectedInterval, this.categories});

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      word: json['word'] as String,
      speech: strToSpeech(json['speech'] as String),
      glossary: json['glossary'] as String,
      example: json['example'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastReviewAt: DateTime.parse(json['lastReviewAt'] as String),
      expectedInterval: json['expectedInterval'] as int,
      categories: (json['categories'] as List<dynamic>).map((e) =>
          strToCategory(e)).toList()
    );
  }

  String toJsonString() => '\n  {${getWord()}${getSpeech()}${getGlossary()}${getExample()}${getCreatedAt()}${getLastReviewAt()}${getExpectedInterval()}${getCategories()}\n  }';

  String getWord() => '\n    "word": "$word",';

  String getSpeech() => '\n    "speech": "${speechToStr(speech)}",';

  String getGlossary() => '\n    "glossary": "$glossary",';

  String getExample() => '\n    "example": "$example",';

  String getCreatedAt() => '\n    "createdAt": "${DateFormat('yyyy-MM-dd').format(createdAt)}",';

  String getLastReviewAt() => '\n    "lastReviewAt": "${DateFormat('yyyy-MM-dd').format(lastReviewAt)}",';

  String getExpectedInterval() => '\n    "expectedInterval": $expectedInterval,';

  String getCategories() => '\n    "categories": ${categories.map((e) => '"${categoryToStr(e)}"').toList()}';

  void reset(String word, Speech speech, String glossary, String example, List<Category> categories) {
    this.word = word;
    this.speech = speech;
    this.glossary = glossary;
    this.example = example;
    this.categories = categories;
  }

  void review() {
    DateTime current = DateTime.now();
    if (lastReviewAt.year != current.year || lastReviewAt.month != current.month
      || lastReviewAt.day != current.day) {
      lastReviewAt = current;
      expectedInterval += 2;
    }
  }

  bool isAssignedToday() {
    DateTime target = lastReviewAt;
    target = target.add(new Duration(days: expectedInterval));
    return DateFormat('yyyy-MM-dd').format(DateTime.now())
      == DateFormat('yyyy-MM-dd').format(target);
  }

  bool isSameWord(Word other) {
    return word == other.word;
  }

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