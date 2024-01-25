class EnvConfig {
  static const String baseUrl = String.fromEnvironment('BASE_URL',
      defaultValue: 'sandbox.api.lettutor.com');
}
