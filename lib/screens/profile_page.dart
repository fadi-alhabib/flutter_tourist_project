import 'package:flutter/material.dart';
import 'package:tourist/widgets/subscription_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = 'John Doe';
  String userImage = 'https://i.pravatar.cc/150?img=10';
  String? subscriptionStatus;

  void _openSubscriptionDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => const SubscriptionDialog(),
    );

    if (result != null) {
      setState(() => subscriptionStatus = result);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Subscribed to $result plan!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSubscribed = subscriptionStatus != null;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 50, backgroundImage: NetworkImage(userImage)),
          const SizedBox(height: 16),
          Text(userName, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.subscriptions, color: Colors.orange),
                const SizedBox(width: 10),
                Text(
                  'Subscription Status: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Spacer(),
                Text(
                  isSubscribed ? subscriptionStatus! : 'Not Subscribed',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isSubscribed ? Colors.green : Colors.redAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _openSubscriptionDialog,
            icon: const Icon(Icons.payment),
            label: Text(isSubscribed ? 'Update Plan' : 'Subscribe Now'),
          ),
        ],
      ),
    );
  }
}
