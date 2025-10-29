package com.huertohogar.carrito.service;

import com.huertohogar.carrito.entity.CarritoEntity;
import com.huertohogar.carrito.repository.CarritoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CarritoService {
    @Autowired
    private CarritoRepository carritoRepository;

    public List<CarritoEntity> getAllCarritos() {
        return carritoRepository.findAll();
    }

    public Optional<CarritoEntity> getCarritoById(Long id) {
        return carritoRepository.findById(id);
    }

    public CarritoEntity saveCarrito(CarritoEntity carrito) {
        return carritoRepository.save(carrito);
    }

    public CarritoEntity updateCarrito(Long id, CarritoEntity carrito) {
        carrito.setId(id);
        return carritoRepository.save(carrito);
    }

    public void deleteCarrito(Long id) {
        carritoRepository.deleteById(id);
    }
}
