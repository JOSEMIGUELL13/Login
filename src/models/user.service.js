import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export const createUser = async (data) => {
  const { nombre, email, contrasena, empresaId } = data;
  return await prisma.usuario.create({
    data: {
      nombre,
      email,
      contrasena,
      empresaId,
    },
  });
};

export const findUserByEmail = async (email) => {
  return await prisma.usuario.findUnique({
    where: {
      email,
    },
  });
};
