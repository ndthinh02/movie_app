import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/di.dart';
import 'package:movie_app/features/home/data/models/commom_movie_model.dart';
import 'package:movie_app/features/more/presentation/bloc/more_bloc.dart';
import 'package:movie_app/features/more/presentation/widget/more_item_widget.dart';

import '../../../../route/route_name.dart';

class MoreScreen extends StatefulWidget {
  final String type;
  final String name;

  const MoreScreen({
    super.key,
    required this.type,
    required this.name,
  });

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final PagingController<int, DataItems> _pagingController =
      PagingController(firstPageKey: 0);
  final bloc = getIt<MoreBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      context.read<MoreBloc>().add(
            LoadMoreSingleMovieEvent(
              pageKey: pageKey,
              controller: _pagingController,
              type: widget.type,
            ),
          );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pagingController.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name,style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: BlocBuilder<MoreBloc, MoreState>(
        builder: (context, state) {
          if (state == MoreLoadingState()) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ),
            );
          }
          return PagedGridView<int, DataItems>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<DataItems>(
              itemBuilder: (context, item, index) => MoreItemWidget(
                item: item,
                onPress: () => _navigateDetail(item),
              ),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.58,
            ),
          );
        },
      ),
    );
  }

  _navigateDetail(DataItems item) {
    Navigator.of(context).pushNamed(
      RouteName.detail,
      arguments: item.slug,
    );
  }
}
