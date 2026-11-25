import 'package:flutter/material.dart';

class SavedJobsEmptyState extends StatelessWidget {
  const SavedJobsEmptyState({
    super.key,
    this.onExplorePressed,
  });

  final VoidCallback? onExplorePressed;

  static const Color primaryNavy = Color(0xFF14264F);
  static const Color primaryBlue = Color(0xFF286BE8);
  static const Color paleBlueBackground = Color(0xFFEAF2FF);
  static const Color secondaryText = Color(0xFF536584);
  static const Color inputBorder = Color(0xFFD6E2F5);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: paleBlueBackground,
                shape: BoxShape.circle,
                border: Border.all(color: inputBorder, width: 1.5),
              ),
              child: const Icon(
                Icons.bookmark_border_rounded,
                color: primaryBlue,
                size: 38,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Saved Jobs Yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryNavy,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Bookmark job openings while browsing to keep track of opportunities and apply whenever you are ready.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: secondaryText,
                height: 1.5,
              ),
            ),
            if (onExplorePressed != null) ...[
              const SizedBox(height: 28),
              SizedBox(
                height: 46,
                child: ElevatedButton.icon(
                  onPressed: onExplorePressed,
                  icon: const Icon(Icons.search_rounded, size: 18),
                  label: const Text(
                    'Explore Jobs',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
