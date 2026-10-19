<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>MemoryMap — Место захоронения</title>

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

        input:not([type="checkbox"]),
        select,
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font: inherit;
            background: white;
        }

        input:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: #245b8f;
        }

        textarea {
            resize: vertical;
        }

        .checkbox-field {
            display: flex;
            align-items: center;
            gap: 9px;
            min-height: 42px;
        }

        .checkbox-field input {
            width: auto;
            accent-color: #245b8f;
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

        .form-actions {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 12px;
            margin-top: 22px;
        }

        .secondary-button {
            background: #eaf1f8;
            color: #245b8f;
        }

        .secondary-button:hover {
            background: #d8e5f2;
        }

        .error-message {
            padding: 12px 16px;
            margin-bottom: 20px;
            border: 1px solid #e5a5a5;
            border-radius: 6px;
            background: #fff0f0;
            color: #922d2d;
        }

        .hint {
            color: #777;
            font-size: 13px;
            margin: 0;
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

<h1>
    <c:choose>
        <c:when test="${not empty location}">
            Редактирование места захоронения
        </c:when>
        <c:otherwise>
            Добавление места захоронения
        </c:otherwise>
    </c:choose>
</h1>

<div class="navigation">
    <a href="${pageContext.request.contextPath}/">Главная</a>
    <a href="${pageContext.request.contextPath}/persons">Люди</a>
    <a href="${pageContext.request.contextPath}/burial-locations">
        Места захоронений
    </a>
</div>

<div class="card">
    <c:if test="${not empty error}">
        <div class="error-message">
            <c:out value="${error}"/>
        </div>
    </c:if>

    <h2>
        <c:choose>
            <c:when test="${not empty location}">
                Изменение данных
            </c:when>
            <c:otherwise>
                Данные о месте захоронения
            </c:otherwise>
        </c:choose>
    </h2>

    <form method="post"
          action="${pageContext.request.contextPath}/burial-locations">

        <c:choose>
            <c:when test="${not empty location}">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${location.id}">
            </c:when>
            <c:otherwise>
                <input type="hidden" name="action" value="create">
            </c:otherwise>
        </c:choose>

        <div class="form-grid">

            <div class="form-field full-width">
                <label for="personId">Человек</label>

                <select id="personId" name="personId" required>
                    <option value="">Выберите человека</option>

                    <c:forEach var="person" items="${persons}">
                        <option value="${person.id}"
                                <c:if test="${not empty location and location.person.id eq person.id}">
                                    selected
                                </c:if>>
                            <c:out value="${person.firstName}"/>
                            <c:out value="${person.lastName}"/>
                        </option>
                    </c:forEach>
                </select>

                <p class="hint">
                    Выберите человека, с которым связано место захоронения.
                </p>
            </div>

            <div class="form-field">
                <label for="latitude">Широта</label>
                <input type="number"
                       id="latitude"
                       name="latitude"
                       min="-90"
                       max="90"
                       step="any"
                       value="${location.latitude}">
            </div>

            <div class="form-field">
                <label for="longitude">Долгота</label>
                <input type="number"
                       id="longitude"
                       name="longitude"
                       min="-180"
                       max="180"
                       step="any"
                       value="${location.longitude}">
            </div>

            <div class="form-field full-width">
                <label class="checkbox-field">
                    <input type="checkbox"
                           name="exact"
                           value="true"
                    <c:if test="${not empty location and location.exact}">
                           checked
                    </c:if>>
                    Координаты точные
                </label>

                <p class="hint">
                    Если координаты приблизительные, оставьте флажок снятым.
                </p>
            </div>

            <div class="form-field full-width">
                <label for="description">Описание</label>
                <textarea id="description"
                          name="description"
                          rows="4"
                          maxlength="2000"><c:out value="${location.description}"/></textarea>
            </div>

        </div>

        <div class="form-actions">
            <button type="submit">Сохранить</button>

            <a class="secondary-button"
               href="${pageContext.request.contextPath}/burial-locations">
                Отмена
            </a>
        </div>

    </form>
</div>

</body>
</html>