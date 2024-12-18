import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Added Provider import
import '../models/band.dart';
import '../models/band_member.dart';
import '../utils/genre_images.dart';
import 'band_member_entry_screen.dart';
import 'song_entry_screen.dart';

class BandDetailsScreen extends StatelessWidget {
  final Band band;

  const BandDetailsScreen(
      {super.key, required this.band}); // Updated constructor

  // Instrument icon mapping
  Widget _getInstrumentIcon(Instrument instrument) {
    final Map<Instrument, IconData> instrumentIcons = {
      Instrument.vocal: Icons.mic,
      Instrument.guitar: Icons.music_note,
      Instrument.bass: Icons.music_note_outlined,
      Instrument.keyboard: Icons.keyboard,
      Instrument.drums: Icons.waves,
    };

    return Icon(instrumentIcons[instrument], color: Colors.deepPurple);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                band.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black45,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
              background: Image.asset(
                GenreImages.getImageForGenre(band.genre),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              // Band Members Section
              _buildSectionTitle('Band Members', Icons.people),
              if (band.members.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: Text('No members added yet')),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: band.members.length,
                  itemBuilder: (context, index) {
                    final member = band.members[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      elevation: 4,
                      child: ListTile(
                        leading: _getInstrumentIcon(member.instrument),
                        title: Text(member.name),
                        subtitle: Text(
                          member.instrument.toString().split('.').last,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            Provider.of<BandProvider?>(context, listen: false)
                                ?.removeBand(band);
                          },
                        ),
                      ),
                    );
                  },
                ),

              // Songs Section
              _buildSectionTitle('Songs', Icons.music_note),
              if (band.songs.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: Text('No songs added yet')),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: band.songs.length,
                  itemBuilder: (context, index) {
                    final song = band.songs[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      elevation: 4,
                      child: ListTile(
                        leading: const Icon(
                          Icons.music_note,
                          color: Colors.deepPurple,
                        ),
                        title: Text(song.name),
                        subtitle: Text('Released: ${song.releaseYear}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            Provider.of<BandProvider?>(context, listen: false)
                                ?.removeBand(band);
                          },
                        ),
                      ),
                    );
                  },
                ),
            ]),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'addMember',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BandMemberEntryScreen(band: band),
                ),
              );
            },
            child: const Icon(Icons.person_add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'addSong',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SongEntryScreen(band: band),
                ),
              );
            },
            child: const Icon(Icons.add), // Changed from add_music
          ),
        ],
      ),
    );
  }

  // Helper method to create section titles
  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }
}
