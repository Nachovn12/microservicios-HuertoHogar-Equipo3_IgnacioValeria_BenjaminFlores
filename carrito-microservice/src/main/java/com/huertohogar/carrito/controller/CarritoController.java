package com.huertohogar.carrito.controller;

import com.huertohogar.carrito.entity.CarritoEntity;
import com.huertohogar.carrito.service.CarritoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/carritos")
public class CarritoController {

    @Autowired
    private CarritoService carritoService;

    @Autowired
    private com.huertohogar.carrito.service.SqsProducerService sqsProducerService;

    @GetMapping("/ping")
    public String ping() {
        return "pong";
    }

    @GetMapping("/ping/test")
    public String test() {
        return "test";
    }

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

    @PostMapping("/confirmar/{id}")
    public org.springframework.http.ResponseEntity<String> confirmarCarrito(@PathVariable Long id) {
        // Aquí podrías buscar el carrito y obtener el email real del usuario
        // Por simplicidad para la demo:
        String emailSimulado = "usuario" + id + "@huertohogar.com";

        try {
            System.out.println("Endpoint /confirmar alcanzado para ID: " + id);
            sqsProducerService.sendOrderConfirmation(id, emailSimulado);
            return org.springframework.http.ResponseEntity.ok("Compra confirmada. Pedido enviado a procesamiento.");
        } catch (Exception e) {
            System.err.println("Error no bloqueante en SQS: " + e.getMessage());
            return org.springframework.http.ResponseEntity
                    .ok("Compra confirmada localmente. ADVERTENCIA: No se pudo enviar a SQS (" + e.getMessage() + ")");
        }
    }
}
