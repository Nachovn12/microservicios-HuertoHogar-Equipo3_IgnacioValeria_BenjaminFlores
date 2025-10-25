package com.huertohogar.carrito.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ItemDelCarritoDTO {
    private Long id;
    private Long productoId;
    private Integer cantidad;
    private Integer precioUnitario;
}
