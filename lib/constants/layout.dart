// ignore_for_file: library_private_types_in_public_api

import 'package:agricare/screens/dashboard.dart';
import 'package:agricare/screens/employee.dart';
import 'package:agricare/screens/farms.dart';
import 'package:agricare/screens/machinery.dart';
import 'package:agricare/screens/settings.dart';
import 'package:agricare/screens/supervisors.dart';
import 'package:agricare/screens/supplies.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int topIndex = 0;

  // Define your NavigationPaneItem list here
  List<NavigationPaneItem> items = [
    PaneItem(
      icon: const Icon(FluentIcons.home),
      title: const Text('Home'),
      body: const _NavigationBodyItem(
        header: 'Home',
        content: Dashboard(),
      ),
    ),
    PaneItemSeparator(),
    PaneItem(
      icon: const Icon(FluentIcons.user_event),
      title: const Text('Employee'),
      body: const _NavigationBodyItem(
        header: 'Employee',
        content: EmployeePage(),
      ),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.user_gauge),
      title: const Text('Superisor'),
      body: const _NavigationBodyItem(
        header: 'Superisor',
        content: SupervisorPage(),
      ),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.folder),
      title: const Text('Farms'),
      body: const _NavigationBodyItem(
        header: 'Farms',
        content: Farms(),
      ),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.machine_learning),
      title: const Text('Machinery'),
      body: const _NavigationBodyItem(
        header: 'Machinery',
        content: Machinerys(),
      ),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.product_release),
      title: const Text('Supplies'),
      body: const _NavigationBodyItem(
        header: 'Supplies',
        content: SuppliesScreen(),
      ),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.file_request),
      title: const Text('Requested'),
      body: const _NavigationBodyItem(
        header: 'Requested',
        content: EmployeePage(),
      ),
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavigationView(
        pane: NavigationPane(
          selected: topIndex,
          onChanged: (index) => setState(() => topIndex = index),
          displayMode: PaneDisplayMode.compact,
          items: items,
          footerItems: [
            PaneItem(
              icon: const Icon(FluentIcons.settings),
              title: const Text('Settings'),
              body: const _NavigationBodyItem(content: SettingsPage()),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationBodyItem extends StatelessWidget {
  final String header;
  final Widget content;

  const _NavigationBodyItem({this.header = '', required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (header.isNotEmpty) ...[
              Text(
                header,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8.0),
            ],
            content,
          ],
        ),
      ),
    );
  }
}
