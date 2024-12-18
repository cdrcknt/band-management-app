class GenreImages {
  static const Map<String, String> images = {
    'Rock': 'assets/images/rock.jpg',
    'Pop': 'assets/images/pop.jpg',
    'Jazz': 'assets/images/jazz.jpg',
    'Classical': 'assets/images/classical.jpg',
    'Electronic': 'assets/images/electronic.jpg'
  };

  static String getImageForGenre(String genre) {
    return images[genre] ?? 'assets/images/default.jpg';
  }
}
