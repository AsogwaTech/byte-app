import 'package:cached_network_image/cached_network_image.dart';
import 'package:etra_flutter/app_config.dart';
import 'package:etra_flutter/services/session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**
 * @author Gibah Joseph
 * email: gibahjoe@gmail.com
 * Nov, 2021
 **/
class OrganizationLogo extends StatelessWidget {
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  const OrganizationLogo(
      {Key? key, this.width, this.height = 50, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Session _session = Provider.of(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(10),
          image: DecorationImage(
              image: CachedNetworkImageProvider(
                  '${AppConfig.baseUrl}/files/${_session.currentWorkspace?.bannerId}'),
              fit: BoxFit.cover)),
    );
  }
}
