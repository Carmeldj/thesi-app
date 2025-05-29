import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';
import 'package:thesis_app/views/live_pages/backstage.dart';
import 'package:thesis_app/views/live_pages/live_ended.dart';
import 'package:thesis_app/views/live_pages/live_stream_live.dart';

class LiveStreamScreen extends StatefulWidget {
  const LiveStreamScreen({super.key, required this.livestreamCall});

  final Call livestreamCall;

  @override
  State<LiveStreamScreen> createState() => _LiveStreamScreenState();
}

class _LiveStreamScreenState extends State<LiveStreamScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // We use distinct to prevent unnecessary rebuilds of the UI
      stream: widget.livestreamCall.state.valueStream.distinct(
        (previous, current) =>
            previous.isBackstage == current.isBackstage &&
            previous.endedAt == current.endedAt,
      ),
      initialData: widget.livestreamCall.state.value,
      builder: (context, snapshot) {
        final callState = snapshot.data!;

        return Scaffold(
          body: Builder(
            builder: (context) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (callState.isBackstage) {
                  return BackstageWidget(
                    callState: callState,
                    call: widget.livestreamCall,
                  );
                }

                if (callState.endedAt != null) {
                  return LivestreamEndedWidget(
                    callState: callState,
                    call: widget.livestreamCall,
                  );
                }

                return LivestreamLiveWidget(call: widget.livestreamCall);
              }
            },
          ),
        );
      },
    );
  }
}
