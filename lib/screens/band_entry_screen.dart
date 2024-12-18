// band_entry_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/band.dart';
import 'band_member_entry_screen.dart'; // Added this import

class BandEntryScreen extends StatefulWidget {
  const BandEntryScreen({Key? key}) : super(key: key);

  @override
  _BandEntryScreenState createState() => _BandEntryScreenState();
}

class _BandEntryScreenState extends State<BandEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _selectedGenre = 'Rock';

  final List<String> _genres = [
    'Rock',
    'Pop',
    'Jazz',
    'Classical',
    'Electronic',
    'Hip Hop',
    'R&B',
    'Country',
    'Metal',
    'Folk'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Band'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Band Information',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Band Name',
                    prefixIcon: Icon(Icons.group),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a band name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedGenre,
                  decoration: const InputDecoration(
                    labelText: 'Genre',
                    prefixIcon: Icon(Icons.music_note),
                  ),
                  items: _genres.map((genre) {
                    return DropdownMenuItem(
                      value: genre,
                      child: Text(genre),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGenre = value!;
                    });
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        Band newBand = Band(
                          name: _nameController.text.trim(),
                          genre: _selectedGenre,
                        );

                        Provider.of<BandProvider>(context, listen: false)
                            .addBand(newBand);

                        if (mounted) {
                          // Add mounted check for safety
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BandMemberEntryScreen(band: newBand),
                            ),
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          // Add mounted check for safety
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error adding band: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    }
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Continue to Add Members'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
