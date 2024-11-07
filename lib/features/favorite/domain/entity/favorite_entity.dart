class FavoriteEntity {
  final bool? isFav;
  final String? slugMovie;
  final String? nameMovie;
  final String? urlImage;

  FavoriteEntity({
    this.isFav,
    this.slugMovie,
    this.nameMovie,
    this.urlImage,
  });

  factory FavoriteEntity.fromMap(Map<String, dynamic> map) {
    return FavoriteEntity(
      isFav: map['isFav'] as bool?,
      slugMovie: map['slugMovie'] as String?,
      nameMovie: map['nameMovie'] as String?,
      urlImage: map['urlImage'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isFav': false,
      'slugMovie': slugMovie,
      'nameMovie': nameMovie,
    };
  }
}
