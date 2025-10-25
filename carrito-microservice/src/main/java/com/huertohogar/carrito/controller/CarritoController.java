package com.huertohogar.carrito.controller;

import com.huertohogar.carrito.entity.CarritoEntity;
import com.huertohogar.carrito.service.CarritoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/carritos")
public class CarritoController {

    @Autowired
    private CarritoService carritoService;

    // Listar todos los carritos
    @GetMapping
    public List<CarritoEntity> getAllCarritos() {
        return carritoService.getAllCarritos();
    }

    // Obtener carrito por ID
    @GetMapping("/{id}")
    public Optional<CarritoEntity> getCarritoById(@PathVariable Long id) {
        return carritoService.getCarritoById(id);
    }

    // Crear carrito
    @PostMapping
    public CarritoEntity createCarrito(@RequestBody CarritoEntity carrito) {
        return carritoService.saveCarrito(carrito);
    }

    // Actualizar carrito
    @PutMapping("/{id}")
    public CarritoEntity updateCarrito(@PathVariable Long id, @RequestBody CarritoEntity carrito) {
        return carritoService.updateCarrito(id, carrito);
    }

    // Eliminar carrito
    @DeleteMapping("/{id}")
    public void deleteCarrito(@PathVariable Long id) {
        carritoService.deleteCarrito(id);
    }
}
