import 'dart:async';
// import 'package:flutter/material.dart';
/*

class DialogButton {
  String text;
  Function onClick;

  DialogButton(this.text, {this.onClick});
}

class DialogUtils extends StatefulWidget {
  final Widget child;

  DialogUtils({Key key, this.child}) : super(key: key);

  _DialogUtilsState createState() => _DialogUtilsState();
}

class _DialogUtilsState extends State<DialogUtils> {
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog, _hideDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: widget.child);
  }

  void _showDialog(AlertRequest request) {
    if (request.isLoading) {
      showLoaderDialog(context);
    } else if (request.isItemList) {
      showItemListDialog(request);
    } else {
      showAppDialog(context, request);
    }
  }

  void showItemListDialog(AlertRequest request) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24)
            ),
            content: Container(
              height: SizeConfig.getVerticalSize(320),
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.getHorizontalSize(8), vertical: SizeConfig.getVerticalSize(8)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
              ),
              child: Material(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppLogoWithAnimation(size: SizeConfig.getVerticalSize(60)),
                    VSpace(16),
                    Text(request.title, style: AppTheme.textTheme.headline2),
                    VSpace(16),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          var itemText = request.items[index];
                          return GestureDetector(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: SizeConfig.getVerticalSize(16), horizontal: SizeConfig.getHorizontalSize(16)),
                              child: Text(itemText, style: AppTheme.textTheme.bodyText2.copyWith(color: Colors.black)),
                            ),
                            onTap: () {
                              if (request.onItemSelected != null) {
                                request.onItemSelected(itemText);
                              }
                              _dialogService.dialogComplete(AlertResponse(confirmed: true));
                            },
                          );
                        },
                        itemCount: request.items.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _hideDialog(AlertResponse response) {
    Navigator.of(context).pop();
  }

  showLoaderDialog(BuildContext context, {bool cancelable = false}) {
    showDialog(
      context: context,
      barrierDismissible: cancelable,
      builder: (context) {
        return Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.getHorizontalSize(56), vertical: SizeConfig.getVerticalSize(24)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Material(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppLogoWithAnimation(size: SizeConfig.getVerticalSize(60)),
                  VSpace(16),
                  Text("Loading..!", style: AppTheme.textTheme.headline2),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showAppDialog(
    BuildContext context,
    AlertRequest request,
  ) {
    bool isOnlyButton = false;
    DialogButton dialogButton;
    if (request.positiveButton == null && request.negativeButton == null) {
      isOnlyButton = true;
      dialogButton = DialogButton("OK", onClick: () {});
    } else if (request.positiveButton != null && request.negativeButton != null) {
      isOnlyButton = false;
    } else {
      isOnlyButton = true;
      if (request.positiveButton != null) {
        dialogButton = request.positiveButton;
      } else {
        dialogButton = request.negativeButton;
      }
    }

    showDialog(
      context: context,
      barrierDismissible: request.cancelable,
      builder: (context) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.getHorizontalSize(32), vertical: SizeConfig.getVerticalSize(16)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.getHorizontalSize(32), vertical: SizeConfig.getVerticalSize(16)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Material(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(request.title, style: AppTheme.textTheme.headline2),
                    VSpace(16),
                    Text(request.description, style: AppTheme.textTheme.bodyText2),
                    VSpace(16),
                    isOnlyButton
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _dialogService.dialogComplete(AlertResponse());
                                  if (dialogButton.onClick != null) {
                                    dialogButton.onClick();
                                  }
                                },
                                child: Text(dialogButton.text),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    _dialogService.dialogComplete(AlertResponse());
                                    if (request.negativeButton.onClick != null) {
                                      request.negativeButton.onClick();
                                    }
                                  },
                                  child: Text(request.negativeButton.text),
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    _dialogService.dialogComplete(AlertResponse());
                                    if (request.positiveButton.onClick != null) {
                                      request.positiveButton.onClick();
                                    }
                                  },
                                  child: Text(request.positiveButton.text),
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DialogService {
  Function(AlertRequest) _showDialogListener;
  Function(AlertResponse) _hideDialogListener;
  Completer<AlertResponse> _dialogCompleter;

  /// Registers a callback function. Typically to show the dialog
  void registerDialogListener(Function(AlertRequest) showDialogListener, Function(AlertResponse) hideDialogListener) {
    _showDialogListener = showDialogListener;
    _hideDialogListener = hideDialogListener;
  }

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future<AlertResponse> showDialog(AlertRequest request) {
    _dialogCompleter = Completer<AlertResponse>();
    _showDialogListener(request);
    return _dialogCompleter.future;
  }

  Future<AlertResponse> showListItemPickerDialog({String title, List<String> list, Function(String) onItemSelect}) {
    _dialogCompleter = Completer<AlertResponse>();
    _showDialogListener(AlertRequest.itemList(title: title, itemList: list, onItemSelected: onItemSelect));
    return _dialogCompleter.future;
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void dialogComplete(AlertResponse response) {
    try {
      _hideDialogListener(response);
      _dialogCompleter.complete(response);
      _dialogCompleter = null;
    } catch (e) {
      print(e.toString());
    }
  }
}

class AlertRequest {
  final String title;
  final String description;
  bool isLoading;
  bool cancelable = true;
  List<String> items;
  Function(String) onItemSelected;

  // final String buttonTitle;
  final DialogButton positiveButton;
  final DialogButton negativeButton;

  bool isItemList;

  AlertRequest({
    @required this.title,
    @required this.description,
    // @required this.buttonTitle,
    this.cancelable = true,
    this.positiveButton,
    this.negativeButton,
    this.items,
    this.onItemSelected,
    this.isItemList = false,
  }) {
    isLoading = false;
  }

  factory AlertRequest.itemList({String title, List<String> itemList, Function(String) onItemSelected}) {
    var request = AlertRequest(isItemList: true, title: title, description: "", items: itemList, onItemSelected: onItemSelected);
    return request;
  }

  factory AlertRequest.loading() {
    var request = AlertRequest(title: "", description: "");
    request.isLoading = true;
    return request;
  }
}

class AlertResponse {
  final String fieldOne;
  final String fieldTwo;
  final bool confirmed;

  AlertResponse({
    this.fieldOne,
    this.fieldTwo,
    this.confirmed,
  });
}
*/
