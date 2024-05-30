// ignore_for_file: library_private_types_in_public_api

import 'package:agricare/screens/dashboard.dart';
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
      icon: const Icon(FluentIcons.issue_tracking),
      title: const Text('Track orders'),
      infoBadge: const InfoBadge(source: Text('8')),
      body: const _NavigationBodyItem(
        header: 'Badging',
        content: Text(
          'Badging is a non-intrusive and intuitive way to display '
          'notifications or bring focus to an area within an app - '
          'whether that be for notifications, indicating new content, '
          'or showing an alert. An InfoBadge is a small piece of UI '
          'that can be added into an app and customized to display a '
          'number, icon, or a simple dot.',
        ),
      ),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.disable_updates),
      title: const Text('Disabled Item'),
      body: const _NavigationBodyItem(content: Text('Disabled Item')),
      enabled: false,
    ),
    
    PaneItemExpander(
      icon: const Icon(FluentIcons.account_management),
      title: const Text('Account'),
      body: const _NavigationBodyItem(
        header: 'PaneItemExpander',
        content: Text(
          'Some apps may have a more complex hierarchical structure '
          'that requires more than just a flat list of navigation '
          'items. You may want to use top-level navigation items to '
          'display categories of pages, with children items displaying '
          'specific pages. It is also useful if you have hub-style '
          'pages that only link to other pages. For these kinds of '
          'cases, you should create a hierarchical NavigationView.',
        ),
      ),
      items: [
        PaneItemHeader(header: const Text('Apps')),
        PaneItem(
          icon: const Icon(FluentIcons.mail),
          title: const Text('Mail'),
          body: const _NavigationBodyItem(content: Text('Mail')),
        ),
        PaneItem(
          icon: const Icon(FluentIcons.calendar),
          title: const Text('Calendar'),
          body: const _NavigationBodyItem(content: Text('Calendar')),
        ),
      ],
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
              body: const _NavigationBodyItem(content: Text('Settings')),
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
    );
  }
}
