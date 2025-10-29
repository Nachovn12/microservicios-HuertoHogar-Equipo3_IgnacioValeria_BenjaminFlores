package com.huertohogar.producto.repository;

import com.huertohogar.producto.entity.ProductoEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductoRepository extends JpaRepository<ProductoEntity, Long> {
    // No agrego métodos extra, JpaRepository ya tiene CRUD
}
