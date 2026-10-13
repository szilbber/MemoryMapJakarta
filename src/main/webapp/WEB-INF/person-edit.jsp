
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Редактирование человека — MemoryMap</title>
</head>
<body>

<h1>Редактирование человека</h1>

<form action="${pageContext.request.contextPath}/persons" method="post">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="id" value="${person.id}">

    <p>
        <label>Имя:</label>
        <input type="text" name="firstName"
               value="<c:out value='${person.firstName}'/>"
               required maxlength="100">
    </p>

    <p>
        <label>Фамилия:</label>
        <input type="text" name="lastName"
               value="<c:out value='${person.lastName}'/>"
               required maxlength="100">
    </p>

    <p>
        <label>Дата рождения:</label>
        <input type="date" name="birthDate" value="${person.birthDate}">
    </p>

    <p>
        <label>Дата смерти:</label>
        <input type="date" name="deathDate" value="${person.deathDate}">
    </p>

    <p>
        <label>Описание:</label>
        <textarea name="description"><c:out value="${person.description}"/></textarea>
    </p>

    <button type="submit">Сохранить изменения</button>
</form>

<p>
    <a href="${pageContext.request.contextPath}/persons">Назад к списку</a>
</p>

</body>
</html>
