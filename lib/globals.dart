library my_prj.globals;

import 'package:flutter_cube/flutter_cube.dart';

late Scene scene;
Object earth = Object(
  name: 'earth',
  scale: Vector3(12.0, 12.0, 12.0),
  backfaceCulling: false,
  fileName: 'assets/earth/earth.obj',
);

void addCountry(String fileName) {
  // var country = Object(
  //   name: fileName,
  //   scale: Vector3(12.5, 12.5, 12.5),
  //   backfaceCulling: false,
  //   fileName: fileName, // 'assets/country/earth.obj',
  // );
  scene.world.remove(earth);
}
