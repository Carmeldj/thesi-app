import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';
// import 'package:thesis_app/views/live_pages/backstage.dart';
// import 'package:thesis_app/views/live_pages/live_ended.dart';
// import 'package:thesis_app/views/live_pages/live_stream_live.dart';

class LiveStreamScreen extends StatefulWidget {
  final Call call;
  const LiveStreamScreen({super.key, required this.call});

  @override
  State<LiveStreamScreen> createState() => _LiveStreamScreenState();
}

class _LiveStreamScreenState extends State<LiveStreamScreen> {
  int viewerCount = 0;
  List<String> comments = [];
  final TextEditingController _commentController = TextEditingController();
  bool isCameraOn = true;
  bool isMicOn = true;
  bool showProductPanel = false;
  dynamic pinnedProduct;
  List products = [
    {
      "id": '1',
      "name": 'Wireless Headphones',
      "price": 79.99,
      "originalPrice": 99.99,
      "imageUrl": 'https://via.placeholder.com/150',
      "description": 'High-quality wireless headphones with noise cancellation',
      "stock": 25,
    },
    {
      "id": '2',
      "name": 'Smart Watch',
      "price": 199.99,
      "originalPrice": 249.99,
      "imageUrl": 'https://via.placeholder.com/150',
      "description": 'Feature-rich smartwatch with health tracking',
      "stock": 15,
    },
    {
      "id": '3',
      "name": 'Phone Case',
      "price": 24.99,
      "originalPrice": 34.99,
      "imageUrl": 'https://via.placeholder.com/150',
      "description": 'Protective phone case with premium design',
      "stock": 50,
    },
  ];

  @override
  void initState() {
    super.initState();
    _setupCallListeners();
  }

  void _setupCallListeners() {
    // Listen to call events for viewer count, comments, etc.
    widget.call.state.listen((callState) {
      if (!mounted) return;
      setState(() {
        viewerCount = callState.participantCount; // Exclude the host
      });
    });
  }

  void _addComment(String comment) {
    setState(() {
      comments.add(comment);
      if (comments.length > 50) {
        comments.removeAt(0); // Keep only recent comments
      }
    });
  }

  void _sendComment() {
    if (_commentController.text.isNotEmpty) {
      _addComment(_commentController.text);
      _commentController.clear();
    }
  }

  void _toggleCamera() {
    setState(() {
      isCameraOn = !isCameraOn;
    });
    widget.call.setCameraEnabled(enabled: isCameraOn);
  }

  void _toggleMic() {
    setState(() {
      isMicOn = !isMicOn;
    });
    widget.call.setMicrophoneEnabled(enabled: isMicOn);
  }

