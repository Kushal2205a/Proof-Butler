import 'package:vault_client/vault_client.dart';

late Client client;

void initServerpodClient() {
  client = Client(
    'http://192.168.0.102:8080/'
  );
}
