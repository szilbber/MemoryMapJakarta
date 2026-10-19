<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>MemoryMap — Главная</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 900px;
            margin: 60px auto;
            padding: 0 20px;
            color: #333;
            background-color: #f5f7fa;
        }

        h1 {
            text-align: center;
            margin-bottom: 10px;
        }

        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 40px;
        }

        .menu {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .card {
            box-sizing: border-box;
            display: block;
            width: 300px;
            padding: 30px 25px;
            background: white;
            border: 1px solid #ddd;
            border-radius: 12px;
            text-decoration: none;
            color: inherit;
            transition: box-shadow 0.2s, transform 0.2s;
        }

        .card:hover {
            box-shadow: 0 5px 18px rgba(0, 0, 0, 0.1);
            transform: translateY(-3px);
        }

        .card h2 {
            margin-top: 0;
            color: #245b8f;
        }

        .card p {
            line-height: 1.5;
            color: #666;
        }
    </style>
</head>
<body>

<h1>MemoryMap</h1>

<p class="subtitle">
    Приложение для хранения информации о людях и местах их захоронения
</p>

<div class="menu">
    <a class="card" href="${pageContext.request.contextPath}/persons">
        <h2>Люди</h2>
        <p>
            Просмотр, добавление, редактирование и удаление
            информации о людях.
        </p>
    </a>

    <a class="card" href="${pageContext.request.contextPath}/burial-locations">
        <h2>Места захоронения</h2>
        <p>
            Просмотр и управление местами захоронения,
            координатами и описаниями.
        </p>
    </a>
</div>

</body>
</html>