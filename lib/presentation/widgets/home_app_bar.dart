import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({
    Key? key,
    required this.title,
    this.leading,
    required this.bottom,
    this.otherActions,
    required this.searchQueryCallBack,
    required this.hintTextInSearchBar,
  }) : super(key: key);

  final Widget title;
  final Widget? leading;
  final PreferredSizeWidget bottom;
  final List<Widget>? otherActions;
  final Function(String) searchQueryCallBack;
  final String hintTextInSearchBar;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar>
    with SingleTickerProviderStateMixin {
  double? _rippleStartX;
  double? _rippleStartY;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isInSearchMode = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addStatusListener(_animationStatusListener);
  }

  void _animationStatusListener(AnimationStatus animationStatus) {
    if (animationStatus == AnimationStatus.completed) {
      setState(() {
        _isInSearchMode = true;
      });
    }
  }

  void _onSearchTapUp(TapUpDetails details) {
    setState(() {
      _rippleStartX = details.globalPosition.dx;
      _rippleStartY = details.globalPosition.dy;
    });

    _controller.forward();
  }

  void _cancelSearch() {
    setState(() {
      _isInSearchMode = false;
      _onSearchQueryChange('');
    });

    _controller.reverse();
  }

  void filterUsers(String searchTerm) {}

  void _onSearchQueryChange(String query) {
    widget.searchQueryCallBack.call(query);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        AppBar(
          centerTitle: true,
          leading: widget.leading,
          title: widget.title,
          bottom: widget.bottom,
          backgroundColor: Colors.purple[900],
          actions: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTapUp: _onSearchTapUp,
              child: const Icon(
                Icons.search,
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            if (widget.otherActions != null) ...[
              for (Widget action in widget.otherActions!) action
            ]
          ],
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: _SearchBarPainter(
                containerHeight: widget.preferredSize.height,
                center: Offset(_rippleStartX ?? 0, _rippleStartY ?? 0),
                radius: _animation.value * screenWidth,
                appBarColor: Colors.purple[800]!,
                context: context,
              ),
            );
          },
        ),
        if (_isInSearchMode)
          _SearchBar(
            onCancelSearch: _cancelSearch,
            onSearchQueryChanged: _onSearchQueryChange,
            hintText: widget.hintTextInSearchBar,
          ),
      ],
    );
  }
}

class _SearchBarPainter extends CustomPainter {
  final Offset center;
  final double radius;
  final double containerHeight;
  final BuildContext context;

  Color appBarColor;
  double? statusBarHeight;
  double? screenWidth;

  _SearchBarPainter({
    required this.context,
    required this.containerHeight,
    required this.center,
    required this.radius,
    required this.appBarColor,
  }) {
    statusBarHeight = MediaQuery.of(context).padding.top;
    screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final circlePainter = Paint();

    circlePainter.color = appBarColor;
    canvas.clipRect(
      Rect.fromLTWH(
        0,
        0,
        screenWidth!,
        containerHeight + statusBarHeight!,
      ),
    );
    canvas.drawCircle(center, radius, circlePainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class _SearchBar extends StatefulWidget implements PreferredSizeWidget {
  const _SearchBar({
    required this.hintText,
    required this.onCancelSearch,
    required this.onSearchQueryChanged,
  });

  final String hintText;
  final VoidCallback onCancelSearch;
  final Function(String) onSearchQueryChanged;

  @override
  Size get preferredSize => const Size.fromHeight(0);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar>
    with SingleTickerProviderStateMixin {
  final _searchFieldController = TextEditingController();

  void _clearSearchQuery() {
    setState(() => _searchFieldController.clear());
    widget.onSearchQueryChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    widget.onCancelSearch();
                  },
                ),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    controller: _searchFieldController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '${widget.hintText}...',
                    ),
                    onChanged: (value) => setState(
                      () => widget.onSearchQueryChanged(value),
                    ),
                  ),
                ),
                if (_searchFieldController.text.isNotEmpty) ...[
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                    ),
                    onPressed: _clearSearchQuery,
                  ),
                ]
              ],
            ),
          ),
          Container(
            color: Colors.purple[800],
            height: 2,
          )
        ],
      ),
    );
  }
}
