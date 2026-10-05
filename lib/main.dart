import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:yecontinuity/config/providers/bottom_navigation_provider.dart';
import 'package:yecontinuity/ui/core/themes/theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YEContinuity',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MainScreen(),
      ),
    );
  }
}

class MainScreen extends ConsumerWidget {
  int currentIndex = 0;
  final List<Widget> _pages = [
    Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home'),
            CircleAvatar(
              child: Image.asset(
                'assets/images/logo.png',
              ),
              backgroundColor: AppTheme.lightTheme.primaryColor,
            ),
          ],
        ),
      ),
    ),
    Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Add'),
            CircleAvatar(
              child: Image.asset(
                'assets/images/logo.png',
              ),
              backgroundColor: AppTheme.lightTheme.primaryColor,
            ),
          ],
        ),
      ),
    ),
    Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Chats'),
            CircleAvatar(
              child: Image.asset(
                'assets/images/logo.png',
              ),
              backgroundColor: AppTheme.lightTheme.primaryColor,
            ),
          ],
        ),
      ),
    ),
    Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Profile'),
            CircleAvatar(
              child: Image.asset(
                'assets/images/logo.png',
              ),
              backgroundColor: AppTheme.lightTheme.primaryColor,
            ),
          ],
        ),
      ),
    ),
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavigationProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(bottomNavigationProvider.notifier).changepage(index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
        ],
      ),
    );
  }
}
