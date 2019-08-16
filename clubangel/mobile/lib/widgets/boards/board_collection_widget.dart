import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/models/board_collection_widget_model.dart';
import 'package:clubangel/widgets/boards/board_grid_widget.dart';
import 'package:clubangel/widgets/commons/info_message_widget.dart';
import 'package:clubangel/widgets/commons/loading_widget.dart';
import 'package:clubangel/widgets/commons/platform_adaptive_progress_indicator.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'board_top_bar_widget.dart';

class BoardCollectionWidget extends StatelessWidget {
  BoardCollectionWidget(this.postType);
  final PostType postType;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BoardCollectionWidgetModel>(
      distinct: true,
      onInit: (store) =>
          store.dispatch(FetchComingSoonEventsIfNotLoadedAction()),
      converter: (store) =>
          BoardCollectionWidgetModel.fromStore(store, postType),
      builder: (_, viewModel) =>
          BoardCollectionWidgetContent(viewModel, postType),
    );
  }
}

class BoardCollectionWidgetContent extends StatelessWidget {
  BoardCollectionWidgetContent(this.viewModel, this.postType);
  final BoardCollectionWidgetModel viewModel;
  final PostType postType;

  @override
  Widget build(BuildContext context) {
    // final messages = MessageProvider.of(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: BoardTopBarWidget(),
        ),
        body: LoadingWidget(
          status: viewModel.status,
          loadingContent: const PlatformAdaptiveProgressIndicator(),
          errorContent: ErrorView(
            description: LocalizableLoader.of(context).text("error_load"),
            onRetry: viewModel.refreshEvents,
          ),
          successContent: BoardGridWidget(
            listType: listType,
            boards: viewModel.boards,
            onReloadCallback: viewModel.refreshEvents,
          ),
        ));
  }
}
