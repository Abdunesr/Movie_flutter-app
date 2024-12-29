import 'package:flutter/material.dart';

class Star extends StatefulWidget {
  final int initialRating;
  final ValueChanged<int> onRatingChanged;

  const Star({
    Key? key,
    required this.initialRating,
    required this.onRatingChanged,
  }) : super(key: key);

  @override
  _StarState createState() => _StarState();
}

class _StarState extends State<Star> {
  late int currentRating;

  @override
  void initState() {
    super.initState();
    currentRating = widget.initialRating; // Initialize with the passed rating
  }

  void _handleRatingChange(int rating) {
    setState(() {
      currentRating = rating;
    });
    widget.onRatingChanged(rating); // Notify parent about the change
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < currentRating ? Icons.star : Icons.star_border,
            color: Colors.yellow,
          ),
          onPressed: () => _handleRatingChange(index + 1),
        );
      }),
    );
  }
}
