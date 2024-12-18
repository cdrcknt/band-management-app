// models/band.dart
import 'package:flutter/foundation.dart';
import 'band_member.dart';
import 'song.dart';

class Band {
  final String name;
  final String genre;
  List<BandMember> members;
  List<Song> songs;

  Band({
    required this.name,
    required this.genre,
    List<BandMember>? members,
    List<Song>? songs,
  })  : members = members ?? [],
        songs = songs ?? [];
}

class BandProvider with ChangeNotifier {
  final List<Band> _bands = [];

  List<Band> get bands => List.unmodifiable(_bands);

  void addBand(Band band) {
    _bands.add(band);
    notifyListeners();
  }

  void removeBand(Band band) {
    _bands.remove(band);
    notifyListeners();
  }

  void addMemberToBand(Band band, BandMember member) {
    final bandIndex = _bands.indexOf(band);
    if (bandIndex != -1) {
      _bands[bandIndex].members.add(member);
      notifyListeners();
    }
  }

  void removeMemberFromBand(Band band, BandMember member) {
    final bandIndex = _bands.indexOf(band);
    if (bandIndex != -1) {
      _bands[bandIndex].members.remove(member);
      notifyListeners();
    }
  }

  void addSongToBand(Band band, Song song) {
    final bandIndex = _bands.indexOf(band);
    if (bandIndex != -1) {
      _bands[bandIndex].songs.add(song);
      notifyListeners();
    }
  }

  void removeSongFromBand(Band band, Song song) {
    final bandIndex = _bands.indexOf(band);
    if (bandIndex != -1) {
      _bands[bandIndex].songs.remove(song);
      notifyListeners();
    }
  }
}
