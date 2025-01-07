import app from "./app.js";
import prisma from "./prisma.js";

// Ejemplo: Conectar manualmente (opcional)
(async () => {
  try {
    await prisma.$connect(); // Establece la conexión con la base de datos
    console.log('Connected to the database.');
    
    app.listen(3000, () => {
      console.log('Server on port', 3000);
    });
  } catch (error) {
    console.error('Error connecting to the database:', error);
    process.exit(1); // Salir del proceso si ocurre un error crítico
  }
})();
