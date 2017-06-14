export class Configuration {
  base_url: string = "http://openchirp.demo:10010/";
  api_url: string = this.base_url + "api/";
  auth_url: string = this.base_url + "auth/";
  google_auth: string = this.auth_url + "google/";
  logout_url: string = this.auth_url + "logout/";
  grafana_url: string = "http://openchirp.demo:3000/";
}
