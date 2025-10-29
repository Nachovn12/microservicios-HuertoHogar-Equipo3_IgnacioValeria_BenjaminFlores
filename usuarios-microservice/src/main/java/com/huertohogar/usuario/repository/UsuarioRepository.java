package com.huertohogar.usuario.repository;

import com.huertohogar.usuario.entity.UsuarioEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsuarioRepository extends JpaRepository<UsuarioEntity, Long> {
	// No es necesario agregar métodos, JpaRepository ya tiene CRUD
}