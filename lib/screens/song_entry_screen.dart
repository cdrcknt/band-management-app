import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/band.dart';
import '../models/song.dart';
import 'main_screen.dart';

class SongEntryScreen extends StatefulWidget {
  final Band band;

  const SongEntryScreen({Key? key, required this.band}) : super(key: key);

  @override
  _SongEntryScreenState createState() => _SongEntryScreenState();
}

class _SongEntryScreenState extends State<SongEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Songs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Song Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a song name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(
                  labelText: 'Release Year',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a release year';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid year';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Song newSong = Song(
                      name: _nameController.text,
                      releaseYear: int.parse(_yearController.text),
                    );
                    Provider.of<BandProvider>(context, listen: false)
                        .addSongToBand(widget.band, newSong);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainScreen()),
                      (route) => false,
                    );
                  }
                },
                child: const Text('Add Song and Finish'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
