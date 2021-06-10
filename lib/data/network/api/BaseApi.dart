enum Environment { STAGING, PROD }

class BaseApis {
  static String dogPathApi = '';

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.STAGING:
        setStagingUrl();
        break;
      case Environment.PROD:
        setProductionUrl();
        break;
    }
  }

  static void setStagingUrl() {
    dogPathApi = '5d55541936ad770014ccdf2d.mockapi.io';
  }

  static void setProductionUrl() {
    dogPathApi = '5d55541936ad770014ccdf2d.mockapi.io';
  }
}
