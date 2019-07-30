import 'package:clubangel/loaders/localizable_loader.dart';
import 'package:clubangel/models/real_time_collection_widget_model.dart';
import 'package:clubangel/widgets/commons/info_message_widget.dart';
import 'package:clubangel/widgets/commons/loading_widget.dart';
import 'package:clubangel/widgets/commons/platform_adaptive_progress_indicator.dart';
import 'package:clubangel/widgets/real_times/real_time_grid_widget.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class RealTimeCollectionWidget extends StatelessWidget {
  RealTimeCollectionWidget(this.listType);
  final EventListType listType;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RealTimeCollectionWidgetModel>(
      distinct: true,
      onInit: (store) =>
          store.dispatch(FetchComingSoonEventsIfNotLoadedAction()),
      converter: (store) =>
          RealTimeCollectionWidgetModel.fromStore(store, listType),
      builder: (_, viewModel) =>
          RealTimeCollectionWidgetContent(viewModel, listType),
    );
  }
}

class RealTimeCollectionWidgetContent extends StatelessWidget {
  RealTimeCollectionWidgetContent(this.viewModel, this.listType);
  final RealTimeCollectionWidgetModel viewModel;
  final EventListType listType;

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
      successContent: RealTimeGridWidget(
        listType: listType,
        events: viewModel.events,
        onReloadCallback: viewModel.refreshEvents,
      ),
    );
  }
}
