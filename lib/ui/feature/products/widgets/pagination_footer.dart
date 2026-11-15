import 'package:material_ui/material_ui.dart';

class PaginationFooter extends StatelessWidget {
  const PaginationFooter({
    super.key,
    required this.isLoading,
    required this.failed,
    required this.hasMore,
    required this.onRetry,
  });

  final bool isLoading, failed, hasMore;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (failed) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Falhou. Tentar novamente'),
          ),
        ),
      );
    }
    if (!hasMore) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(
          child: Text('Chegaste ao fim', style: TextStyle(color: Colors.grey)),
        ),
      );
    }
    return const SizedBox(height: 24);
  }
}
