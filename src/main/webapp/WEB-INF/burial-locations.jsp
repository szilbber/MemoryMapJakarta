<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Места захоронения — MemoryMap</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
            color: #333;
            background-color: #f5f7fa;
        }

        h1 {
            margin-bottom: 25px;
            color: #245b8f;
        }

        .navigation {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
        }

        a {
            color: #245b8f;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .add-button {
            display: inline-block;
            padding: 10px 16px;
            margin-bottom: 20px;
            background-color: #245b8f;
            color: white;
            border-radius: 6px;
            text-decoration: none;
        }

        .add-button:hover {
            background-color: #19466f;
            text-decoration: none;
        }

        .table-container {
            overflow-x: auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
        }

        th, td {
            padding: 13px 15px;
            border-bottom: 1px solid #ddd;
            text-align: left;
            vertical-align: middle;
        }

        th {
            background-color: #eaf1f8;
            color: #24496d;
            font-weight: bold;
            white-space: nowrap;
        }

        tbody tr:hover {
            background-color: #f4f8fc;
        }

        .actions {
            min-width: 140px;
        }

        .edit-link {
            display: inline-block;
            margin-bottom: 8px;
        }

        .delete-button {
            padding: 7px 11px;
            border: none;
            border-radius: 5px;
            background-color: #b93c3c;
            color: white;
            cursor: pointer;
        }

        .delete-button:hover {
            background-color: #922d2d;
        }

        .empty-message {
            text-align: center;
            color: #777;
            padding: 25px;
        }
    </style>
</head>

<body>

<h1>Места захоронения</h1>

<div class="navigation">
    <a href="${pageContext.request.contextPath}/">На главную</a>
    <a href="${pageContext.request.contextPath}/persons">К списку людей</a>
</div>

<p>
    <a class="add-button"
       href="${pageContext.request.contextPath}/burial-locations?action=new">
        + Добавить место захоронения
    </a>
</p>

<div class="table-container">
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Человек</th>
            <th>Широта</th>
            <th>Долгота</th>
            <th>Точность координат</th>
            <th>Описание</th>
            <th>Действия</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="location" items="${locations}">
            <tr>
                <td><c:out value="${location.id}"/></td>

                <td>
                    <c:out value="${location.person.firstName}"/>
                    <c:out value="${location.person.lastName}"/>
                </td>

                <td><c:out value="${location.latitude}"/></td>
                <td><c:out value="${location.longitude}"/></td>

                <td>
                    <c:choose>
                        <c:when test="${location.exact}">Точные</c:when>
                        <c:otherwise>Приблизительные</c:otherwise>
                    </c:choose>
                </td>

                <td><c:out value="${location.description}"/></td>

                <td class="actions">
                    <a class="edit-link"
                       href="${pageContext.request.contextPath}/burial-locations?action=edit&id=${location.id}">
                        Редактировать
                    </a>

                    <form method="post"
                          action="${pageContext.request.contextPath}/burial-locations"
                          onsubmit="return confirm('Удалить место захоронения?');">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="${location.id}">
                        <button class="delete-button" type="submit">
                            Удалить
                        </button>
                    </form>
                </td>
            </tr>
        </c:forEach>

        <c:if test="${empty locations}">
            <tr>
                <td colspan="7" class="empty-message">
                    Места захоронения пока не добавлены.
                </td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

</body>
</html>