import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

typedef PaginationBuilder<T> = Future<List<T>> Function(int currentListSize);

class PaginationGrid<T> extends StatefulWidget {
  const PaginationGrid({
    Key? key,
    required this.itemBuilder,
    required this.onError,
    required this.onEmpty,
    required this.pageFetch,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.singlePage = false,
    this.padding = const EdgeInsets.all(0),
    this.initialData = const [],
    this.physics,
    this.separatorWidget = const SizedBox(height: 0, width: 0),
    this.onPageLoading = const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            backgroundColor: Colors.amber,
          ),
        ),
      ),
    ),
    this.onLoading = const SizedBox(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        backgroundColor: Colors.amber,
      ),
    ),
    this.gridDelegate,
  }) : super(key: key);

  final Axis scrollDirection;
  final bool shrinkWrap;
  final bool singlePage;
  final EdgeInsets padding;
  final List<T> initialData;
  final PaginationBuilder<T> pageFetch;
  final ScrollPhysics? physics;
  final Widget Function(BuildContext, T) itemBuilder;
  final Widget onEmpty;
  final Widget Function(dynamic) onError;
  final Widget separatorWidget;
  final Widget onPageLoading;
  final Widget onLoading;
  final SliverStaggeredGridDelegate? gridDelegate;

  @override
  PaginationGridState<T> createState() => PaginationGridState<T>();
}

Widget Img() {
  return Image(
    image: AssetImage('assets/loadingRainbow.gif'),
    height: 25,
    width: 25,
  );
}

class PaginationGridState<T> extends State<PaginationGrid<T>>
    with AutomaticKeepAliveClientMixin<PaginationGrid<T>> {
  final List<T?> _itemList = <T?>[];
  dynamic _error;
  final StreamController<PageState?> _streamController =
      StreamController<PageState?>();

  int? lastOffset;

  @override
  void initState() {
    _itemList.addAll(widget.initialData);
    if (widget.initialData.isNotEmpty) _itemList.add(null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<PageState?>(
      stream: _streamController.stream,
      initialData:
          (_itemList.isEmpty) ? PageState.firstLoad : PageState.pageLoad,
      builder: (BuildContext context, AsyncSnapshot<PageState?> snapshot) {
        if (!snapshot.hasData) {
          return widget.onLoading;
        }
        if (snapshot.data == PageState.firstLoad) {
          fetchPageData();
          return widget.onLoading;
        }
        if (snapshot.data == PageState.firstEmpty) {
          return widget.onEmpty;
        }
        if (snapshot.data == PageState.firstError) {
          return widget.onError(_error);
        }
        return StaggeredGridView.builder(
          shrinkWrap: widget.shrinkWrap,
          physics: widget.physics,
          gridDelegate: widget.gridDelegate ??
              SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                staggeredTileCount: _itemList.length,
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              ),
          scrollDirection: widget.scrollDirection,
          itemCount: _itemList.length,
          itemBuilder: (context, index) {
            if (_itemList[index] == null &&
                snapshot.data == PageState.pageLoad) {
              fetchPageData(offset: index);
              return widget.onPageLoading;
            }
            if (_itemList[index] == null &&
                snapshot.data == PageState.pageError) {
              return widget.onError(_error);
            }
            return widget.itemBuilder(
              context,
              _itemList[index]!,
            );
          },
        );
      },
    );
  }

  void fetchPageData({int offset = 0}) {
    if (lastOffset == offset) {
      return;
    }
    widget.pageFetch(offset - widget.initialData.length).then(
      (List<T> list) {
        if (_itemList.contains(null)) {
          _itemList.remove(null);
        }
        // list = list ?? [];
        if (list.isEmpty) {
          if (offset == 0) {
            _streamController.add(PageState.firstEmpty);
          } else {
            _streamController.add(PageState.pageEmpty);
          }
          lastOffset = offset;
          return;
        }

        _itemList.addAll(list);
        if (widget.singlePage) {
          _streamController.add(PageState.pageEmpty);
        } else {
          _itemList.add(null);
          _streamController.add(PageState.pageLoad);
        }
      },
      onError: (dynamic _error) {
        this._error = _error;
        if (offset == 0) {
          _streamController.add(PageState.firstError);
        } else {
          if (!_itemList.contains(null)) {
            _itemList.add(null);
          }
          _streamController.add(PageState.pageError);
        }
      },
    );
  }

  void reloadData() {
    _itemList.clear();
    lastOffset = null;
    _streamController.add(null);
    setState(() {});
    fetchPageData();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

enum PageState {
  pageLoad,
  pageError,
  pageEmpty,
  firstEmpty,
  firstLoad,
  firstError,
}
