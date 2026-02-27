import 'package:intl/intl.dart';

class DateHelper {
  /// Safely parse date string with multiple format attempts
  static DateTime? parseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;

    try {
      // Try standard ISO 8601 format first
      return DateTime.parse(dateString);
    } catch (e) {
      // Try common alternative formats
      final formats = [
        'yyyy-MM-dd HH:mm:ss',
        'dd-MM-yyyy',
        'MM-dd-yyyy',
        'yyyy-MM-dd',
        'dd/MM/yyyy',
        'MM/dd/yyyy',
      ];

      for (final format in formats) {
        try {
          return DateFormat(format).parse(dateString);
        } catch (_) {
          continue;
        }
      }

      print('❌ Failed to parse date: $dateString');
      return null;
    }
  }

  /// Format date for display (e.g., "25 Feb 2026")
  static String formatDate(String? dateString, {String format = 'dd MMM yyyy'}) {
    final date = parseDate(dateString);
    if (date == null) return 'N/A';
    
    try {
      return DateFormat(format).format(date);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  /// Format date with time (e.g., "25 Feb 2026, 3:45 PM")
  static String formatDateTime(String? dateString) {
    return formatDate(dateString, format: 'dd MMM yyyy, hh:mm a');
  }

  /// Format time only (e.g., "3:45 PM")
  static String formatTime(String? dateString) {
    return formatDate(dateString, format: 'hh:mm a');
  }

  /// Get relative time (e.g., "2 hours ago", "yesterday")
  static String getRelativeTime(String? dateString) {
    final date = parseDate(dateString);
    if (date == null) return 'N/A';

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      if (difference.inDays == 1) return 'yesterday';
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'just now';
    }
  }

  /// Check if date is in the past
  static bool isPast(String? dateString) {
    final date = parseDate(dateString);
    if (date == null) return false;
    return date.isBefore(DateTime.now());
  }

  /// Check if date is in the future
  static bool isFuture(String? dateString) {
    final date = parseDate(dateString);
    if (date == null) return false;
    return date.isAfter(DateTime.now());
  }

  /// Get days until date
  static int? daysUntil(String? dateString) {
    final date = parseDate(dateString);
    if (date == null) return null;
    return date.difference(DateTime.now()).inDays;
  }
}