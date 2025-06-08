import 'package:flutter/material.dart';
import 'package:stream_video/stream_video.dart';
import 'package:thesis_app/components/input.dart';
import 'package:thesis_app/controllers/cubit/stream/stream_cubit.dart';
import 'package:thesis_app/views/live_pages/live_stream_screen.dart';

class GoLivePage extends StatelessWidget {
  GoLivePage({super.key});
  final StreamCubit streamCubit = StreamCubit();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Go live",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  Input(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Ajoutez un titre",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Input(
                    controller: descriptionController,
                    minLines: 6,
                    decoration: InputDecoration(
                      hintText: "Ajoutez une description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 50,
                              left: 10,
                              right: 10,
                            ),
                            child: Center(
                              child: SizedBox(
                                height: 500,
                                child: ListView(
                                  children: [
                                    Container(
                                      height: 80,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Center(),
                                              ),
                                              SizedBox(width: 20),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Cozy Knit Sweater"),
                                                  Text("1000"),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Checkbox(
                                            value: false,
                                            onChanged: (bool? newValue) {},
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      height: 80,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Center(),
                                              ),
                                              SizedBox(width: 20),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Cozy Knit Sweater"),
                                                  Text("1000"),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Checkbox(
                                            value: false,
                                            onChanged: (bool? newValue) {},
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      height: 80,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Center(),
                                              ),
                                              SizedBox(width: 20),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Cozy Knit Sweater"),
                                                  Text("1000"),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Checkbox(
                                            value: false,
                                            onChanged: (bool? newValue) {},
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width -
                                            20,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          color: Colors.red,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Commencer le live",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 20),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(108, 231, 90, 80),
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(Icons.add, color: Colors.red),
                              ),
                              SizedBox(width: 20),
                              Text(
                                "Ajoutez un produit",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.arrow_forward_ios),
                              SizedBox(width: 20),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () async {
                  streamCubit.createStream().then((value) async {
                    await _createLivestream(context, value["streamId"]);
                  });
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      "Commencer le live",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
      MaterialPageRoute(builder: (context) => LiveStreamScreen(call: call)),
    );
  } else {
    debugPrint('Not able to create a call.');
  }
}
