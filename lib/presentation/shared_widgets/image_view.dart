import 'dart:io';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:should_rebuild/should_rebuild.dart';
import 'package:unicode_test/core/constants/image_constants.dart';
import 'package:unicode_test/utils/utils.dart';

class ImageView extends StatelessWidget {
  late final _Info _info;

  ImageView({
    super.key,
    String? string,
    bool isStringFile = false,
    double? width,
    double? height,
    File? file,
    bool circleCrop = false,
    BoxFit? fit = BoxFit.cover,
    Color? color,
    double radius = 20.0,
    double border = 0,
    Color bordeColor = Colors.transparent,
    String? imageId,
    Color? emptyImageColor,
    bool isNetwork = false,
  }) {
    _info = _Info(string, width, height, file, circleCrop, fit, color, radius, border, bordeColor, emptyImageColor, imageId, isNetwork);
  }

  @override
  Widget build(BuildContext context) {
    return ShouldRebuild<_ImageViewBody>(
        shouldRebuild: (oldWidget, newWidget) => oldWidget.info != newWidget.info,
        child: _ImageViewBody(
          key: key,
          info: _info,
        ));
  }
}

class _ImageViewBody extends StatelessWidget {
  final _Info info;

  const _ImageViewBody({
    super.key,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    final Widget placeHolderWidget = Container(
      color: info.emptyImageColor,
      child: SvgPicture.asset(
        ImageConstants.appIcon,
        width: info.width,
        height: info.height,
      ),
    );

    Widget imageWidget = placeHolderWidget;
    if (info.file != null) {
      imageWidget = Image.file(
        info.file!,
        width: info.width,
        height: info.height,
        fit: info.fit,
      );
    } else if (info.string != null) {
      if (info.isNetwork) {
        imageWidget = CachedNetworkImage(
          imageUrl: info.string!,
          width: info.width,
          height: info.height,
          fadeInDuration: const Duration(milliseconds: 1),
          fit: info.fit,
          errorWidget: (_, __, ___) => Container(
            color: info.emptyImageColor ?? Colors.grey.shade200,
            child: SvgPicture.asset(
              ImageConstants.appIcon,
              width: info.width,
              height: info.height,
            ),
          ),
          placeholder: (context, url) => placeHolderWidget,
        );
      } else if (info.string!.startsWith('assets/')) {
        imageWidget = info.string!.contains('.svg')
            ? SvgPicture.asset(
                info.string!,
                width: info.width,
                height: info.height,
                colorFilter: info.color != null ? Utils.colorFilter(color: info.color!) : null,
              )
            : Image.asset(
                info.string!,
                width: info.width,
                height: info.height,
                fit: info.fit,
                color: info.color,
              );
      } else {
        if (info.isStringFile) {
          imageWidget = Image.file(
            File(info.string!),
            width: info.width,
            height: info.height,
            fit: info.fit,
          );
        } else {
          imageWidget = Image.memory(
            base64Decode(info.string!),
            width: info.width,
            height: info.height,
            fit: info.fit,
          );
        }
      }
    }

    return info.circleCrop
        ? CircularProfileAvatar(
            '',
            radius: info.radius,
            borderWidth: info.border,
            borderColor: info.bordeColor,
            cacheImage: true,
            child: imageWidget,
          )
        : imageWidget;
  }
}

class _Info extends Equatable {
  final String? string;
  final bool isStringFile = false;
  final double? width;
  final double? height;
  final File? file;
  final bool circleCrop;
  final BoxFit? fit;
  final Color? color;
  final double radius;
  final double border;
  final Color bordeColor;
  final Color? emptyImageColor;
  final String? imageId;
  final bool isNetwork;
  const _Info(this.string, this.width, this.height, this.file, this.circleCrop, this.fit, this.color, this.radius, this.border,
      this.bordeColor, this.emptyImageColor, this.imageId, this.isNetwork);

  @override
  List<Object?> get props =>
      [string, isStringFile, width, height, file, circleCrop, fit, color, radius, border, emptyImageColor, imageId, isNetwork];
}
