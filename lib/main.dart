import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/app_module.dart';
import 'package:github_search/app_widget.dart';

import 'modules/search/presenter/search/search_page.dart';

void main() {
  runApp(ModularApp(
    module: AppModule(), child: AppWidget()));
}
