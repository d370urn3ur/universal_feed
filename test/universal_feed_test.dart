import 'dart:io';

import 'package:test/test.dart';
import 'package:universal_feed/universal_feed.dart';

// import 'atom10_cases.dart';
// import 'atom_cases.dart';
import 'dcterm_cases.dart';
import 'georss_cases.dart';
import 'itunes_cases.dart';
import 'media_rss_cases.dart';
import 'rss_cases.dart';
import 'syndication_cases.dart';

void main() {
  test(
    'Rss',
    () => rssTests().forEach(
      runner<UniversalFeed>(
        './test/wellformed/rss',
        UniversalFeed.parseFromString,
      ),
    ),
  );
  test(
    'Media RSS',
    () => mediaRssTests().forEach(
      runner<UniversalFeed>(
        './test/wellformed/media-rss',
        UniversalFeed.parseFromString,
      ),
    ),
  );
  test(
    'Geo RSS',
    () => geoRssTests().forEach(
      runner<UniversalFeed>(
        './test/wellformed/georss',
        UniversalFeed.parseFromString,
      ),
    ),
  );
  test(
    'Syndication',
    () => syndicationTests().forEach(
      runner<UniversalFeed>(
        './test/wellformed/syndication',
        UniversalFeed.parseFromString,
      ),
    ),
  );
  test(
    'DcTerms',
    () => dctermsTests().forEach(
      runner<UniversalFeed>(
        './test/wellformed/dcTerms',
        UniversalFeed.parseFromString,
      ),
    ),
  );
  test(
    'Itunes Podcast',
    () => itunesTests().forEach(
      runner<UniversalFeed>(
        './test/wellformed/itunes',
        UniversalFeed.parseFromString,
      ),
    ),
  );
  // test(
  //   'Atom v0.3',
  //   () => atomTests().forEach(
  //     runner<Atom>(
  //       './test/wellformed/atom',
  //       Atom.parseFromString,
  //     ),
  //   ),
  // );
  // test(
  //   'Atom v1.0',
  //   () => atom10Tests().forEach(
  //     runner<Atom>(
  //       './test/wellformed/atom10',
  //       Atom.parseFromString,
  //     ),
  //   ),
  // );
  // test(
  //   'Geo Atom',
  //   () => geoAtomTests().forEach(
  //     runner<Atom>(
  //       './test/wellformed/georss',
  //       Atom.parseFromString,
  //     ),
  //   ),
  // );
}

typedef TGenerator<T> = T Function(String);
typedef TTestCall<T> = bool Function(T);
typedef Tfx<T> = void Function(String, TTestCall<T>);

Tfx<T> runner<T>(String path, TGenerator<T> generator) {
  return (filename, fx) {
    final content = File('$path/$filename').readAsStringSync();

    bool rc;
    final sb = StringBuffer()..writeln('\n$filename: -----<<');
    try {
      final p = generator(content);
      rc = fx(p);
    } catch (err, stk) {
      rc = false;
      sb
        ..writeln(err)
        ..writeln(stk);
    }

    assert(rc, sb.toString());
  };
}
