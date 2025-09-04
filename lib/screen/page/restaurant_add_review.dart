import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission/provider/restaurant_add_preview_provider.dart';
import 'package:restaurant_app_submission/screen/static/restaurant_add_preview_state.dart';

class AddReviewPage extends StatefulWidget {
  final String restaurantId;
  const AddReviewPage({super.key, required this.restaurantId});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Review")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ReviewProvider>(
          builder: (context, provider, child) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: "Nama",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? "Nama wajib diisi"
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _reviewController,
                      decoration: const InputDecoration(
                        labelText: "Review",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) => value == null || value.isEmpty
                          ? "Review wajib diisi"
                          : null,
                    ),
                    const SizedBox(height: 24),
                    provider.state is RestaurantAddReviewLoadingState
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () async {
                              if (_nameController.text.isEmpty ||
                                  _reviewController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Nama dan review tidak boleh kosong",
                                    ),
                                  ),
                                );
                                return;
                              }
                
                              final provider = Provider.of<ReviewProvider>(
                                context,
                                listen: false,
                              );
                
                              final success = await provider.addReview(
                                widget.restaurantId,
                                _nameController.text,
                                _reviewController.text,
                              );
                
                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Review berhasil ditambahkan"),
                                  ),
                                );
                                Navigator.pop(context);
                              } else {
                                final reviewState = Provider.of<ReviewProvider>(
                                  context,
                                  listen: false,
                                ).state;
                
                                if (reviewState
                                    is RestaurantAddReviewErrorState) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(reviewState.message)),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Gagal mengirim review"),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text("Kirim"),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
