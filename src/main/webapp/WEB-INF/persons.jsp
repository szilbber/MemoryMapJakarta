<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>MemoryMap — Люди</title>
    <style>
        * { box-sizing: border-box; }

        body {
            font-family: Arial, sans-serif;
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
            color: #333;
            background: #f5f7fa;
        }

        h1 { color: #245b8f; margin-bottom: 12px; }
        h2 { margin-top: 0; color: #24496d; }

        a { color: #245b8f; text-decoration: none; }
        a:hover { text-decoration: underline; }

        .navigation {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
        }

        .card {
            background: white;
            padding: 24px;
            margin: 20px 0;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,.08);
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 16px 24px;
        }

        .form-field {
            display: flex;
            flex-direction: column;
            gap: 7px;
        }

        .full-width { grid-column: 1 / -1; }

        input, textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font: inherit;
        }

        input:focus, textarea:focus {
            outline: none;
            border-color: #245b8f;
        }

        textarea { resize: vertical; }

        button, .add-button {
            display: inline-block;
            padding: 10px 16px;
            border: none;
            border-radius: 6px;
            background: #245b8f;
            color: white;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
        }

        button:hover, .add-button:hover {
            background: #19466f;
            text-decoration: none;
        }

        .table-container {
            overflow-x: auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,.08);
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 13px 15px;
            border-bottom: 1px solid #ddd;
            text-align: left;
            vertical-align: top;
        }

        th {
            background: #eaf1f8;
            color: #24496d;
            white-space: nowrap;
        }

        tbody tr:hover { background: #f4f8fc; }

        .actions { min-width: 140px; }
        .edit-link { display: inline-block; margin-bottom: 10px; }

        .delete-form { margin: 0; }

        .delete-button { background: #b93c3c; }
        .delete-button:hover { background: #922d2d; }

        .empty-message {
            text-align: center;
            color: #777;
            padding: 25px;
        }

        @media (max-width: 700px) {
            .form-grid { grid-template-columns: 1fr; }
            .full-width { grid-column: auto; }
            body { margin-top: 20px; }
        }
    </style>
</head>
<body>

<h1>MemoryMap — Люди</h1>

<div class="navigation">
    <a href="${pageContext.request.contextPath}/">Главная</a>
    <a href="${pageContext.request.contextPath}/burial-locations">Места захоронений</a>
</div>

<div class="card">
    <h2>Добавить человека</h2>

    <form action="${pageContext.request.contextPath}/persons" method="post">
        <input type="hidden" name="action" value="create">

        <div class="form-grid">
            <div class="form-field">
                <label for="firstName">Имя</label>
                <input id="firstName" name="firstName" type="text"
                       maxlength="100" required>
            </div>

            <div class="form-field">
                <label for="lastName">Фамилия</label>
                <input id="lastName" name="lastName" type="text"
                       maxlength="100" required>
            </div>

            <div class="form-field">
                <label for="birthDate">Дата рождения</label>
                <input id="birthDate" name="birthDate" type="date">
            </div>

            <div class="form-field">
                <label for="deathDate">Дата смерти</label>
                <input id="deathDate" name="deathDate" type="date">
            </div>

            <div class="form-field full-width">
                <label for="description">Описание</label>
                <textarea id="description" name="description" rows="3"></textarea>
            </div>
        </div>

        <p><button type="submit">Добавить человека</button></p>
    </form>
</div>

<h2>Все записи</h2>

<div class="table-container">
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
                <td><c:out value="${person.id}"/></td>
                <td><c:out value="${person.firstName}"/></td>
                <td><c:out value="${person.lastName}"/></td>
                <td><c:out value="${person.birthDate}"/></td>
                <td><c:out value="${person.deathDate}"/></td>
                <td>
                    <c:choose>
                        <c:when test="${person.burialLocation != null}">
                            <c:out value="${person.burialLocation.description}"/>
                        </c:when>
                        <c:otherwise><span style="color:#777">Не указано</span></c:otherwise>
                    </c:choose>
                </td>
                <td class="actions">
                    <a class="edit-link"
                       href="${pageContext.request.contextPath}/persons?action=edit&id=${person.id}">
                        Редактировать
                    </a>

                    <form class="delete-form"
                          action="${pageContext.request.contextPath}/persons"
                          method="post"
                          onsubmit="return confirm('Точно удалить эту запись?');">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="${person.id}">
                        <button class="delete-button" type="submit">Удалить</button>
                    </form>
                </td>
            </tr>
        </c:forEach>

        <c:if test="${empty persons}">
            <tr>
                <td colspan="7" class="empty-message">Записей пока нет.</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

</body>
</html>