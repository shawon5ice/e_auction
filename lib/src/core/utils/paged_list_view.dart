import 'package:flutter/material.dart';
import 'colorResources.dart';
import 'common_method.dart';

typedef PagedWidgetBuilder<T> = Widget Function(BuildContext context, T item, int index);

class PagedListView<T> extends StatelessWidget {

  final PagedWidgetBuilder<T> itemBuilder;
  final List<T> items;
  final bool isLoading;
  final _scrollController = ScrollController();
  final Function(List<T>, int) onNewLoad;
  final int totalPage;
  final int totalSize;
  final int itemPerPage;

  PagedListView({
    required this.items,
    required this.itemBuilder,
    required this.isLoading,
    required this.onNewLoad,
    required this.totalPage,
    required this.totalSize,
    required this.itemPerPage,
  });

  @override
  Widget build(BuildContext context) {

    _scrollController.addListener(() {

      // if loader is visible then previous execution is not completed
      // or duplicate execution is about to happen
      // so we stop it by return
      // also if total page is 1 or total size is less equal item per page
      // so we don't need to call newLoad any more
      if (isLoading || totalPage == 1 || totalSize <= itemPerPage) return;

      if (_scrollController.position.atEdge && _scrollController.position.pixels > 0) {
        // this condition will be execute when you are in bottom of the list
        // then callback function will be trigger which we pass through parameter
        // will be execute for loading more data
        int newLength = totalSize % itemPerPage == 0 ? (totalSize - 1) - items.length : totalSize - items.length;
        if (newLength > itemPerPage) {
          int nextPage = totalPage - (newLength/itemPerPage).floor();
          this.onNewLoad(items, nextPage);
        } else {
          if (newLength <= 0) return;
          this.onNewLoad(items, totalPage);
        }
      }
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (items.isNotEmpty) Flexible(
          flex: 1,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: items == null ? 0 : items.length,
            itemBuilder: (context, index) {
              return itemBuilder(context, items[index], index);
            },
          ),
        ) else Flexible(
          child: CommonMethods.notFound(),
        ),
        isLoading ? Container(
          height: 50,
          color: ColorResources.deepBlue,
          child: Center(
            child: RichText(
              text: const TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: RefreshProgressIndicator(),
                  ),
                  WidgetSpan(
                    child: SizedBox(
                      width: 15,
                    ),
                  ),
                  TextSpan(
                      text: "Fetching new data ....",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      )
                  ),
                ],
              ),
            ),
          ),
        ) : const SizedBox(),
      ],
    );
  }
}
