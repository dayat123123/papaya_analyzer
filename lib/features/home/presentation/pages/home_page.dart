import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:papayas_analyzer/core/tensorflow/tensorflow.dart';
import 'package:papayas_analyzer/core/theme/theme.dart';
import 'package:papayas_analyzer/shared/extensions/context_extension.dart';
import 'package:papayas_analyzer/shared/features/greeting_cubit/greeting_cubit.dart';
import 'package:papayas_analyzer/shared/misc/file_paths.dart';
import 'package:papayas_analyzer/shared/widgets/card/card_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GreetingCubit _greetingCubit;
  late ScrollController _scrollController;
  final List<ContentModel> _listContent = [
    ContentModel(imagePath: FilePaths.h1Jpeg, classes: ClassesResult.apple),
    ContentModel(imagePath: FilePaths.h2Jpeg, classes: ClassesResult.banana),
    ContentModel(imagePath: FilePaths.h3Jpeg, classes: ClassesResult.apple),
  ];

  @override
  void initState() {
    _greetingCubit = GreetingCubit();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _greetingCubit.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _greetingCubit,
      child: BlocBuilder<GreetingCubit, String>(
        bloc: _greetingCubit,
        builder: (context, state) {
          return PopScope(
            canPop: false,
            child: Scaffold(
              appBar: AppBar(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Hello", style: context.textStyle.title),
                    Text(state, style: context.textStyle.subtitle),
                  ],
                ),
              ),
              body: Scrollbar(
                controller: _scrollController,
                child: ListView.separated(
                  padding: AppPadding.all,
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemCount: _listContent.length,
                  itemBuilder: (context, index) {
                    return _buildCardContent(context, _listContent[index]);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCardContent(BuildContext context, ContentModel data) {
    return CardContainer(
      width: context.fullWidth,
      padding: AppPadding.around,
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.classes.name.toUpperCase(), style: context.textStyle.title),
          SizedBox(height: 10),
          Container(
            height: 250,
            width: context.fullWidth,
            decoration: BoxDecoration(
              borderRadius: AppBorderRadius.medium,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(data.imagePath),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContentModel {
  final String imagePath;
  final ClassesResult classes;

  const ContentModel({required this.imagePath, required this.classes});
}
