import 'package:clubangel/themes/main_theme.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MainTopBarWidget extends StatefulWidget {
  @override
  _MainTopBarWidgetState createState() => _MainTopBarWidgetState();
}

class _MainTopBarWidgetState extends State<MainTopBarWidget>
    with SingleTickerProviderStateMixin {
  TextEditingController _searchQuery;
  LocalHistoryEntry _searchEntry;

  bool _isSearching = false;
  bool _theatersOpen = false;

  @override
  void initState() {
    super.initState();

    _searchEntry = LocalHistoryEntry(onRemove: _stopSearching);
    _searchQuery = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _toggleTheaters() async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      _setTheatersOpenFlag(false);
    } else {
      _setTheatersOpenFlag(true);

      // await Navigator.push(context, TheaterSelectorPopup());
      // _setTheatersOpenFlag(false);
    }
  }

  void _setTheatersOpenFlag(bool open) {
    setState(() {
      _theatersOpen = open;
    });
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return [
        IconButton(
          color: Colors.white70,
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQuery == null || _searchQuery.text.isEmpty) {
              // Stop searching.
              Navigator.pop(context);
              return;
            }

            _clearSearchQuery();
          },
        ),
      ];
    }

    return [
      IconButton(
        color: Colors.white70,
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search movies & showtimes...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: _updateSearchQuery,
    );
  }

  void _updateSearchQuery(String newQuery) {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(SearchQueryChangedAction(newQuery));
  }

  void _startSearch() {
    ModalRoute.of(context).addLocalHistoryEntry(_searchEntry);

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQuery.clear();
      _updateSearchQuery(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MainTheme.appBarColor,
      automaticallyImplyLeading: false,
      centerTitle: false,
      leading: _isSearching ? const BackButton() : null,
      title: _isSearching ? _buildSearchField() : _Title(_toggleTheaters),
      actions: _buildActions(),
    );
  }
}

class _Title extends StatelessWidget {
  _Title(this.toggleTheaters);
  final VoidCallback toggleTheaters;

  @override
  Widget build(BuildContext context) {
    final subtitle = StoreConnector<AppState, Theater>(
      converter: (store) => store.state.theaterState.currentTheater,
      builder: (BuildContext context, Theater currentTheater) {
        return Text(
          currentTheater?.name ?? '',
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.white70,
          ),
        );
      },
    );

    final title = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Test'),
        subtitle,
      ],
    );

    return GestureDetector(
      onTap: toggleTheaters,
      child: Row(
        children: [
          // Image.asset('assets/images/logo.png', width: 28.0, height: 28.0),
          // const SizedBox(width: 8.0),
          // title,
        ],
      ),
    );
  }
}
