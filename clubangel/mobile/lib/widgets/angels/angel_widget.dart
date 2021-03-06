import 'package:clubangel/models/angel_widget_model.dart';
import 'package:clubangel/singletons/keyboard_singleton.dart';
import 'package:clubangel/themes/main_theme.dart';
import 'package:clubangel/widgets/angel_regists/angel_regist_widget.dart';
import 'package:clubangel/widgets/angels/angel_date_widget.dart';
import 'package:clubangel/widgets/angels/angel_list_widget.dart';
import 'package:clubangel/widgets/commons/info_message_widget.dart';
import 'package:clubangel/widgets/commons/loading_widget.dart';
import 'package:clubangel/widgets/commons/platform_adaptive_progress_indicator.dart';
import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AngelWidget extends StatelessWidget {
  AngelWidget(this.listType);
  final BoardListType listType;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AngelWidgetModel>(
      distinct: true,
      onInit: (store) => store.dispatch(FetchAngelsIfNotLoadedAction()),
      converter: (store) => AngelWidgetModel.fromStore(store),
      builder: (_, viewModel) => AngelWidgetContent(viewModel),
    );
  }
}

class AngelWidgetContent extends StatelessWidget {
  AngelWidgetContent(this.viewModel);
  final AngelWidgetModel viewModel;

  void _registAngel(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AngelRegistWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          gradient: MainTheme.primaryLinearGradient,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AngelDateWidget(viewModel),
            Expanded(
              child: LoadingWidget(
                status: viewModel.status,
                loadingContent: const PlatformAdaptiveProgressIndicator(),
                errorContent: ErrorView(onRetry: viewModel.refreshAngeltimes),
                successContent:
                    AngelListWidget(viewModel.status, viewModel.shows),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: KeyboardSingleton().isKeyboardVisible()
          ? Container()
          : Container(
              child: FloatingActionButton(
                onPressed: () => _registAngel(context),
                tooltip: 'Add',
                backgroundColor: MainTheme.bgndColor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              padding: EdgeInsets.only(bottom: 70),
            ),
    );
  }
}
