package com.huertohogar.carrito.controller;

import com.huertohogar.carrito.entity.ItemDelCarritoEntity;
import com.huertohogar.carrito.service.ItemDelCarritoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/items-carrito")
public class ItemDelCarritoController {

    @Autowired
    private ItemDelCarritoService itemDelCarritoService;

    // Listar todos los ítems del carrito
    @GetMapping
    public List<ItemDelCarritoEntity> getAllItems() {
        return itemDelCarritoService.getAllItems();
    }

    // Obtener ítem por ID
    @GetMapping("/{id}")
    public Optional<ItemDelCarritoEntity> getItemById(@PathVariable Long id) {
        return itemDelCarritoService.getItemById(id);
    }

    // Crear ítem
    @PostMapping
    public ItemDelCarritoEntity createItem(@RequestBody ItemDelCarritoEntity item) {
        return itemDelCarritoService.saveItem(item);
    }

    // Actualizar ítem
    @PutMapping("/{id}")
    public ItemDelCarritoEntity updateItem(@PathVariable Long id, @RequestBody ItemDelCarritoEntity item) {
        return itemDelCarritoService.updateItem(id, item);
    }

    // Eliminar ítem
    @DeleteMapping("/{id}")
    public void deleteItem(@PathVariable Long id) {
        itemDelCarritoService.deleteItem(id);
    }
}
