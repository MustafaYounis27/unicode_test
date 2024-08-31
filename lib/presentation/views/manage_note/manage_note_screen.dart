import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unicode_test/core/theme/colors.dart';
import 'package:unicode_test/core/theme/styles.dart';
import 'package:unicode_test/data/models/note_model.dart';
import 'package:unicode_test/presentation/shared_widgets/alerts.dart';
import 'package:unicode_test/presentation/shared_widgets/primary/unified_body.dart';
import 'package:unicode_test/presentation/shared_widgets/spacing.dart';
import 'package:unicode_test/presentation/shared_widgets/toasts.dart';
import 'package:unicode_test/presentation/views/manage_note/manage_note_cubit.dart';
import 'package:unicode_test/utils/extension/ui_ext.dart';

class ManageNoteScreen extends StatefulWidget {
  final NoteModel? note;

  const ManageNoteScreen({super.key, this.note});

  @override
  State<ManageNoteScreen> createState() => _ManageNoteScreenState();
}

class _ManageNoteScreenState extends State<ManageNoteScreen> {
  final ManageNoteCubit _cubit = ManageNoteCubit();

  @override
  void initState() {
    _cubit.initData(widget.note);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<ManageNoteCubit, ManageNoteStates>(
        listener: (context, state) {
          if (state is NoteSavedSuccessfully) {
            String message = state.editMode ? 'Note updated successfully' : 'Note added successfully';
            Toasts.showSuccessToast(message: message);
            Navigator.pop(context);
            return;
          }

          if (state is Error) {
            Toasts.showErrorToast(message: state.error);
            return;
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: UnifiedBody(
              actions: [
                IconButton(
                  onPressed: _cubit.handleSaveNote,
                  icon: const Icon(Icons.save, color: ColorsPalletes.secondry500),
                ),
              ],
              title: _cubit.isEditMode ? 'Edit Note' : 'Add Note',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: REdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Topics :', style: TextStyles.bold_12),
                        horizontalSpace(10.r),
                        Expanded(
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 6.r,
                            children: [
                              ..._cubit.topics
                                  .map(
                                    (e) => InkWell(
                                      onTap: () async {
                                        var result = await Alerts(context)
                                            .yesOrNoDialog(title: 'Topic $e', body: 'Are you sure you need to remove this topic ?');

                                        if (result != true) return;

                                        _cubit.removeTopic(e);
                                      },
                                      child: Container(
                                        padding: REdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: 20.r.br,
                                          color: ColorsPalletes.secondry50,
                                          border: Border.all(width: 0.5, color: ColorsPalletes.secondry100),
                                        ),
                                        child: Text(e, style: TextStyles.regular_12),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              InkWell(
                                onTap: () async {
                                  var topic = await Alerts(context).addTopic();

                                  if (topic == null) return;

                                  _cubit.addNewTopic(topic);
                                },
                                child: Container(
                                  padding: REdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: 20.r.br,
                                    color: ColorsPalletes.secondry50,
                                    border: Border.all(width: 0.5, color: ColorsPalletes.secondry100),
                                  ),
                                  child: Icon(Icons.add, size: 18.r),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: _cubit.titleController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    style: TextStyles.bold_18,
                    decoration: InputDecoration(
                      contentPadding: REdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      hintText: 'Title',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintStyle: TextStyles.regular_14.copyWith(color: ColorsPalletes.grey500),
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                  ),
                  const Divider(thickness: 0.5, color: ColorsPalletes.grey300, height: 1),
                  Expanded(
                    child: TextFormField(
                      controller: _cubit.bodyController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: TextStyles.regular_16,
                      decoration: InputDecoration(
                        contentPadding: REdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        hintText: 'Body',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintStyle: TextStyles.regular_14.copyWith(color: ColorsPalletes.grey500),
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
