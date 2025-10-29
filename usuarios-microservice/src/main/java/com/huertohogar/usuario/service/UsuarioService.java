package com.huertohogar.usuario.service;

import com.huertohogar.usuario.entity.UsuarioEntity;
import com.huertohogar.usuario.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    // Obtener todos los usuarios
    public List<UsuarioEntity> getAllUsuarios() {
        return usuarioRepository.findAll();
    }

    // Buscar usuario por ID
    public UsuarioEntity getUsuarioById(Long id) {
        return usuarioRepository.findById(id).orElse(null);
    }

    // Guardar usuario nuevo
    public UsuarioEntity saveUsuario(UsuarioEntity usuario) {
        return usuarioRepository.save(usuario);
    }

    // Actualizar usuario
    public UsuarioEntity updateUsuario(Long id, UsuarioEntity usuario) {
        UsuarioEntity existente = usuarioRepository.findById(id).orElse(null);
        if (existente != null) {
            existente.setNombre(usuario.getNombre());
            existente.setCorreo(usuario.getCorreo());
            existente.setContrasena(usuario.getContrasena());
            existente.setDireccion(usuario.getDireccion());
            existente.setTelefono(usuario.getTelefono());
            return usuarioRepository.save(existente);
        }
        return null;
    }

    // Eliminar usuario
    public void deleteUsuario(Long id) {
        usuarioRepository.deleteById(id);
    }
}