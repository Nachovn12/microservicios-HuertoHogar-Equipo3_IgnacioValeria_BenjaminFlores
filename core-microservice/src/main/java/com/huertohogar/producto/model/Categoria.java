package com.huertohogar.producto.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Categoria {
    private String nombre;
    private String descripcion;

    // Categorías fijas del caso HuertoHogar
    public static final String FRUTAS_FRESCAS = "Frutas Frescas";
    public static final String VERDURAS_ORGANICAS = "Verduras Orgánicas";
    public static final String PRODUCTOS_ORGANICOS = "Productos Orgánicos";
    public static final String PRODUCTOS_LACTEOS = "Productos Lácteos";
}
