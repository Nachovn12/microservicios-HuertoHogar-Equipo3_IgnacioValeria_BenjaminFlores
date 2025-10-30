package com.huertohogar.carrito.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity
@Table(name = "item_del_carrito")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ItemDelCarritoEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Long productoId; // ID del producto
    private Integer cantidad;
    private Integer precioUnitario;

    @ManyToOne
    private CarritoEntity carrito; // Relación con el carrito
}
