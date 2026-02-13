enum Category {
  conversations(39, 'Beszélgetések'),
  theater(6, 'Színház'),
  literature(7, 'Irodalom'),
  popMusic(1, 'Könnyű zene'),
  folk(2, 'Népzene'),
  familyPrograms(16, 'Családi programok'),
  sports(11, 'Mozgás'),
  workshop(13, 'Workshop');

  final int id;
  final String name;

  const Category(this.id, this.name);
}
