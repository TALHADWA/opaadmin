import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("acceptall").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const CircularProgressIndicator();
                }

                final doc = snapshot.data!.docs.first;
                final isOn = doc['ison'] as bool;

                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "Accepting Submissions:",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      AnimatedToggleSwitch<bool>.dual(
                        current: isOn,
                        first: false,
                        second: true,
                    //    borderColor: Colors.transparent,
                        height: 40,
                      //  dif: 20,
                        borderWidth: 2.0,
                        style: ToggleStyle(
                          backgroundColor: Colors.grey.shade300,
                          indicatorColor: Colors.blue,
                        ),
                        onChanged: (value) {
                          FirebaseFirestore.instance
                              .collection("acceptall")
                              .doc(doc.id)
                              .update({'ison': value});
                        },
                        iconBuilder: (value) => value
                            ? const Icon(Icons.check, color: Colors.white)
                            : const Icon(Icons.close, color: Colors.white),
                        textBuilder: (value) => Text(
                          value ? "On" : "Off",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("SubmittedAds").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final data = snapshot.data!.docs;

                  if (data.isEmpty) {
                    return const Center(child: Text("No ads submitted yet."));
                  }

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final ad = data[index];

                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: ad['imageUrls'][0] ??
                                  "https://via.placeholder.com/50",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            ad['Category'] ?? 'No Title',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Text(ad['Description'] ?? 'No Description'),
                          trailing: Wrap(
                            spacing: 8,
                            children: [
                              if (ad["status"] == "pending" ||
                                  ad["status"] == "rejected")
                                ElevatedButton.icon(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("SubmittedAds")
                                        .doc(ad.id)
                                        .update({"status": "Approved"});
                                  },
                                  icon: const Icon(Icons.check),
                                  label: const Text("Approve"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                ),
                              if (ad["status"] == "pending" ||
                                  ad["status"] == "Approved")
                                ElevatedButton.icon(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("SubmittedAds")
                                        .doc(ad.id)
                                        .update({"status": "rejected"});
                                  },
                                  icon: const Icon(Icons.close),
                                  label: const Text("Reject"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
