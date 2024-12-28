import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Star extends StatefulWidget {
  Star({Key? key}) : super(key: key);
  @override
  _StarState createState() => _StarState();
}

class _StarState extends State<Star> {
  double _currentRating = 5.0; // Default rating

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0), // Padding around the content
      decoration: BoxDecoration(
        color:
            Colors.white.withOpacity(0.8), // Semi-transparent light background
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          RatingBar.builder(
            initialRating: _currentRating,
            minRating: 1,
            maxRating: 10,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 10,
            itemSize: 18, // Smaller stars
            itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _currentRating = rating;
              });
            },
          ),
          const SizedBox(height: 4),
          Text(
            "Rating: ${_currentRating.toStringAsFixed(1)} / 10",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black, // Make the text color dark for contrast
            ),
          ),
        ],
      ),
    );
  }
}
