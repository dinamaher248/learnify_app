import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/Api/dio_consumer.dart';
import '../../../../../core/Api/endpoints.dart';
import '../../data/repo/parent_repo.dart';
import '../../presentation/view_models/cubit/parent_children_cubit.dart';
import '../../presentation/view_models/cubit/parent_children_state.dart';

class ParentChildrenView extends StatelessWidget {
  const ParentChildrenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => ParentChildrenCubit(
        ParentRepo(
          api: DioConsumer(dio: Dio(), baseUrl: Endpoints.baseAuthUrl),
        ),
      )..loadChildren(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Children')),
        body: BlocBuilder<ParentChildrenCubit, ParentChildrenState>(
          builder: (context, state) {
            if (state is ParentChildrenLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ParentChildrenError) {
              return Center(child: Text(state.message));
            }
            if (state is ParentChildrenLoaded) {
              final children = state.children;
              if (children.isEmpty)
                return const Center(child: Text('No children linked'));
              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: children.length,
                separatorBuilder: (_, _) => const Divider(),
                itemBuilder: (context, index) {
                  final c = children[index];
                  final id = c.id;
                  final first = c.firstName;
                  final last = c.lastName;
                  return ListTile(
                    title: Text('$first $last'),
                    subtitle: Text(id),
                    onTap: () {
                      // navigate to child's detail with extras
                      GoRouter.of(context).go(
                        '/parent-child-detail',
                        extra: {'studentId': id, 'studentName': '$first $last'},
                      );
                    },
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
