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

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      word: json['word'] as String,
      speech: strToSpeech(json['speech'] as String),
      glossary: json['glossary'] as String,
      example: json['example'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastReviewAt: DateTime.parse(json['lastReviewAt'] as String),
      categories: dynamicListToCategories(json['categories'] as List<dynamic>)
    );
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

  static List<Category> dynamicListToCategories(List<dynamic> strs) {
    return strs.map((e) => strToCategory(e)).toList();
  }
}