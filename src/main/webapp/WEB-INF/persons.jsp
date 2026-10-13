
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>MemoryMap — Люди</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background: #f2f2f2;
        }

        form {
            margin-bottom: 30px;
        }

        form p {
            margin: 12px 0;
        }

        input, textarea {
            padding: 7px;
            max-width: 100%;
        }

        textarea {
            vertical-align: top;
        }

        button {
            padding: 7px 12px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<h1>MemoryMap — список людей</h1>

<h2>Добавить человека</h2>

<form action="${pageContext.request.contextPath}/persons" method="post">
    <input type="hidden" name="action" value="create">

    <p>
        <label>Имя:
            <input type="text" name="firstName" required maxlength="100">
        </label>
    </p>

    <p>
        <label>Фамилия:
            <input type="text" name="lastName" required maxlength="100">
        </label>
    </p>

    <p>
        <label>Дата рождения:
            <input type="date" name="birthDate">
        </label>
    </p>

    <p>
        <label>Дата смерти:
            <input type="date" name="deathDate">
        </label>
    </p>

    <p>
        <label>Описание:
            <textarea name="description" rows="3"></textarea>
        </label>
    </p>

    <button type="submit">Добавить</button>
</form>

<h2>Все записи</h2>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>Имя</th>
        <th>Фамилия</th>
        <th>Дата рождения</th>
        <th>Дата смерти</th>
        <th>Место захоронения</th>
        <th>Действия</th>
    </tr>
    </thead>

    <tbody>
    <c:forEach var="person" items="${persons}">
        <tr>
            <td>${person.id}</td>
            <td><c:out value="${person.firstName}"/></td>
            <td><c:out value="${person.lastName}"/></td>
            <td>${person.birthDate}</td>
            <td>${person.deathDate}</td>

            <td>
                <c:choose>
                    <c:when test="${person.burialLocation != null}">
                        <c:out value="${person.burialLocation.description}"/>
                    </c:when>
                    <c:otherwise>
                        Не указано
                    </c:otherwise>
                </c:choose>
            </td>

            <td>
                <a href="${pageContext.request.contextPath}/persons?action=edit&id=${person.id}">
                    Редактировать
                </a>

                <form action="${pageContext.request.contextPath}/persons"
                      method="post"
                      onsubmit="return confirm('Точно удалить эту запись?');">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="${person.id}">
                    <button type="submit">Удалить</button>
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

</body>
</html>
