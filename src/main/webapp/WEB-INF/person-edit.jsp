<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>MemoryMap — Редактирование человека</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
            color: #333;
            background: #f5f7fa;
        }

        h1 {
            color: #245b8f;
            margin-bottom: 12px;
        }

        h2 {
            margin-top: 0;
            color: #24496d;
        }

        a {
            color: #245b8f;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .navigation {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 25px;
        }

        .card {
            background: white;
            padding: 24px;
            margin: 20px 0;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, .08);
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

        .full-width {
            grid-column: 1 / -1;
        }

        input,
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font: inherit;
        }

        input:focus,
        textarea:focus {
            outline: none;
            border-color: #245b8f;
        }

        textarea {
            resize: vertical;
        }

        button,
        .secondary-button {
            display: inline-block;
            padding: 10px 16px;
            border: none;
            border-radius: 6px;
            background: #245b8f;
            color: white;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            font-family: inherit;
        }

        button:hover,
        .secondary-button:hover {
            background: #19466f;
            text-decoration: none;
        }

        .secondary-button {
            background: #eaf1f8;
            color: #245b8f;
        }

        .secondary-button:hover {
            background: #d8e5f2;
        }

        .form-actions {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 12px;
            margin-top: 22px;
        }

        @media (max-width: 700px) {
            .form-grid {
                grid-template-columns: 1fr;
            }

            .full-width {
                grid-column: auto;
            }

            body {
                margin-top: 20px;
            }
        }
    </style>
</head>

<body>

<h1>Редактирование человека</h1>

<div class="navigation">
    <a href="${pageContext.request.contextPath}/">Главная</a>
    <a href="${pageContext.request.contextPath}/persons">Люди</a>
    <a href="${pageContext.request.contextPath}/burial-locations">
        Места захоронений
    </a>
</div>

<div class="card">

    <h2>Изменение данных человека</h2>

    <form action="${pageContext.request.contextPath}/persons" method="post">

        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="${person.id}">

        <div class="form-grid">

            <div class="form-field">
                <label for="firstName">Имя</label>
                <input type="text"
                       id="firstName"
                       name="firstName"
                       value="<c:out value='${person.firstName}'/>"
                       maxlength="100"
                       required>
            </div>

            <div class="form-field">
                <label for="lastName">Фамилия</label>
                <input type="text"
                       id="lastName"
                       name="lastName"
                       value="<c:out value='${person.lastName}'/>"
                       maxlength="100"
                       required>
            </div>

            <div class="form-field">
                <label for="birthDate">Дата рождения</label>
                <input type="date"
                       id="birthDate"
                       name="birthDate"
                       value="${person.birthDate}">
            </div>

            <div class="form-field">
                <label for="deathDate">Дата смерти</label>
                <input type="date"
                       id="deathDate"
                       name="deathDate"
                       value="${person.deathDate}">
            </div>

            <div class="form-field full-width">
                <label for="description">Описание</label>
                <textarea id="description"
                          name="description"
                          rows="4"
                          maxlength="2000"><c:out value="${person.description}"/></textarea>
            </div>

        </div>

        <div class="form-actions">
            <button type="submit">Сохранить изменения</button>

            <a class="secondary-button"
               href="${pageContext.request.contextPath}/persons">
                Отмена
            </a>
        </div>

    </form>

</div>

</body>
</html>