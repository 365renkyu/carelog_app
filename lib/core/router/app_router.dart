import 'package:flutter/material.dart';
import 'package:ikuji_kiroku_app/features/calendar/calendar_screen.dart';
import 'package:ikuji_kiroku_app/features/record/detail/record_detail_screen.dart';
import 'package:ikuji_kiroku_app/features/record/edit/record_edit_screen.dart';
import 'package:ikuji_kiroku_app/features/therapy_schedule/edit/therapy_schedule_edit_provider.dart';
import 'package:ikuji_kiroku_app/features/therapy_schedule/edit/therapy_schedule_edit_screen.dart';
import 'package:ikuji_kiroku_app/features/absence_contact/absence_contact_screen.dart';
import 'package:ikuji_kiroku_app/features/export/export_screen.dart';
import 'package:ikuji_kiroku_app/features/settings/settings_screen.dart';
import 'package:ikuji_kiroku_app/features/settings/absence_templates/absence_template_settings_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String calendar = '/';
  static const String recordDetail = '/record/detail';
  static const String recordEdit = '/record/edit';
  static const String therapyScheduleEdit = '/therapy-schedule/edit';
  static const String absenceContact = '/absence-contact';
  static const String export = '/export';
  static const String settings = '/settings';
  static const String absenceTemplateSettings = '/settings/absence-templates';
}

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.calendar:
        return MaterialPageRoute(builder: (_) => const CalendarScreen());

      case AppRoutes.recordDetail:
        final date = settings.arguments as DateTime;
        return MaterialPageRoute(
          builder: (_) => RecordDetailScreen(date: date),
        );

      case AppRoutes.recordEdit:
        final date = settings.arguments as DateTime;
        return MaterialPageRoute(
          builder: (_) => RecordEditScreen(date: date),
        );

      case AppRoutes.therapyScheduleEdit:
        final args = settings.arguments as TherapyScheduleEditArgs?;
        return MaterialPageRoute(
          builder: (_) => TherapyScheduleEditScreen(args: args),
        );

      case AppRoutes.absenceContact:
        final date = settings.arguments as DateTime;
        return MaterialPageRoute(
          builder: (_) => AbsenceContactScreen(date: date),
        );

      case AppRoutes.export:
        final date = settings.arguments as DateTime?;
        return MaterialPageRoute(
          builder: (_) => ExportScreen(initialDate: date),
        );

      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      case AppRoutes.absenceTemplateSettings:
        return MaterialPageRoute(
          builder: (_) => const AbsenceTemplateSettingsScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('ページが見つかりません')),
          ),
        );
    }
  }
}
