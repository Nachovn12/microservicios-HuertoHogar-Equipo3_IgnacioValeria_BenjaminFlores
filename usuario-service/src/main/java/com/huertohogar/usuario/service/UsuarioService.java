package com.huertohogar.usuario.service;

import com.huertohogar.usuario.model.Usuario;
import com.huertohogar.usuario.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    // Obtener todos los usuarios
    public List<Usuario> getAllUsuarios() {
        return usuarioRepository.findAll();
    }

    // Buscar a los usuarios por su ID
    public Usuario getUsuarioById(Long id) {
        // Si no existe, devolvemos null (mejorar con manejo de errores después)
        return usuarioRepository.findById(id).orElse(null);
    }
    // Actualizar un usuario existente
    public Usuario updateUsuario(Long id, Usuario usuario) {
        // Buscamos el usuario existente
        Usuario usuarioExistente = usuarioRepository.findById(id).orElse(null);
        if (usuarioExistente != null) {
            // Actualizamos los campos
            usuarioExistente.setNombre(usuario.getNombre());
            usuarioExistente.setCorreo(usuario.getCorreo());
            usuarioExistente.setContrasena(usuario.getContrasena());
            usuarioExistente.setDireccion(usuario.getDireccion());
            usuarioExistente.setTelefono(usuario.getTelefono());
            // Guardamos los cambios
            return usuarioRepository.save(usuarioExistente);
        } else {
            // Si no existe, devolvemos null (mejorar con manejo de errores después)
            return null;
        }
    }

    // Guardar a un usuario nuevo
    public Usuario saveUsuario(Usuario usuario) {
        return usuarioRepository.save(usuario);
    }

    // Eliminar a un usuario por su ID
    public void deleteUsuario(Long id) {
        usuarioRepository.deleteById(id);
    }
}