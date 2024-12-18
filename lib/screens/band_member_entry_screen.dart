import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/band.dart';
import '../models/band_member.dart';
import 'song_entry_screen.dart';

class BandMemberEntryScreen extends StatefulWidget {
  final Band band;

  const BandMemberEntryScreen({Key? key, required this.band}) : super(key: key);

  @override
  _BandMemberEntryScreenState createState() => _BandMemberEntryScreenState();
}

class _BandMemberEntryScreenState extends State<BandMemberEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  Instrument _selectedInstrument = Instrument.vocal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Band Members'),
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
                  labelText: 'Member Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a member name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<Instrument>(
                value: _selectedInstrument,
                decoration: const InputDecoration(
                  labelText: 'Instrument',
                  border: OutlineInputBorder(),
                ),
                items: Instrument.values.map((instrument) {
                  return DropdownMenuItem(
                    value: instrument,
                    child: Text(instrument.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedInstrument = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BandMember newMember = BandMember(
                      name: _nameController.text,
                      instrument: _selectedInstrument,
                    );
                    Provider.of<BandProvider>(context, listen: false)
                        .addMemberToBand(widget.band, newMember);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SongEntryScreen(band: widget.band),
                      ),
                    );
                  }
                },
                child: const Text('Add Member and Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
