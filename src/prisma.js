import { PrismaClient } from '@prisma/client';

let prisma;

async function initializePrisma() {
  try {
    prisma = new PrismaClient();
    console.log('Prisma Client initialized successfully.');
    await prisma.$connect(); // Conecta explícitamente al cliente
  } catch (error) {
    console.error('Error initializing Prisma Client:', error);
    process.exit(1); // Salir del proceso si ocurre un error crítico
  }
}

initializePrisma();

export default prisma;
