package com.huertohogar.carrito.repository;

import com.huertohogar.carrito.entity.ItemDelCarritoEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ItemDelCarritoRepository extends JpaRepository<ItemDelCarritoEntity, Long> {
}
