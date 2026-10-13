<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Место захоронения</title>
</head>
<body>

<h1>
    <c:choose>
        <c:when test="${not empty location}">Редактирование места захоронения</c:when>
        <c:otherwise>Добавление места захоронения</c:otherwise>
    </c:choose>
</h1>

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

    <p>
        <label for="personId">Человек:</label>
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
    </p>

    <p>
        <label for="latitude">Широта:</label>
        <input type="number" id="latitude" name="latitude"
               min="-90" max="90" step="any"
               value="${location.latitude}">
    </p>

    <p>
        <label for="longitude">Долгота:</label>
        <input type="number" id="longitude" name="longitude"
               min="-180" max="180" step="any"
               value="${location.longitude}">
    </p>

    <p>
        <label>
            <input type="checkbox" name="exact" value="true"
            <c:if test="${not empty location and location.exact}">
                   checked
            </c:if>>
            Координаты точные
        </label>
    </p>

    <p>
        <label for="description">Описание:</label><br>
        <textarea id="description" name="description"
                  rows="4" cols="40"><c:out value="${location.description}"/></textarea>
    </p>

    <button type="submit">Сохранить</button>

    <a href="${pageContext.request.contextPath}/burial-locations">
        Отмена
    </a>
</form>

</body>
</html>
