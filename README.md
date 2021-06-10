# CIU

[CubeRun-Server](https://github.com/Prashant-JT/Cube-Run/tree/master/CubeRun-Server/CubeRun) (add public IP and port of server in setup() in [CubeRun.pde](https://github.com/Prashant-JT/Cube-Run/blob/master/CubeRun-Server/CubeRun/CubeRun.pde)):
- c = new Client(this, "XX.XXX.XXX.XXX", XXXX); // AQUI IP PÚBLICA Y PUERTO DEL SERVIDOR

[CubeRun-Client](https://github.com/Prashant-JT/Cube-Run/tree/master/CubeRun-Client/CubeRun) (add previous port in setup() in [CubeRun.pde](https://github.com/Prashant-JT/Cube-Run/blob/master/CubeRun-Client/CubeRun/CubeRun.pde)):
- s = new Server(this, XXXX);  // PUERTO 
