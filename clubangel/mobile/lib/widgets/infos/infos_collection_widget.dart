import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/models/info_collection_widget_model.dart';
import 'package:clubangel/widgets/commons/info_message_widget.dart';
import 'package:clubangel/widgets/commons/loading_widget.dart';
import 'package:clubangel/widgets/commons/platform_adaptive_progress_indicator.dart';
import 'package:clubangel/widgets/infos/info_grid_widget.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class InfosCollectionWidget extends StatelessWidget {
  InfosCollectionWidget(this.listType);
  final BoardListType listType;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InfoCollectionWidgetModel>(
      distinct: true,
      onInit: (store) =>
          store.dispatch(FetchComingSoonEventsIfNotLoadedAction()),
      converter: (store) =>
          InfoCollectionWidgetModel.fromStore(store, listType),
      builder: (_, viewModel) =>
          InfosCollectionWidgetContent(viewModel, listType),
    );
  }
}

class InfosCollectionWidgetContent extends StatelessWidget {
  InfosCollectionWidgetContent(this.viewModel, this.listType);
  final InfoCollectionWidgetModel viewModel;
  final BoardListType listType;

  @override
  Widget build(BuildContext context) {
    // final messages = MessageProvider.of(context);
    return LoadingWidget(
      status: viewModel.status,
      loadingContent: const PlatformAdaptiveProgressIndicator(),
      errorContent: ErrorView(
        description: LocalizableLoader.of(context).text("error_load"),
        onRetry: viewModel.refreshEvents,
      ),
      successContent: InfoGridWidget(
        listType: listType,
        boards: viewModel.boards,
        onReloadCallback: viewModel.refreshEvents,
      ),
    );
  }
}
