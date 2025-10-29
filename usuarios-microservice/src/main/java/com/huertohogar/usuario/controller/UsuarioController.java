package com.huertohogar.usuario.controller;

import com.huertohogar.usuario.entity.UsuarioEntity;
import com.huertohogar.usuario.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/usuarios")
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;

    // Obtener todos los usuarios
    @GetMapping
    public List<UsuarioEntity> getAllUsuarios() {
        return usuarioService.getAllUsuarios();
    }

    // Obtener usuario por id
    @GetMapping("/{id}")
    public UsuarioEntity getUsuarioById(@PathVariable Long id) {
        return usuarioService.getUsuarioById(id);
    }

    // Crear usuario nuevo
    @PostMapping
    public UsuarioEntity createUsuario(@RequestBody UsuarioEntity usuario) {
        return usuarioService.saveUsuario(usuario);
    }

    // Actualizar usuario
    @PutMapping("/{id}")
    public UsuarioEntity updateUsuario(@PathVariable Long id, @RequestBody UsuarioEntity usuario) {
        return usuarioService.updateUsuario(id, usuario);
    }

    // Eliminar usuario
    @DeleteMapping("/{id}")
    public void deleteUsuario(@PathVariable Long id) {
        usuarioService.deleteUsuario(id);
    }
}
