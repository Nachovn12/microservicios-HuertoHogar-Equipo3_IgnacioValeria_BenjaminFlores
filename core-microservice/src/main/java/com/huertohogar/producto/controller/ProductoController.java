package com.huertohogar.producto.controller;

import com.huertohogar.producto.entity.ProductoEntity;
import com.huertohogar.producto.service.ProductoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/productos")
public class ProductoController {

    @Autowired
    private ProductoService productoService;

    // Obtener todos los productos
    @GetMapping
    public List<ProductoEntity> getAllProductos() {
        return productoService.getAllProductos();
    }

    // Obtener producto por ID
    @GetMapping("/{id}")
    public ProductoEntity getProductoById(@PathVariable Long id) {
        return productoService.getProductoById(id);
    }

    // Crear producto nuevo
    @PostMapping
    public ProductoEntity createProducto(@RequestBody ProductoEntity producto) {
        return productoService.saveProducto(producto);
    }

    // Actualizar producto
    @PutMapping("/{id}")
    public ProductoEntity updateProducto(@PathVariable Long id, @RequestBody ProductoEntity producto) {
        return productoService.updateProducto(id, producto);
    }

    // Eliminar producto
    @DeleteMapping("/{id}")
    public void deleteProducto(@PathVariable Long id) {
        productoService.deleteProducto(id);
    }
}
