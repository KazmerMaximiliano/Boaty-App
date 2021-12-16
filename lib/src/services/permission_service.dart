import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService extends ChangeNotifier {
  Future<bool> callPermissions() async {
    await Permission.location.request();
    await Permission.camera.request();
    await Permission.photos.request();

    final check = await checkPermissions();

    return check;
  }

  Future<bool> checkPermissions() async {
    // Location
    final locationIsRestricted = await Permission.location.isRestricted;
    final locationIsDenied = await Permission.location.isDenied;
    final locationIsLimited = await Permission.location.isLimited;
    final locationIsPermanentlyDenied = await Permission.location.isPermanentlyDenied;

    final bool locationPermissions = !(locationIsRestricted || locationIsDenied || locationIsLimited || locationIsPermanentlyDenied);

    // Camera
    final cameraIsRestricted = await Permission.camera.isRestricted;
    final cameraIsDenied = await Permission.camera.isDenied;
    final cameraIsLimited = await Permission.camera.isLimited;
    final cameraIsPermanentlyDenied = await Permission.camera.isPermanentlyDenied;

    final bool cameraPermissions = !(cameraIsRestricted || cameraIsDenied || cameraIsLimited || cameraIsPermanentlyDenied);

    // Photos
    final photosIsRestricted = await Permission.photos.isRestricted;
    final photosIsDenied = await Permission.photos.isDenied;
    final photosIsLimited = await Permission.photos.isLimited;
    final photosIsPermanentlyDenied = await Permission.photos.isPermanentlyDenied;

    final bool photosPermissions = !(photosIsRestricted || photosIsDenied || photosIsLimited || photosIsPermanentlyDenied);


    return locationPermissions && cameraPermissions && photosPermissions;
  }
}