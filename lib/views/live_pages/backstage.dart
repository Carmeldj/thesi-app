import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stream_video/stream_video.dart';

class BackstageWidget extends StatelessWidget {
  const BackstageWidget({
    super.key,
    required this.callState,
    required this.call,
  });

  final CallState callState;
  final Call call;

  @override
  Widget build(BuildContext context) {
    final startsAt = callState.startsAt;
    final waitingParticipants =
        callState.callParticipants
            .where((p) => !p.roles.contains('host'))
            .toList();

    return Center(
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            startsAt != null
                ? 'Livestream starting at ${DateFormat('HH:mm').format(startsAt.toLocal())}'
                : 'Livestream starting soon',
            // style: Theme(data: data, child: child).of(context).textTheme.titleLarge,
          ),
          if (waitingParticipants.isNotEmpty)
            Text('${waitingParticipants.length} participants waiting'),
          ElevatedButton(
            onPressed: () {
              call.goLive();
            },
            child: const Text('Go Live'),
          ),
          ElevatedButton(
            onPressed: () {
              call.leave();
              Navigator.pop(context);
            },
            child: const Text('Leave Livestream'),
          ),
        ],
      ),
    );
  }
}
