class MovieTrailer {
  MovieTrailer({
    required this.id,
    required this.results,
  });

  final int id;
  final List<Result> results;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'results': results.map((x) => x.toMap()).toList(),
    };
  }

  factory MovieTrailer.fromMap(Map<String, dynamic> map) {
    return MovieTrailer(
      id: map['id']?.toInt() ?? 0,
      results: List<Result>.from(
          map['results']?.map((x) => Result.fromMap(x)) ?? const []),
    );
  }

  @override
  String toString() => 'MovieTrailer(id: $id, results: $results)';
}

class Result {
  Result({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  final String iso6391;
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final DateTime? publishedAt;
  final String id;

  Map<String, dynamic> toMap() {
    return {
      'iso6391': iso6391,
      'iso31661': iso31661,
      'name': name,
      'key': key,
      'site': site,
      'size': size,
      'type': type,
      'official': official,
      'published_at': publishedAt?.toIso8601String(),
      'id': id,
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      iso6391: map['iso6391'] ?? '',
      iso31661: map['iso31661'] ?? '',
      name: map['name'] ?? '',
      key: map['key'] ?? '',
      site: map['site'] ?? '',
      size: map['size']?.toInt() ?? 0,
      type: map['type'] ?? '',
      official: map['official'] ?? false,
      publishedAt: DateTime.tryParse(map['published_at']),
      id: map['id'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Result(iso6391: $iso6391, iso31661: $iso31661, name: $name, key: $key, site: $site, size: $size, type: $type, official: $official, publishedAt: $publishedAt, id: $id)';
  }
}
