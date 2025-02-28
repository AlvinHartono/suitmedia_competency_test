import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia_competency_test/config/routes/app_router.dart';
import 'package:suitmedia_competency_test/config/theme/theme.dart';
import 'package:suitmedia_competency_test/features/palindrome/presentation/bloc/palindrome_bloc.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/presentation/bloc/reqres_user_list_bloc.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/presentation/bloc/resqres_user_list_event.dart';
import 'package:suitmedia_competency_test/features/selected_user/presentation/bloc/selected_user_bloc.dart';
import 'package:suitmedia_competency_test/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.initializeDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<PalindromeBloc>()),
        BlocProvider(create: (_) => di.sl<SelectedUserBloc>()),
        BlocProvider(
          create: (_) => di.sl<ReqresUserBloc>()..add(GetReqresUserEvent()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suitmedia Test',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
    );
  }
}
