import { createUser, findUserByEmail } from '../models/user.service.js';

export const register = async (req, res) => {
  const {username, email, password, empresaId } = req.body;
  
  try {
    // Verificar si el usuario ya existe
    const existingUser = await findUserByEmail(email);
    if (existingUser) {
      return res.status(400).json({ message: 'El usuario ya existe.' });
    }

    // Crear el usuario
    console.log(req.body)
    const newUser = await createUser({
      nombre: username,
      email,
      contrasena: password,
      empresaId,
    });

    res.status(201).json({ message: 'Usuario creado con éxito.', user: newUser });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error al crear el usuario.' });
  }
};

  
export const login = (req, res) => {
    console.log(req.body)
    res.send("login successful");
};
  