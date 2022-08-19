import 'package:flutter/material.dart';
import 'package:kedo_food/widgets/search_bar_header.dart';

class ExpandableAppBar extends StatefulWidget {
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? collapsedTitle;
  final Widget? expandedTitle;
  final Widget? expandedTitleBackground;
  final bool displaySearchBar;
  final Widget appBody;
  const ExpandableAppBar(
      {Key? key,
      required this.appBody,
      required this.displaySearchBar,
      this.actions,
      this.leading,
      this.collapsedTitle,
      this.expandedTitle,
      this.expandedTitleBackground})
      : super(key: key);

  @override
  State<ExpandableAppBar> createState() => _ExpandableAppBarState();
}

class _ExpandableAppBarState extends State<ExpandableAppBar> {
  late double fixedAppBarHeight;
  Color iconColor = Colors.white;
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(listener);
    super.initState();
  }

  void listener() {
    var offset = scrollController.offset;
    //print("offset data $offset");
    if (offset > 140 && iconColor == Colors.white) {
      //print("offset data $offset");
      setState(() {
        iconColor = Colors.black;
      });
    } else if (offset < 140 && iconColor == Colors.black) {
      setState(() {
        iconColor = Colors.white;
      });
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(listener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fixedAppBarHeight = MediaQuery.of(context).padding.top + kToolbarHeight;
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            iconTheme: IconThemeData(
              color: iconColor,
            ),
            actions: widget.actions,
            leading: Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 30.0),
                child: widget.leading),
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                //print('constraints=' + constraints.toString());
                var top = constraints.biggest.height;
                //print(top);
                return FlexibleSpaceBar(
                  title: top == fixedAppBarHeight
                      ? widget.collapsedTitle
                      : widget.expandedTitle,
                  titlePadding: widget.expandedTitle != null
                      ? (top == fixedAppBarHeight
                          ? null
                          : EdgeInsets.only(
                              left: 180 - (top / 1.8), bottom: 20))
                      : null,
                  //collapseMode: CollapseMode.pin,
                  centerTitle: top == fixedAppBarHeight,
                  background: widget.expandedTitleBackground,
                );
              },
            ),
          ),
          if (widget.displaySearchBar) const SearchBarHeader(),
          widget.appBody
        ],
      ),
    );
  }
}
