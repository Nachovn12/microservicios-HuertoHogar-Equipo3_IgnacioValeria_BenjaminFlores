package com.huertohogar.carrito.service;

import com.huertohogar.carrito.entity.ItemDelCarritoEntity;
import com.huertohogar.carrito.repository.ItemDelCarritoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ItemDelCarritoService {
    @Autowired
    private ItemDelCarritoRepository itemDelCarritoRepository;

    public List<ItemDelCarritoEntity> getAllItems() {
        return itemDelCarritoRepository.findAll();
    }

    public Optional<ItemDelCarritoEntity> getItemById(Long id) {
        return itemDelCarritoRepository.findById(id);
    }

    public ItemDelCarritoEntity saveItem(ItemDelCarritoEntity item) {
        return itemDelCarritoRepository.save(item);
    }

    public ItemDelCarritoEntity updateItem(Long id, ItemDelCarritoEntity item) {
        item.setId(id);
        return itemDelCarritoRepository.save(item);
    }

    public void deleteItem(Long id) {
        itemDelCarritoRepository.deleteById(id);
    }
}
