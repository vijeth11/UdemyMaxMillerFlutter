import 'package:flutter/material.dart';
import 'package:grocia/constants/colors.dart';
import 'package:grocia/screen/home_screen.dart';
import 'package:grocia/screen/sign_in_screen.dart';
import 'package:grocia/screen/sign_up_screen.dart';
import 'package:grocia/widgets/save_changes_button.dart';
import 'package:routemaster/routemaster.dart';
import 'package:video_player/video_player.dart';

class LandingScreen extends StatefulWidget {
  static const String routeName = "/landing";
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/grocery.mp4');
    _controller.initialize().then((_) {
      print(_controller.value.aspectRatio);
      print(_controller.value.errorDescription);
      _controller.play();
      _controller.setLooping(true);
      setState(
        () => {},
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 0.0,
            left: 0.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  SaveChangesButton(
                    onPress: () =>
                        Routemaster.of(context).push(HomeScreen.routeName),
                    title: "Sign up with Google",
                    verticalHeight: 25,
                    fontColor: kBlackColor,
                    BackgroundColor: kWhiteColor,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SaveChangesButton(
                    onPress: () =>
                        Routemaster.of(context).push(SignUpScreen.routeName),
                    title: "Sign Up",
                    verticalHeight: 25,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () =>
                          Routemaster.of(context).push(SignInScreen.routeName),
                      child: const Text(
                        "Already have an Account? Login Here",
                        style: TextStyle(color: kWhiteColor),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
