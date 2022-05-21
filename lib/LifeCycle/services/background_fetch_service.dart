import 'package:bshare/LifeCycle/services/stoppable_service.dart';

class BackgroundService extends StoppableService {
  @override
  void start() {
    super.start();
    print('BackgroundService started $serviceStopped');
  }

  @override
  void stop() {
    super.stop();
    print('BackgroundService stopped $serviceStopped');
  }
}
