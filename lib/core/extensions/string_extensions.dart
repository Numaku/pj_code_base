import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart' as p;
import 'dart:math' as math;

import '../../config/env_config.dart';
import '../constant/app_images.dart';

extension StringExtension on String? {
  bool isPhoneNumber() {
    String regex = r'^(?:\+84|84|0)[0-9]{9}$';
    final replaceStr = removeSpaceOfPhoneNumber();
    return RegExp(regex).hasMatch(replaceStr);
  }

  String removeSpaceOfPhoneNumber() =>
      this?.trim().replaceAll(RegExp(r'\s'), '').replaceAll('-', '') ?? "";

  String phoneNumberFormat() =>
      this?.replaceAll(RegExp(r'^\+84|^84'), "0") ?? "";

  Widget loadImageAsset(
      {String withExtension = "png",
      BoxFit fit = BoxFit.cover,
      Key? key,
      double? width,
      double? height,
      int? memCacheWidth,
      int? memCacheHeight}) {
    return Image.asset(
      "assets/images/$this.$withExtension",
      key: key,
      fit: fit,
      cacheHeight: memCacheHeight,
      cacheWidth: memCacheWidth,
      height: height,
      width: width,
    );
  }

  Widget loadSvgAsset({Color? color, double? width, double? height}) =>
      SvgPicture.asset(
        'assets/icon/$this.svg',
        color: color,
        width: width,
        height: height,
      );

  String assetPath({String withExtension = "png"}) =>
      "assets/images/$this.$withExtension";

  String svgPath({String withExtension = "svg"}) =>
      "assets/icon/$this.$withExtension";

  bool isEmail() {
    String regex =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    return RegExp(regex).hasMatch(this ?? "");
  }

  String? loadImageFormUrl() {
    return EnvConfig.getBaseFileUrl() + (this ?? "");
  }

  Widget loadImageUrl({
    Widget? placeHolderWidget,
    String? placeHolder,
    Widget? errorWidget,
    String error = AppImages.defaultImage,
    BoxFit fit = BoxFit.cover,
    BoxFit placeHolderFit = BoxFit.cover,
    double? width,
    double? height,
    int? memCacheWidth,
    int? memCacheHeight,
    Map<String, String>? headers,
    bool isAvatar = false
  }) {
    final bool hasMemCacheSize = memCacheWidth != null && memCacheHeight != null;
    final double? aspectRatio = hasMemCacheSize ? memCacheWidth / memCacheHeight : null;

    Widget buildPlaceholder() {
      if (placeHolderWidget != null) return placeHolderWidget;
      if (placeHolder?.isNotEmpty == true) {
        return placeHolder.loadImageAsset(
          fit: placeHolderFit,
          memCacheHeight: memCacheHeight,
          memCacheWidth: memCacheWidth,
        );
      }
      return const CupertinoActivityIndicator();
    }

    Widget buildError() {
      final isAvatarImage = isAvatar && (placeHolder != null || placeHolderWidget != null);
      if (errorWidget != null) return errorWidget;
      if (isAvatarImage) return buildPlaceholder();
      return error.loadImageAsset(
        fit: placeHolderFit,
        memCacheHeight: memCacheHeight,
        memCacheWidth: memCacheWidth,
      );
    }

    if (this == null || this?.isEmpty == true) {
      return SizedBox(
        height: height,
        width: width,
        child: buildError(),
      );
    }

    Widget buildPlaceholderWidget() {
      final placeholderContent = buildPlaceholder();
      return hasMemCacheSize && aspectRatio != null
          ? AspectRatio(aspectRatio: aspectRatio, child: placeholderContent)
          : placeholderContent;
    }

    Widget buildErrorWidget() {
      final errorContent = buildError();
      return hasMemCacheSize && aspectRatio != null
          ? AspectRatio(aspectRatio: aspectRatio, child: errorContent)
          : errorContent;
    }

    return CachedNetworkImage(
      imageUrl: this ?? "",
      httpHeaders: headers,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      width: width,
      height: height,
      fit: fit,
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      placeholder: (context, url) => buildPlaceholderWidget(),
      errorWidget: (context, url, error) => buildErrorWidget(),
    );
  }

  bool checkFilePathCanPreview(String? size) {
    final ext = p.extension(this ?? "").split(".").lastOrNull;
    final mimeType = lookupMimeType(this ?? "");
    if (ext != null) {
      return ext == "txt"||
          // ext == "docx" ||
          // ext == "doc" ||
          // ext == "ppt" ||
          // ext == "pptx" ||
          // ext == "xls" ||
          // ext == "xlsx" ||
          // ext == "txt" ||
          (ext == "pdf" && isSizeLessThanOrEqual5MB(size));
      // mimeType?.startsWith("video/") == true;
    }
    return false;
  }

  bool isSizeLessThanOrEqual5MB(String? sizeStr) {
    if (sizeStr == null || sizeStr.trim().isEmpty) return false;

    final parts = sizeStr.trim().split(RegExp(r'\s+'));
    if (parts.length != 2) return false;

    final value = double.tryParse(parts[0].replaceAll(",", ""));
    if (value == null) return false;

    final unit = parts[1].toUpperCase();
    const units = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    final index = units.indexOf(unit);
    if (index == -1) return false;

    final sizeInBytes = value * math.pow(1024, index).toDouble();
    const fiveMBInBytes = 5 * 1024 * 1024;

    return sizeInBytes <= fiveMBInBytes;
  }

  bool checkFilePathTxt() {
    final ext = p.extension(this ?? "").split(".").lastOrNull;
    if (ext != null && ext == "txt") {
      return true;
    }
    return false;
  }

  bool nonPlayableFiles(){
    final ext = p.extension(this ?? "").split(".").lastOrNull;
    if (ext != null) {
      return ext == "flv" ||
          ext == "avi" ||
          ext == "mkv" ||
          ext == "webm" ||
          ext == "mpeg";
    }
    return false;
  }


  bool isSvgFile() {
    return this?.toLowerCase().endsWith('.svg') ?? false;
  }

  bool isGifFile() {
    return this?.toLowerCase().endsWith('.gif') ?? false;
  }

  String loadFileFromUrl() =>
      "https://docs.google.com/gview?embedded=true&url=$this";

  String convertFileNameIfExists(String localPath) {
    final String fileNameWithoutExtension =
        p.basenameWithoutExtension(this ?? "");
    final List<String> fileNameSplit = (this ?? "").split('.');
    final String extensionOfFileName =
        fileNameSplit.length > 1 ? fileNameSplit.last : "";
    List<String> listFilePath =
        Directory(localPath).listSync().map((e) => e.path).toList();
    List<String> listFileContainsFileName = listFilePath
        .where((element) => element
            .contains(p.basenameWithoutExtension(fileNameWithoutExtension)))
        .toList();
    if (listFileContainsFileName.isEmpty) {
      return this ?? "";
    }
    final newFileName = extensionOfFileName.isNotEmpty
        ? "$fileNameWithoutExtension (${listFileContainsFileName.length}).$extensionOfFileName"
        : "$fileNameWithoutExtension (${listFileContainsFileName.length})";
    return newFileName;
  }


  bool isNullOrEmpty() {
    return this?.isEmpty ?? true;
  }

  String removeExtOfFileName() {
    if (this != null) {
      final ext = p.extension(this ?? "");
      final name = this?.split(ext).firstOrNull?.trim() ?? "";
      return name;
    }
    return "";
  }

  String get extension => this != null ? p.extension(this!) : "";

}
