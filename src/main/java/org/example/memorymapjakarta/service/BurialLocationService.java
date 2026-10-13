package org.example.memorymapjakarta.service;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.memorymapjakarta.entity.BurialLocation;

import java.util.List;

@Stateless
public class BurialLocationService {

    @PersistenceContext(unitName = "MemoryMapPU")
    private EntityManager entityManager;

    // Получить все места захоронения
    public List<BurialLocation> findAll() {
        return entityManager.createQuery(
                "SELECT b FROM BurialLocation b ORDER BY b.id",
                BurialLocation.class
        ).getResultList();
    }

    // Найти место захоронения по ID
    public BurialLocation findById(Long id) {
        return entityManager.find(BurialLocation.class, id);
    }

    // Добавить место захоронения
    public void create(BurialLocation location) {
        entityManager.persist(location);
    }

    // Изменить место захоронения
    public BurialLocation update(BurialLocation location) {
        return entityManager.merge(location);
    }

    // Удалить место захоронения
    public void delete(Long id) {
        BurialLocation location = findById(id);

        if (location != null) {
            entityManager.remove(location);
        }
    }
}

