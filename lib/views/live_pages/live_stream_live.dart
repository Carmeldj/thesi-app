import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

class LivestreamLiveWidget extends StatelessWidget {
  const LivestreamLiveWidget({super.key, required this.call});

  final Call call;

  @override
  Widget build(BuildContext context) {
    // When the livestream is live we have to listen to all call state changes.
    return StreamBuilder(
      stream: call.state.valueStream,
      initialData: call.state.value,
      builder: (context, snapshot) {
        final callState = snapshot.data!;

        return StreamCallContainer(
          call: call,
          callContentBuilder: (context, call, state) {
            var participant = state.callParticipants.firstWhereOrNull(
              (e) => e.roles.contains('host'),
            );

            if (participant == null) {
              return const Center(
                child: Text("The host's video is not available"),
              );
            }

            return StreamCallContent(
              call: call,
              callState: callState,
              callAppBarBuilder:
                  (context, call, callState) => CallAppBar(
                    call: call,
                    showBackButton: false,
                    title: Text(
                      'Viewers: ${callState.callParticipants.length}',
                    ),
                    onLeaveCallTap: () {
                      call.stopLive();
                    },
                  ),
              callParticipantsBuilder: (context, call, state) {
                return StreamCallParticipants(
                  call: call,
                  participants: [participant],
                );
              },
            );
          },
        );
      },
    );
  }
}
