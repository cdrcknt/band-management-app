// models/band_member.dart
enum Instrument { vocal, guitar, bass, keyboard, drums }

class BandMember {
  final String name;
  final Instrument instrument;

  BandMember({
    required this.name,
    required this.instrument,
  });
}
