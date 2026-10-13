/// Camera/gallery permissions are requested automatically by `image_picker`
/// on Android/iOS. Add platform usage descriptions (see README) and this
/// service can be extended with `permission_handler` if finer control is needed.
class PermissionService {
  Future<bool> ensureCameraAndGallery() async => true;
}
