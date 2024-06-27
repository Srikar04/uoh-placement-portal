<%--
  Created by IntelliJ IDEA.
  User: srikar
  Date: 21/03/24
  Time: 9:49 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In</title>
    <link rel="icon" href="images/uohyd_bg.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>


<body class="bg-gradient-to-r from-purple-200 to-green-200">


<jsp:include page="header.jsp" />

<div class="max-w-md mx-auto bg-white rounded-lg shadow-lg p-8 mt-20">
    <h1 class="text-2xl font-bold text-center mb-6">Log Into Your Account</h1>

    <form id="signInForm" action="${pageContext.request.contextPath}/signIn" method="POST" class="space-y-6">
        <div>
            <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
            <input type="text" id="email" name="email" class="mt-1 p-3 w-full border border-gray-300 rounded-md shadow-sm focus:ring focus:ring-indigo-500 focus:border-indigo-500" value="chairmanUoh@uohyd.ac.in">
        </div>

        <div>
            <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
            <input type="password" id="password" name="password" class="mt-1 p-3 w-full border border-gray-300 rounded-md shadow-sm focus:ring focus:ring-indigo-500 focus:border-indigo-500" value="123">
        </div>

        <div>
            <label for="userType" class="block text-sm font-medium text-gray-700">User Type</label>
            <select id="userType" name="userType" class="mt-1 p-3 w-full border border-gray-300 rounded-md shadow-sm focus:ring focus:ring-indigo-500 focus:border-indigo-500">
                <option value="Chairman">Chairman</option>

                <option value="Student">Student</option>
                <option value="Coordinator">Coordinator</option>
                <option value="TPO">TPO</option>
            </select>
        </div>

        <div class="flex items-center justify-between">
            <button type="button" id="submitBtn" class="bg-indigo-600 text-white font-medium py-2 px-4 rounded-md shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                Sign In
            </button>

            <a href="SignUp.jsp" class="text-sm text-indigo-600 hover:text-indigo-700 hover:underline">
                Don't have an account? Sign Up
            </a>
        </div>
    </form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function() {

        $("#submitBtn").click(function() {
            if(validateForm())
                submitForm()
        });

        function validateForm() {
            let email = $("#email").val().trim();
            let password = $("#password").val().trim();

            if (email === "" || password === "") {
                alert("Email and password are required");
                return false;
            }

            return true;
        }

        function submitForm() {
            let signInForm = $("#signInForm");
            let formData = signInForm.serialize(); // Serialize form data

            $.ajax({
                url: signInForm.attr("action"),
                method: signInForm.attr("method"),
                data: formData,
                success: function (response) {
                    if (response.trim() === "Success") {
                        let userType = $("#userType").val().trim();
                        switch (userType) {
                            case "Student":
                                window.location.href = "studentHome.jsp";
                                break;
                            case "Coordinator":
                                window.location.href = "coordinatorHome.jsp";
                                break;
                            case "TPO":
                                window.location.href = "uploadJob.jsp";
                                break;
                            case "Chairman":
                                window.location.href = "uploadJob.jsp";
                                break;
                            default:
                                alert("Invalid user type");
                                break;
                        }
                    } else {
                        // Handle incorrect username or password
                        alert(response);
                    }
                },
                error: function (error) {
                    // Handle the error as needed
                    alert("Some error has occurred. Please try again.");
                }
            });
        }
    });
</script>

</body>
</html>
