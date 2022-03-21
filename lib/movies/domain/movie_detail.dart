import 'movie_genre.dart';
import 'production_company.dart';
import 'production_country.dart';
import 'spoken_language.dart';

class MovieDetail {
  const MovieDetail({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool? adult;
  final String? backdropPath;
  final dynamic belongsToCollection;
  final int? budget;
  final List<MovieGenre>? genres;
  final String? homepage;
  final int? id;
  final String? imdbId;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompany>? productionCompanies;
  final List<ProductionCountry>? productionCountries;
  final DateTime? releaseDate;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguage>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  Map<String, dynamic> toMap() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'belongs_to_collection': belongsToCollection,
      'budget': budget,
      'genres': genres?.map((x) => x.toMap()).toList(),
      'homepage': homepage,
      'id': id,
      'imdb_id': imdbId,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'production_companies':
          productionCompanies?.map((x) => x.toMap()).toList(),
      'production_countries':
          productionCountries?.map((x) => x.toMap()).toList(),
      'release_date': releaseDate?.millisecondsSinceEpoch,
      'revenue': revenue,
      'runtime': runtime,
      'spoken_languages': spokenLanguages?.map((x) => x.toMap()).toList(),
      'status': status,
      'tagline': tagline,
      'title': title,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  factory MovieDetail.fromMap(Map<String, dynamic> map) {
    return MovieDetail(
      adult: map['adult'],
      backdropPath: map['backdrop_path'],
      belongsToCollection: map['belongs_to_collection'],
      budget: map['budget']?.toInt(),
      genres: map['genres'] != null
          ? List<MovieGenre>.from(
              map['genres']?.map((x) => MovieGenre.fromMap(x)))
          : null,
      homepage: map['homepage'],
      id: map['id']?.toInt(),
      imdbId: map['imdb_id'],
      originalLanguage: map['original_language'],
      originalTitle: map['original_title'],
      overview: map['overview'],
      popularity: map['popularity']?.toDouble(),
      posterPath: map['poster_path'],
      productionCompanies: map['production_companies'] != null
          ? List<ProductionCompany>.from(map['production_companies']
              ?.map((x) => ProductionCompany.fromMap(x)))
          : null,
      productionCountries: map['production_countries'] != null
          ? List<ProductionCountry>.from(map['production_countries']
              ?.map((x) => ProductionCountry.fromMap(x)))
          : null,
      releaseDate: map['release_date'] != null
          ? DateTime.tryParse(map['release_date'])
          : null,
      revenue: map['revenue']?.toInt(),
      runtime: map['runtime']?.toInt(),
      spokenLanguages: map['spoken_languages'] != null
          ? List<SpokenLanguage>.from(
              map['spoken_languages']?.map((x) => SpokenLanguage.fromMap(x)))
          : null,
      status: map['status'],
      tagline: map['tagline'],
      title: map['title'],
      video: map['video'],
      voteAverage: map['vote_average']?.toDouble(),
      voteCount: map['vote_count']?.toInt(),
    );
  }

  @override
  String toString() {
    return 'MovieDetail(adult: $adult, backdropPath: $backdropPath, belongsToCollection: $belongsToCollection, budget: $budget, genres: $genres, homepage: $homepage, id: $id, imdbId: $imdbId, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, productionCompanies: $productionCompanies, productionCountries: $productionCountries, releaseDate: $releaseDate, revenue: $revenue, runtime: $runtime, spokenLanguages: $spokenLanguages, status: $status, tagline: $tagline, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount)';
  }
}
