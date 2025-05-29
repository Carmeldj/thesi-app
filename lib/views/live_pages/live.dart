import 'package:flutter/material.dart';
import 'package:stream_video/stream_video.dart';
import 'package:thesis_app/controllers/cubit/stream/stream_cubit.dart';
import 'package:thesis_app/views/live_pages/live_stream_screen.dart';

class LivePage extends StatelessWidget {
  LivePage({super.key});
  final StreamCubit streamCubit = StreamCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text("Historique de vos lives", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: 95,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Live 1", style: TextStyle(fontSize: 25)),
                              Text(
                                "Vues",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                              Text("100", style: TextStyle(fontSize: 25)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final streamData = await streamCubit.createUserStream();
          _createLivestream(context, streamData["streamId"]);
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}

Future<void> _createLivestream(BuildContext context, String callId) async {
  final call = StreamVideo.instance.makeCall(
    callType: StreamCallType.liveStream(),
    id: callId,
  );

  final result = await call.getOrCreate(
    members: [
      MemberRequest(userId: StreamVideo.instance.currentUser.id, role: 'host'),
    ],
  ); // Call object is created

  if (result.isFailure) {
    debugPrint('Not able to create a call.');
    return;
  }

  if (result.isSuccess) {
    // Set some default behaviour for how our devices should be configured once we join a call
    final connectOptions = CallConnectOptions(
      camera: TrackOption.enabled(),
      microphone: TrackOption.enabled(),
    );

    // Our local app user can join and receive events
    await call.join(connectOptions: connectOptions);

    // Allow others to see and join the call (exit backstage mode)
    await call.goLive();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LiveStreamScreen(livestreamCall: call),
      ),
    );
  } else {
    debugPrint('Not able to create a call.');
  }
}
