
package org.example.memorymapjakarta.web;

import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.memorymapjakarta.entity.BurialLocation;
import org.example.memorymapjakarta.entity.Person;
import org.example.memorymapjakarta.service.BurialLocationService;
import org.example.memorymapjakarta.service.PersonService;

import java.io.IOException;
import java.util.List;

@WebServlet("/burial-locations")
public class BurialLocationServlet extends HttpServlet {

    @Inject
    private BurialLocationService burialLocationService;

    @Inject
    private PersonService personService;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("new".equals(action)) {
            request.setAttribute("persons", personService.findAll());
            request.getRequestDispatcher("/WEB-INF/burial-location-edit.jsp")
                    .forward(request, response);
            return;
        }

        if ("edit".equals(action)) {
            Long id = parseId(request.getParameter("id"));
            BurialLocation location =
                    id == null ? null : burialLocationService.findById(id);

            if (location == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND,
                        "Место захоронения не найдено");
                return;
            }

            request.setAttribute("location", location);
            request.setAttribute("persons", personService.findAll());
            request.getRequestDispatcher("/WEB-INF/burial-location-edit.jsp")
                    .forward(request, response);
            return;
        }

        List<BurialLocation> locations = burialLocationService.findAll();
        request.setAttribute("locations", locations);
        request.getRequestDispatcher("/WEB-INF/burial-locations.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                createLocation(request);
            } else if ("update".equals(action)) {
                updateLocation(request);
            } else if ("delete".equals(action)) {
                deleteLocation(request);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                        "Неизвестное действие");
                return;
            }

            response.sendRedirect(
                    request.getContextPath() + "/burial-locations");

        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    e.getMessage());
        }
    }

    private void createLocation(HttpServletRequest request) {
        BurialLocation location = new BurialLocation();
        fillLocation(location, request);
        burialLocationService.create(location);
    }

    private void updateLocation(HttpServletRequest request) {
        Long id = parseId(request.getParameter("id"));

        if (id == null) {
            throw new IllegalArgumentException("Некорректный ID");
        }

        BurialLocation location = burialLocationService.findById(id);

        if (location == null) {
            throw new IllegalArgumentException(
                    "Место захоронения не найдено");
        }

        fillLocation(location, request);
        burialLocationService.update(location);
    }

    private void deleteLocation(HttpServletRequest request) {
        Long id = parseId(request.getParameter("id"));

        if (id == null) {
            throw new IllegalArgumentException("Некорректный ID");
        }

        burialLocationService.delete(id);
    }

    private void fillLocation(BurialLocation location,
                              HttpServletRequest request) {

        location.setLatitude(parseDouble(request.getParameter("latitude"),
                "широты"));

        location.setLongitude(parseDouble(request.getParameter("longitude"),
                "долготы"));

        location.setExact("true".equals(request.getParameter("exact")));

        location.setDescription(request.getParameter("description"));

        Long personId = parseId(request.getParameter("personId"));

        if (personId == null) {
            throw new IllegalArgumentException("Выберите человека");
        }

        Person person = personService.findById(personId);

        if (person == null) {
            throw new IllegalArgumentException("Человек не найден");
        }

        location.setPerson(person);
    }

    private Long parseId(String value) {
        try {
            return value == null || value.isBlank()
                    ? null : Long.parseLong(value);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private Double parseDouble(String value, String fieldName) {
        if (value == null || value.isBlank()) {
            return null;
        }

        try {
            double number = Double.parseDouble(value);

            if (!Double.isFinite(number)) {
                throw new IllegalArgumentException(
                        "Некорректное значение " + fieldName);
            }

            if ("широты".equals(fieldName)
                    && (number < -90 || number > 90)) {
                throw new IllegalArgumentException(
                        "Широта должна быть от -90 до 90");
            }

            if ("долготы".equals(fieldName)
                    && (number < -180 || number > 180)) {
                throw new IllegalArgumentException(
                        "Долгота должна быть от -180 до 180");
            }

            return number;
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(
                    "Некорректное значение " + fieldName);
        }
    }
}