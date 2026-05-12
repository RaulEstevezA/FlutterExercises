
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:widget_app/config/theme/app_theme.dart';

final isDarkMode = StateProvider<bool>((ref) => false);

// Listado de colores inmutable
final colorListProvider = Provider((ref) => colorList);

final selectedColorProvider = StateProvider<int>((ref) => 0);

// un objeto de tipo AppTheme (custom)
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier(),
  );

// controller o notifier
class ThemeNotifier extends StateNotifier<AppTheme> {

  // STATE = Estado = new AppTheme();
  ThemeNotifier(): super(AppTheme());
  
}