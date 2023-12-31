// theme services

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import '/utils/color.dart';
import '/utils/my_logger.dart';

import '../utils/sized_utils.dart';

ValueNotifier<ThemeData> appTheme = ValueNotifier(ThemeData.light());

class ThemeService {
  final themeBox = GetStorage('themeBox');
  ThemeService._internal();
  static final ThemeService _instance = ThemeService._internal();
  static ThemeService get instance => _instance;

  final allThemes = <String, ThemeData>{
    'dark': darkTheme,
    'light': lightTheme,
    'pink': pinkTheme,
    'darkBlue': darkBlueTheme,
    'halloween': halloweenTheme,
  };

  String get previousThemeName {
    String? themeName = themeBox.read<String?>('previousThemeName');
    if (themeName == null) {
      final isPlatformDark =
          WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
      themeName = isPlatformDark ? 'light' : 'dark';
    }
    return themeName;
  }

  get initial {
    String? themeName = themeBox.read<String?>('theme');
    if (themeName == null) {
      final isPlatformDark =
          WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
      themeName = isPlatformDark ? 'dark' : 'light';
    }
    return allThemes[themeName];
  }

  save(String newThemeName) {
    var currentThemeName = themeBox.read<String?>('theme');
    if (currentThemeName != null) {
      themeBox.write('previousThemeName', currentThemeName);
    }
    themeBox.write('theme', newThemeName);
  }

  ThemeData getByName(String name) {
    return allThemes[name]!;
  }

  Future<void> changeThemeMode(BuildContext context,
      [bool reversed = false]) async {
    timeDilation = 3.0;
    logger.t('Theme changed context: $context', tag: context.size.toString());

    try {
      final themeSwitcher = ThemeSwitcher.of(context);
      final themeName =
          ThemeModelInheritedNotifier.of(context).theme.brightness ==
                  Brightness.light
              ? 'dark'
              : 'light';
      final service = ThemeService.instance..save(themeName);
      final theme = service.getByName(themeName);
      themeSwitcher.changeTheme(theme: theme, isReversed: reversed);
      logger.t('Theme changed themeName: ${getTheme().brightness.name}');
    } catch (e) {
      logger.e('changeThemeMode', error: e);
    }
    Future.delayed(const Duration(milliseconds: 1000), () {
      timeDilation = 1.0;
    });
  }
}

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: lightPrimary,
  scaffoldBackgroundColor: lightAccent,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Color.fromARGB(255, 255, 255, 255),
    backgroundColor: lightPrimary,
  ),
  textTheme: textTheme('light'),
  inputDecorationTheme: _inputDecorationTheme('light'),
  elevatedButtonTheme: _getElevatedButtonTheme('light'),
  textButtonTheme: _getTextButtonTheme('light'),
  textSelectionTheme: _getTextSelectionThemeData('light'),
  iconTheme: const IconThemeData(color: Colors.black),
  drawerTheme: _getDrawerThemeData('light'),
  scrollbarTheme: _getScrollbarTheme('light'),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  primaryColor: lightPrimary,
  scaffoldBackgroundColor: lightAccent,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Color.fromARGB(255, 255, 255, 255),
    backgroundColor: lightPrimary,
  ),
  textTheme: textTheme('dark'),
  inputDecorationTheme: _inputDecorationTheme('dark'),
  elevatedButtonTheme: _getElevatedButtonTheme('dark'),
  textButtonTheme: _getTextButtonTheme('dark'),
  textSelectionTheme: _getTextSelectionThemeData('dark'),
  iconTheme: const IconThemeData(color: Colors.white),
  drawerTheme: _getDrawerThemeData('dark'),
  scrollbarTheme: _getScrollbarTheme('dark'),
);

ThemeData pinkTheme = lightTheme.copyWith(
    primaryColor: const Color(0xFFF49FB6),
    scaffoldBackgroundColor: const Color(0xFFFAF8F0),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Color(0xFF24737c),
      backgroundColor: Color(0xFFA6E0DE),
    ),
    textTheme: const TextTheme());

ThemeData halloweenTheme = lightTheme.copyWith(
  primaryColor: const Color(0xFF55705A),
  scaffoldBackgroundColor: const Color(0xFFE48873),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Color(0xFFea8e71),
    backgroundColor: Color(0xFF2b2119),
  ),
);

ThemeData darkBlueTheme = ThemeData.dark().copyWith(
  primaryColor: const Color(0xFF1E1E2C),
  scaffoldBackgroundColor: const Color(0xFF2D2D44),
);

