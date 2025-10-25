package com.huertohogar.carrito.repository;

import com.huertohogar.carrito.entity.CarritoEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CarritoRepository extends JpaRepository<CarritoEntity, Long> {
}