  void _endStream() {
    widget.call.leave();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _toggleProductPanel() {
    setState(() {
      showProductPanel = !showProductPanel;
    });
  }

  void _pinProduct(dynamic product) {
    setState(() {
      pinnedProduct = product;
      showProductPanel = false;
    });
    _addComment('📌 Pinned: ${product["name"]} - ${product["price"]}');
  }

  void _unpinProduct() {
    setState(() {
      pinnedProduct = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Video Stream Background
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: StreamCallContainer(
              call: widget.call,
              callContentBuilder: (context, call, callState) {
                return StreamVideoRenderer(
                  call: call,
                  participant: callState.localParticipant!,
                  videoTrackType: SfuTrackType.video,
                );
              },
            ),
          ),

          // Top Bar with viewer count and end stream button
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.visibility, color: Colors.white, size: 16),
                      SizedBox(width: 5),
                      Text(
                        '$viewerCount',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _endStream();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // Comments Section
          Positioned(
            bottom: 120,
            left: 20,
            right: 100,
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                reverse: true,
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 5),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      comments[comments.length - 1 - index],
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ),

          // Control Buttons (Camera, Mic, etc.)
          Positioned(
            bottom: 120,
            right: 20,
            child: Column(
              children: [
                _buildControlButton(
                  icon: isCameraOn ? Icons.videocam : Icons.videocam_off,
                  onTap: _toggleCamera,
                ),
                SizedBox(height: 15),
                _buildControlButton(
                  icon: isMicOn ? Icons.mic : Icons.mic_off,
                  onTap: _toggleMic,
                ),
                SizedBox(height: 15),
                _buildControlButton(
                  icon: Icons.flip_camera_ios,
                  onTap: () => widget.call.flipCamera(),
                ),
                SizedBox(height: 15),
                _buildControlButton(
                  icon: Icons.shopping_bag,
                  onTap: _toggleProductPanel,
                  isActive: showProductPanel,
                ),
              ],
            ),
          ),
          if (pinnedProduct != null)
            Positioned(
              top: 100,
              left: 20,
              child: Container(
                width: 200,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.pink, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.push_pin, color: Colors.pink, size: 16),
                        SizedBox(width: 5),
                        Text(
                          'PINNED',
                          style: TextStyle(
                            color: Colors.pink,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: _unpinProduct,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade700,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.image, color: Colors.white54),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pinnedProduct!["name"],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    '${pinnedProduct!["price"]}',
                                    style: TextStyle(
                                      color: Colors.pink,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  if (pinnedProduct!["originalPrice"] !=
                                      pinnedProduct!["price"])
                                    Text(
                                      '${pinnedProduct!["originalPrice"]}',
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 10,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          // Product Management Panel
          if (showProductPanel)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    // Panel Header
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            color: Colors.pink,
                            size: 24,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Product Management',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: _toggleProductPanel,
                            child: Icon(Icons.close, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.white24),

                    // Products List
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          final isPinned =
                              pinnedProduct?["id"] == product["id"];

                          return Container(
                            margin: EdgeInsets.only(bottom: 15),
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color:
                                  isPinned
                                      ? const Color.fromARGB(103, 233, 30, 98)
                                      : Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  isPinned
                                      ? Border.all(color: Colors.pink, width: 2)
                                      : null,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // Product Image Placeholder
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade700,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.image,
                                        color: Colors.white54,
                                      ),
                                    ),
                                    SizedBox(width: 15),

                                    // Product Info
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product["name"],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Text(
                                                '${product["price"]}',
                                                style: TextStyle(
                                                  color: Colors.pink,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              if (product["originalPrice"] !=
                                                  product["price"])
                                                Text(
                                                  '${product["originalPrice"]}',
                                                  style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 14,
                                                    decoration:
                                                        TextDecoration
                                                            .lineThrough,
                                                  ),
                                                ),
                                            ],
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            'Stock: ${product["stock"]}',
                                            style: TextStyle(
                                              color:
                                                  product["stock"] > 0
                                                      ? Colors.green
                                                      : Colors.red,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 10),

                                // Product Description
                                Text(
                                  product["description"],
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                SizedBox(height: 15),

                                // Action Buttons
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed:
                                            isPinned
                                                ? _unpinProduct
                                                : () => _pinProduct(product),
                                        icon: Icon(
                                          isPinned
                                              ? Icons.push_pin
                                              : Icons.push_pin_outlined,
                                          size: 16,
                                        ),
                                        label: Text(
                                          isPinned ? 'Unpin' : 'Pin',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              isPinned
                                                  ? Colors.pink
                                                  : Colors.grey.shade700,
                                          foregroundColor: Colors.white,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    // Add Product Button
                    Container(
                      padding: EdgeInsets.all(20),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Add product feature coming soon!',
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.add),
                          label: Text('Add New Product'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Comment Input
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      hintStyle: TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.black54,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    onSubmitted: (_) => _sendComment(),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: _sendComment,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.pink, Colors.purple],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildControlButton({
  required IconData icon,
  required VoidCallback onTap,
  bool isActive = false,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? Colors.pink : Colors.black54,
        shape: BoxShape.circle,
        border: isActive ? Border.all(color: Colors.pink, width: 2) : null,
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    ),
  );
}
