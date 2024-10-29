import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? _selectedTheme = 'Light'; // For theme selection
  bool _notificationsEnabled = true; // For notification state
  String appVersion = '';

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version; // Get app version
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define themes
    ThemeData lightTheme = ThemeData.light();
    ThemeData darkTheme = ThemeData.dark();

    return MaterialApp(
      theme: _selectedTheme == 'Dark' ? darkTheme : lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            // Profile Section
            

            // Theme Section
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Text('Theme'),
              trailing: DropdownButton<String>(
                value: _selectedTheme,
                items: <String>['Light', 'Dark'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTheme = value;
                  });
                },
                hint: Text('Select Theme'),
              ),
            ),
            Divider(),

            // Notification Settings
            SwitchListTile(
              title: Text('Notifications'),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            Divider(),

            // Account Management
            
           

            // About Section
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                // Show app version and other details
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('About'),
                      content: Text('App version: $appVersion'),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Divider(),

            // Feedback Section
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Feedback'),
              onTap: () {
                // Navigate to feedback form
                Navigator.pushNamed(context, '/feedback');
              },
            ),
          ],
        ),
      ),
    );
  }
}
