<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String roomId = request.getParameter("roomId");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Réservation</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">

<div class="max-w-xl mx-auto mt-20 bg-white p-8 rounded shadow">
    <h2 class="text-2xl font-bold text-center mb-6">Choisissez vos dates</h2>

    <form action="bookRoom" method="get" class="space-y-4">
        <input type="hidden" name="roomId" value="<%= roomId %>" />

        <div>
            <label class="block mb-1 text-gray-700">Date d'arrivée :</label>
            <input type="date" name="checkInDate" required class="w-full border px-4 py-2 rounded" />
        </div>

        <div>
            <label class="block mb-1 text-gray-700">Date de départ :</label>
            <input type="date" name="checkOutDate" required class="w-full border px-4 py-2 rounded" />
        </div>

        <div class="text-center">
            <button type="submit" class="bg-yellow-500 hover:bg-yellow-600 text-white px-6 py-2 rounded">
                Réserver maintenant
            </button>
        </div>
    </form>
</div>

</body>
</html>
