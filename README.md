# CIU

[CubeRun-Server](Server) (add public IP and port of server in setup() in CubeRun.pde):
- c = new Client(this, "XX.XXX.XXX.XXX", XXXX); // AQUI IP PÚBLICA Y PUERTO DEL SERVIDOR

[CubeRun-Client](Client) (add previous port in setup() in CubeRun.pde):
- s = new Server(this, XXXX);  // PUERTO 