InputDecorationTheme _inputDecorationTheme(String themeName) {
  final isDark = themeName == 'light';
  final fillColor = isDark ? Colors.grey[800] : Colors.grey[200];
  final focusColor = isDark ? Colors.grey[600] : Colors.grey[400];
  final hoverColor = isDark ? Colors.grey[600] : Colors.grey[400];
  final errorColor = isDark ? Colors.red[300] : Colors.red[700];
  final labelStyle = TextStyle(
      color: isDark ? Colors.grey[400] : Colors.grey[600],
      fontWeight: FontWeight.bold);
  final hintStyle = TextStyle(
      color: isDark ? Colors.grey[400] : Colors.grey[600],
      fontWeight: FontWeight.bold);
  final errorStyle = TextStyle(
      color: isDark ? Colors.red[300] : Colors.red[700],
      fontWeight: FontWeight.bold);
  final helperStyle = TextStyle(
      color: isDark ? Colors.grey[400] : Colors.grey[600],
      fontWeight: FontWeight.bold);
  final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: focusColor!, width: 2));
  final enabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: fillColor!, width: 2));
  final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: fillColor, width: 2));
  final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: errorColor!, width: 2));
  final focusedErrorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: errorColor, width: 2));
  final disabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: fillColor, width: 2));
  const isDense = true;
  const contentPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 5);
  final prefixStyle = TextStyle(
      color: isDark ? Colors.grey[400] : Colors.grey[600],
      fontWeight: FontWeight.bold);
  final suffixStyle = TextStyle(
      color: isDark ? Colors.grey[400] : Colors.grey[600],
      fontWeight: FontWeight.bold);
  final counterStyle = TextStyle(
      color: isDark ? Colors.grey[400] : Colors.grey[600],
      fontWeight: FontWeight.bold);
  final iconColor = isDark ? Colors.grey[400] : Colors.grey[600];
  return InputDecorationTheme(
    helperStyle: helperStyle,
    iconColor: iconColor,
    isDense: isDense,
    contentPadding: contentPadding,
    prefixStyle: prefixStyle,
    fillColor: fillColor,
    filled: true,
    focusColor: focusColor,
    hoverColor: hoverColor,
    labelStyle: labelStyle,
    hintStyle: hintStyle,
    errorStyle: errorStyle,
    focusedBorder: focusedBorder,
    enabledBorder: enabledBorder,
    border: border,
    errorBorder: errorBorder,
    focusedErrorBorder: focusedErrorBorder,
    disabledBorder: disabledBorder,
    suffixStyle: suffixStyle,
    counterStyle: counterStyle,
  );
}

// text theme for bodysmall, bodymedium, bodylarge, titlesmall, titlemedium, titlelarge, displaymedium, displaylarge

TextTheme textTheme(String theme) {
  Color lightColor = theme == 'light' ? Colors.black54 : Colors.white54;
  Color mediumColor = theme == 'light' ? Colors.black87 : Colors.white70;
  Color darkColor = theme == 'light' ? Colors.black : Colors.white;
  double sizeIncrement = 0;

  return TextTheme(
    bodySmall: TextStyle(
      color: lightColor,
      fontSize: 12 + sizeIncrement,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      color: lightColor,
      fontSize: 14 + sizeIncrement,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      color: lightColor,
      fontSize: 16 + sizeIncrement,
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: mediumColor,
      fontSize: 18 + sizeIncrement,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      color: mediumColor,
      fontSize: 20 + sizeIncrement,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      color: mediumColor,
      fontSize: 22 + sizeIncrement,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      color: darkColor,
      fontSize: 22 + sizeIncrement,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: TextStyle(
      color: darkColor,
      fontSize: 26 + sizeIncrement,
      fontWeight: FontWeight.w700,
    ),
    displayLarge: TextStyle(
      color: darkColor,
      fontSize: 28 + sizeIncrement,
      fontWeight: FontWeight.w700,
    ),
  );
}

ElevatedButtonThemeData _getElevatedButtonTheme(String theme) {
  Color backgroundColor = theme == 'light' ? kPrimaryColor5 : kPrimaryColor6;
  Color foregroundColor = Colors.white;
  double elevation = 5;
  double borderRadius = 10;

  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: foregroundColor,
      ),
    ),
  );
}

TextButtonThemeData _getTextButtonTheme(String theme) {
  Color backgroundColor = theme == 'light' ? kPrimaryColor5 : kPrimaryColor6;
  Color foregroundColor = Colors.white;
  double elevation = 5;
  double borderRadius = 10;

  return TextButtonThemeData(
    style: TextButton.styleFrom(
      // backgroundColor: backgroundColor,
      foregroundColor: backgroundColor,
      // elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: foregroundColor,
      ),
    ),
  );
}

TextSelectionThemeData _getTextSelectionThemeData(String theme) {
  Color cursorColor = theme == 'light' ? kPrimaryColor5 : kPrimaryColor6;
  Color selectionColor = theme == 'light' ? kPrimaryColor5 : kPrimaryColor6;
  Color selectionHandleColor =
      theme == 'light' ? kPrimaryColor5 : kPrimaryColor6;

  return TextSelectionThemeData(
    cursorColor: cursorColor,
    selectionColor: selectionColor,
    selectionHandleColor: selectionHandleColor,
  );
}

/// Drawer Theme
DrawerThemeData _getDrawerThemeData(String theme) {
  Color backgroundColor = theme == 'light' ? kPrimaryColor3 : kPrimaryColor2;
  // Color? iconColor = theme != 'light' ? kPrimaryColor3 : kPrimaryColor2;
  // Color? textColor = theme != 'light' ? kPrimaryColor3 : kPrimaryColor2;

  return DrawerThemeData(
    backgroundColor: backgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
    elevation: 10,
    endShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
    ),
  );
}

/// Scrollbar Theme
ScrollbarThemeData _getScrollbarTheme(String theme) {
  Color? thumbColor = theme == 'light' ? Colors.white70 : Colors.white70;
  Color? trackColor = theme == 'light' ? Colors.white10 : Colors.white10;
  double? thickness = 10;
  Radius? radius = const Radius.circular(20);

  return ScrollbarThemeData(
    thumbColor: MaterialStateProperty.all(thumbColor),
    trackColor: MaterialStateProperty.all(trackColor),
    thickness: MaterialStateProperty.all(thickness),
    radius: radius,
    interactive: true,
    crossAxisMargin: 0,
    mainAxisMargin: 0,
  );
}
