export class Configuration {
  base_url: string = "http://localhost:7000/"; // maps to docker compose service rest
  api_url: string = this.base_url + "api/";
  auth_url: string = this.base_url + "auth/";
  
  google_auth_client_id:string="blahhh.apps.googleusercontent.com";

  grafana_url: string = "http://localhost:3000/"; // maps to docker compose service grafana

  mapper_url: string = "http://localhost:9000/";  // maps to docker compose service mapper
  mapper_url_public: string = this.mapper_url + "map/public/all";
  mapper_url_owner: string = this.mapper_url + "map/owner/";
  mapper_url_device: string = this.mapper_url + "map/device/"; // Unused

  splash_map_url: string = "https://res.openchirp.io/leaflet/index.html";
}
