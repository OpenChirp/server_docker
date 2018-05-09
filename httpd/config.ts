export class Configuration {
  base_url: string = "http://localhost:7000/"; // docker container rest exposes port 7000
  api_url: string = this.base_url + "api/";
  auth_url: string = this.base_url + "auth/";
  
  google_auth_client_id:string="blahhh.apps.googleusercontent.com"; 

  grafana_url: string = "http://localhost:3000/"; // docker container grafana exposes port 3000

  mapper_url: string = "http://localhost:9000/";  // docker container gpsmapper-service exposes port 9000
  mapper_url_public: string = this.mapper_url + "map/public/all";
  mapper_url_owner: string = this.mapper_url + "map/owner/";
  mapper_url_device: string = this.mapper_url + "map/device/"; // Unused

  splash_map_url: string = "https://res.openchirp.io/leaflet/index.html"; //TODO: This should be updated to localhost file
}
