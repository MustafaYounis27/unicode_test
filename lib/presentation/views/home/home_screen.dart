import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unicode_test/core/constants/app_session.dart';
import 'package:unicode_test/core/constants/image_constants.dart';
import 'package:unicode_test/core/injector.dart';
import 'package:unicode_test/core/router.dart';
import 'package:unicode_test/core/routes_args.dart';
import 'package:unicode_test/core/theme/colors.dart';
import 'package:unicode_test/core/theme/styles.dart';
import 'package:unicode_test/generated/locale_keys.g.dart';
import 'package:unicode_test/main.dart';
import 'package:unicode_test/presentation/shared_widgets/image_view.dart';
import 'package:unicode_test/presentation/shared_widgets/loading_indicator.dart';
import 'package:unicode_test/presentation/shared_widgets/primary/unified_body.dart';
import 'package:unicode_test/presentation/shared_widgets/primary/unified_text_form_field.dart';
import 'package:unicode_test/presentation/shared_widgets/spacing.dart';
import 'package:unicode_test/presentation/shared_widgets/toasts.dart';
import 'package:unicode_test/presentation/views/home/home_cubit.dart';
import 'package:unicode_test/utils/extension/ui_ext.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final HomeCubit _cubit = HomeCubit(injector());
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _cubit.initData();
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorsPalletes.secondry500,
          onPressed: _cubit.navigateToAddNote,
          child: const Icon(Icons.add),
        ),
        body: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) async {
            if (state is RouteToManageNote) {
              await Navigator.pushNamed(context, Routes.manageNote, arguments: ManageNoteScreenArgs(note: state.note));

              _cubit.getUserNotes();
              return;
            }

            if (state is NotesSyncedSuccessfully) {
              Toasts.showSuccessToast(message: LocaleKeys.allNoteSynced.tr());
              return;
            }

            if (state is NotAllyncedSuccessfully) {
              Toasts.showSimpleToast(
                message: LocaleKeys.wrongTryAgain.tr(),
              );

              return;
            }
          },
          builder: (context, state) {
            if (state is Loading) return const LoadingIndicator();
            return UnifiedBody(
              title: '${LocaleKeys.welcomeBack.tr()} ${AppSession.loggedUser?.name ?? ''}',
              actions: [
                IconButton(
                  onPressed: _cubit.isSearching ? _cubit.disableSearchMode : _cubit.enableSearchMode,
                  icon:
                      Icon(_cubit.isSearching ? Icons.filter_alt_off_rounded : Icons.filter_alt_rounded, color: ColorsPalletes.secondry500),
                ),
                IconButton(
                  onPressed: () async {
                    if (context.locale.isEnglish) {
                      await context.setLocale(const Locale('ar', 'AR'));
                    } else {
                      await context.setLocale(const Locale('en', 'EN'));
                    }

                    reRenderWholeAppNotifier.value = DateTime.now();
                  },
                  icon: const Icon(Icons.language_rounded, color: ColorsPalletes.secondry500),
                ),
                IconButton(
                  onPressed: _cubit.syncAllNotes,
                  icon: const Icon(Icons.cloud_upload_rounded, color: ColorsPalletes.secondry500),
                ),
              ],
              child: Column(
                children: [
                  if (_cubit.isSearching) ...[
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 300),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: REdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: UnifiedTextFormField(
                              controller: _cubit.searchController,
                              suffixIcon: Icons.close,
                              suffixIconColor: ColorsPalletes.secondry500,
                              suffixPressed: _cubit.clearSearch,
                              onChange: (p0) {
                                _cubit.search();
                              },
                            ),
                          ),
                          Padding(
                            padding: REdgeInsets.symmetric(horizontal: 12),
                            child: SizedBox(
                              height: 0.05.sh,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var topic = _cubit.allTopics[index];
                                  bool isSelected = _cubit.filteredTopics.contains(topic);

                                  return InkWell(
                                    onTap: () => isSelected ? _cubit.removeFilteredTopic(topic) : _cubit.addFilteredTopic(topic),
                                    child: Padding(
                                      padding: REdgeInsets.symmetric(horizontal: 4),
                                      child: Container(
                                        padding: REdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: 20.r.br,
                                          color: isSelected ? ColorsPalletes.secondry50 : Colors.white,
                                          border: Border.all(width: 0.5, color: ColorsPalletes.secondry100),
                                        ),
                                        child: Center(child: Text(topic, style: TextStyles.regular_12)),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: _cubit.allTopics.length,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (_cubit.notes.isEmpty) ...[
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration: const Duration(seconds: 1),
                              builder: (context, value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: child,
                                );
                              },
                              child: ImageView(
                                height: 100.r,
                                string: ImageConstants.appIcon,
                              ),
                            ),
                            SizedBox(height: 0.02.sh),
                            FadeTransition(
                              opacity: _animation,
                              child: Text(LocaleKeys.pressToAdd.tr(), style: TextStyles.bold_18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    Expanded(
                      child: ListView.builder(
                        padding: REdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          var note = _cubit.notes[index];

                          return Padding(
                            padding: REdgeInsets.symmetric(vertical: 5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: REdgeInsets.all(16),
                                backgroundColor: ColorsPalletes.secondry50,
                                elevation: 2,
                                side: const BorderSide(width: 2, color: ColorsPalletes.secondry100),
                              ),
                              onPressed: () => _cubit.navigateToEditNote(note),
                              child: SizedBox(
                                width: double.maxFinite,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(note.title, style: TextStyles.bold_18),
                                    verticalSpace(6.r),
                                    Text(
                                      note.body,
                                      style: TextStyles.regular_14.copyWith(color: Colors.black38),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    verticalSpace(6.r),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('${LocaleKeys.topics.tr()} :', style: TextStyles.bold_12),
                                        horizontalSpace(10.r),
                                        Expanded(
                                          child: Wrap(
                                            alignment: WrapAlignment.start,
                                            spacing: 6.r,
                                            children: note.topics
                                                .map(
                                                  (e) => Container(
                                                    padding: REdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                                    decoration: BoxDecoration(
                                                      borderRadius: 20.r.br,
                                                      color: ColorsPalletes.secondry100,
                                                      border: Border.all(width: 0.5, color: ColorsPalletes.secondry100),
                                                    ),
                                                    child: Text(e, style: TextStyles.regular_12),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: _cubit.notes.length,
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
