package org.example.memorymapjakarta.service;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.example.memorymapjakarta.entity.Person;

import java.util.List;

@Stateless
public class PersonService {

    @PersistenceContext(unitName = "MemoryMapPU")
    private EntityManager entityManager;

    // Получить всех людей
    public List<Person> findAll() {
        return entityManager
                .createQuery("SELECT p FROM Person p ORDER BY p.id", Person.class)
                .getResultList();
    }

    // Найти человека по ID
    public Person findById(Long id) {
        return entityManager.find(Person.class, id);
    }

    // Добавить человека
    public void create(Person person) {
        entityManager.persist(person);
    }

    // Изменить данные человека
    public Person update(Person person) {
        return entityManager.merge(person);
    }

    // Удалить человека
    public void delete(Long id) {
        Person person = findById(id);

        if (person != null) {
            entityManager.remove(person);
        }
    }
}
