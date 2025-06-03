import 'dart:io';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final ref = FirebaseStorage.instance.ref().child("user_profiles/${user.uid}.jpg");

      try {
        final url = await ref.getDownloadURL();
        setState(() {
          _profileImageUrl = "$url?ts=${DateTime.now().millisecondsSinceEpoch}";
        });
      } catch (e) {
        print("No profile image found or error: $e");
      }
    }
  }

  Future<void> _pickAndUploadImage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      final ref = FirebaseStorage.instance.ref().child("user_profiles/${user.uid}.jpg");

      try {
        if (kIsWeb) {
          // Web: Upload image as bytes
          final bytes = await pickedFile.readAsBytes();
          await ref.putData(bytes, SettableMetadata(contentType: 'image/jpeg'));
        } else {
          // Mobile: Upload image as file
          final file = File(pickedFile.path);
          await ref.putFile(file);
        }

        final downloadUrl = await ref.getDownloadURL();
        final timestamp = DateTime.now().millisecondsSinceEpoch;

        setState(() {
          _profileImageUrl = "$downloadUrl?ts=$timestamp";
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile picture updated")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to upload image: $e")),
        );
      }
    }
  }

  void _showChangePasswordDialog() {
    final TextEditingController _passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text("Change Password", style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: _passwordController,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: "Enter new password",
              hintStyle: TextStyle(color: Colors.white54),
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel", style: TextStyle(color: Colors.redAccent)),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text("Update", style: TextStyle(color: Colors.white)),
              onPressed: () async {
                final newPassword = _passwordController.text.trim();
                if (newPassword.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Password must be at least 6 characters")),
                  );
                  return;
                }

                try {
                  await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Password updated successfully")),
                  );
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: ${e.toString()}")),
                  );
                }
              },
            )
          ],
        );
      },
    );
  }

  void _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? 'No Email';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: _profileImageUrl != null
                      ? NetworkImage(_profileImageUrl!)
                      : const AssetImage("assets/images/profile.png") as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: _pickAndUploadImage,
                    child: const CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      radius: 18,
                      child: Icon(Icons.edit, size: 18, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Text(email, style: const TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              icon: const Icon(Icons.lock_reset, color: Colors.black),
              label: const Text(
                "Change Password",
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
              ),
              onPressed: _showChangePasswordDialog,
            ),
            const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              icon: const Icon(Icons.logout, color: Colors.black),
              label: const Text(
                "Logout",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              onPressed: _logout,
            ),
          ],
        ),
      ),
    );
  }
}
