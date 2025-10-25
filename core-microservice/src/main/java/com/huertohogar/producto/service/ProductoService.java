package com.huertohogar.producto.service;

import com.huertohogar.producto.entity.ProductoEntity;
import com.huertohogar.producto.repository.ProductoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductoService {

    @Autowired
    private ProductoRepository productoRepository;

    // Obtener todos los productos
    public List<ProductoEntity> getAllProductos() {
        return productoRepository.findAll();
    }

    // Obtener producto por ID
    public ProductoEntity getProductoById(Long id) {
        return productoRepository.findById(id).orElse(null);
    }

    // Guardar producto nuevo
    public ProductoEntity saveProducto(ProductoEntity producto) {
        return productoRepository.save(producto);
    }

    // Actualizar producto
    public ProductoEntity updateProducto(Long id, ProductoEntity producto) {
        ProductoEntity existente = productoRepository.findById(id).orElse(null);
        if (existente != null) {
            existente.setCodigo(producto.getCodigo());
            existente.setNombre(producto.getNombre());
            existente.setDescripcion(producto.getDescripcion());
            existente.setCategoria(producto.getCategoria());
            existente.setOrigen(producto.getOrigen());
            existente.setStock(producto.getStock());
            existente.setPrecio(producto.getPrecio());
            return productoRepository.save(existente);
        }
        return null;
    }

    // Eliminar producto
    public void deleteProducto(Long id) {
        productoRepository.deleteById(id);
    }
}
