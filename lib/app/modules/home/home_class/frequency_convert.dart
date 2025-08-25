import 'package:my_day_flow/app/data/models/habit_model.dart';

class FrequencyConverter {
  // Short day names
  static const List<String> _shortDayNames = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  /// Convert habit frequency to readable string
  static String convertToFrequency(HabitModel habitModel) {
    final frequencyType = FrequencyType.values[habitModel.frequency];

    switch (frequencyType) {
      case FrequencyType.daily:
        return 'Daily';

      case FrequencyType.weekly:
        return _getDayNames(habitModel.days);

      case FrequencyType.monthly:
        return '${_getOrdinal(habitModel.dayOfMonth!)} of month';
    }
  }

  /// Get day names from list of day indices
  static String _getDayNames(List<int> dayIndices) {
    if (dayIndices.isEmpty) return 'No days';

    final dayNames = dayIndices.map((index) => _shortDayNames[index]).toList();

    if (dayNames.length == 1) {
      return dayNames.first;
    } else if (dayNames.length == 2) {
      return '${dayNames[0]} & ${dayNames[1]}';
    } else {
      return dayNames.join(', ');
    }
  }

  /// Convert number to ordinal (1st, 2nd, 3rd, etc.)
  static String _getOrdinal(int number) {
    if (number >= 11 && number <= 13) return '${number}th';

    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }

  /// Get single day name
  static String getDayName(int dayIndex, {bool isShort = false}) {
    return _shortDayNames[dayIndex];
  }
}
