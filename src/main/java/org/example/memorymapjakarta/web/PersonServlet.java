package org.example.memorymapjakarta.web;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.example.memorymapjakarta.entity.Person;
import org.example.memorymapjakarta.service.PersonService;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/persons")
public class PersonServlet extends HttpServlet {

    @EJB
    private PersonService personService;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            showEditForm(request, response);
            return;
        }

        List<Person> persons = personService.findAll();
        request.setAttribute("persons", persons);

        request.getRequestDispatcher("/WEB-INF/persons.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        switch (action == null ? "" : action) {
            case "create" -> createPerson(request, response);
            case "update" -> updatePerson(request, response);
            case "delete" -> deletePerson(request, response);
            default -> response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Неизвестное действие"
            );
        }
    }

    private void showEditForm(HttpServletRequest request,
                              HttpServletResponse response)
            throws ServletException, IOException {

        Long id = parseId(request.getParameter("id"));

        if (id == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        Person person = personService.findById(id);

        if (person == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        request.setAttribute("person", person);
        request.getRequestDispatcher("/WEB-INF/person-edit.jsp")
                .forward(request, response);
    }

    private void createPerson(HttpServletRequest request,
                              HttpServletResponse response)
            throws IOException {

        Person person = new Person();
        fillPerson(person, request);
        personService.create(person);

        redirectToList(request, response);
    }

    private void updatePerson(HttpServletRequest request,
                              HttpServletResponse response)
            throws IOException {

        Long id = parseId(request.getParameter("id"));

        if (id == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        Person person = personService.findById(id);

        if (person == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        fillPerson(person, request);
        personService.update(person);

        redirectToList(request, response);
    }

    private void deletePerson(HttpServletRequest request,
                              HttpServletResponse response)
            throws IOException {

        Long id = parseId(request.getParameter("id"));

        if (id == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        personService.delete(id);

        redirectToList(request, response);
    }

    private void fillPerson(Person person, HttpServletRequest request) {
        person.setFirstName(request.getParameter("firstName").trim());
        person.setLastName(request.getParameter("lastName").trim());
        person.setBirthDate(parseDate(request.getParameter("birthDate")));
        person.setDeathDate(parseDate(request.getParameter("deathDate")));
        person.setDescription(request.getParameter("description"));
    }

    private LocalDate parseDate(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }

        return LocalDate.parse(value);
    }

    private Long parseId(String value) {
        try {
            return Long.parseLong(value);
        } catch (NumberFormatException | NullPointerException exception) {
            return null;
        }
    }

    private void redirectToList(HttpServletRequest request,
                                HttpServletResponse response)
            throws IOException {

        response.sendRedirect(request.getContextPath() + "/persons");
    }
}
