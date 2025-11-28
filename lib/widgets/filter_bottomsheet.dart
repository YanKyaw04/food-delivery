import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  double _distance = 5;
  Set<String> _selectedPrices = {'\$', '\$\$'};
  String _selectedRating = '4+';
  Set<String> selectedTypes = {'Burgers'};

  final foodTypes = ['Burgers', 'Pizza', 'Sushi', 'Pasta'];
  final ratings = ['Any', '4+', '4.5+', '5'];
  final priceRanges = ['\$', '\$\$', '\$\$\$'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,

        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 5,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(12)),
          ),

          // Filter title
          Text("Filter Options", style: GoogleFonts.urbanist(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),

          // Food Type
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Food Type", style: GoogleFonts.urbanist(fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 4),

          Wrap(
            spacing: 8,
            children:
                foodTypes.map((type) {
                  final selected = selectedTypes.contains(type);
                  return ChoiceChip(
                    label: Text(type),
                    selected: selected,
                    onSelected: (_) {
                      setState(() {
                        if (selected) {
                          selectedTypes.remove(type);
                        } else {
                          selectedTypes.add(type);
                        }
                      });
                    },
                  );
                }).toList(),
          ),

          const SizedBox(height: 10),

          // Distance slider
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Distance (km)", style: GoogleFonts.urbanist(fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 4),

          Slider(
            value: _distance,
            min: 1,
            max: 20,
            divisions: 19,
            label: "${_distance.round()} km",
            onChanged: (val) => setState(() => _distance = val),
          ),

          const SizedBox(height: 2),

          // Rating
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Rating", style: GoogleFonts.urbanist(fontWeight: FontWeight.w600)),
          ),
          Wrap(
            spacing: 8,
            children:
                ratings.map((r) {
                  return ChoiceChip(
                    label: Text(r),
                    selected: _selectedRating == r,
                    onSelected: (_) => setState(() => _selectedRating = r),
                  );
                }).toList(),
          ),

          const SizedBox(height: 2),

          // Price
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Price Range", style: GoogleFonts.urbanist(fontWeight: FontWeight.w600)),
          ),
          Wrap(
            spacing: 8,
            children:
                priceRanges.map((p) {
                  final selected = _selectedPrices.contains(p);
                  return ChoiceChip(
                    label: Text(p),
                    selected: selected,
                    onSelected: (_) {
                      setState(() {
                        if (selected) {
                          _selectedPrices.remove(p);
                        } else {
                          _selectedPrices.add(p);
                        }
                      });
                    },
                  );
                }).toList(),
          ),

          const SizedBox(height: 6),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Reset logic
                    setState(() {
                      selectedTypes.clear();
                      _distance = 5;
                      _selectedPrices = {'\$', '\$\$'};
                      _selectedRating = '4+';
                    });
                  },
                  child: const Text("Reset"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black45, foregroundColor: Colors.white),
                  child: const Text("Apply"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
