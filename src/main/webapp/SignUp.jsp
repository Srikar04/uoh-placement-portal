<%--
  Created by IntelliJ IDEA.
  User: srikar
  Date: 14/03/24
  Time: 9:47 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Sign Up</title>
    <link rel="icon" href="images/uohyd_bg.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gradient-to-r from-teal-200 to-lime-200">

<jsp:include page="header.jsp" />

<div class="max-w-2xl mx-auto bg-white rounded p-6 shadow-md mt-20">

    <h1 class="text-2xl font-semibold mb-4">Student Sign Up Form</h1>

    <form id="signupForm" action="${pageContext.request.contextPath}/signUp" method="POST" class="space-y-4">

        <div>
            <label for="idNumber" class="block text-sm font-medium text-gray-600">ID Number</label>
            <input type="text" id="idNumber" name="idNumber" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="contactNumber" class="block text-sm font-medium text-gray-600">Contact Number</label>
            <input type="text" id="contactNumber" name="contactNumber" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="email" class="block text-sm font-medium text-gray-600">Email</label>
            <input type="email" id="email" name="email" class="mt-1 p-2 w-full border rounded-md">
        </div>


        <div>
            <label for="school" class="block text-sm font-medium text-gray-600">School</label>
            <select id="school" name="school" class="mt-1 p-2 w-full border rounded-md">
                <!-- Options will be dynamically loaded here -->
            </select>
        </div>


        <div>
            <label for="department" class="block text-sm font-medium text-gray-600">Department</label>
            <select id="department" name="department" class="mt-1 p-2 w-full border rounded-md">
                <!-- Options will be dynamically loaded here -->
            </select>
        </div>

        <div>
            <label for="gender" class="block text-sm font-medium text-gray-600">Gender</label>
            <select id="gender" name="gender" class="mt-1 p-2 w-full border rounded-md">
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>
        </div>

        <div>
            <label for="averageCGPA" class="block text-sm font-medium text-gray-600">Average CGPA</label>
            <input type="number" id="averageCGPA" name="averageCGPA" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="course" class="block text-sm font-medium text-gray-600">Course</label>
            <input type="text" id="course" name="course" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="startYear" class="block text-sm font-medium text-gray-600">Start Year</label>
            <input type="number" id="startYear" name="startYear" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="endYear" class="block text-sm font-medium text-gray-600">End Year</label>
            <input type="number" id="endYear" name="endYear" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="password" class="block text-sm font-medium text-gray-600">Password</label>
            <input type="password" id="password" name="password" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="confirmPassword" class="block text-sm font-medium text-gray-600">Confirm Password</label>
            <input type="password" id="confirmPassword" name="confirmPassword" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <button type="button" id="submitBtn" class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600">Submit</button>
        </div>
    </form>
</div>

</body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function() {

        fetchAllSchools();

        // Function to fetch all schools via AJAX
        function fetchAllSchools() {
            $.ajax({
                url: 'fetchSchool', // Endpoint to fetch all schools
                method: 'GET',
                success: function(response) {
                    // Update school options based on response
                    let schools = response.schools;
                    let selectElement = document.getElementById('school');
                    selectElement.innerHTML = ''; // Clear existing options
                    schools.forEach(function(school) {
                        let option = document.createElement('option');
                        option.value = school.trim(); // Trim to remove leading/trailing spaces
                        option.text = school.trim();
                        selectElement.add(option);
                    });
                },
                error: function(error) {
                    // Handle the error as needed
                    console.error("Error fetching schools:", error);
                }
            });
        }

        $('#school').change(function() {
            let selectedSchool = $(this).val().trim(); // Get the selected school
            fetchDepartmentFields(selectedSchool); // Fetch relevant fields for the selected school
        });

        function fetchDepartmentFields(selectedSchool) {
            $.ajax({
                url: 'fetchDepartment',
                method: 'POST',
                data: { schoolName: selectedSchool },
                success: function(response) {

                    let departments = response.departments;
                    let selectElement = document.getElementById('department');
                    selectElement.innerHTML = '';
                    departments.forEach(function(department) {
                        let option = document.createElement('option');
                        option.value = department.trim();
                        option.text = department.trim();
                        selectElement.add(option);
                    });
                },
                error: function(error) {
                    console.error("Error fetching department fields:", error);
                }
            });
        }


        $("#submitBtn").click(function() {
            if(validateForm())
                submitForm()
        });


        // Function to check if a value is a string
        function isString(value) {
            let regex = /^[a-zA-Z\s]+$/;
            return regex.test(value);
        }

        // Function to check if a value is a number
        function isNumber(value) {
            // Regular expression to match floating-point numbers
            let regex = /^[+-]?\d+(\.\d+)?$/;
            return regex.test(value);
        }

        function validateForm() {
            // Get form fields
            let idNumber = $("#idNumber").val().trim();
            let contactNumber = $("#contactNumber").val().trim();
            let email = $("#email").val().trim();
            let averageCGPA = $("#averageCGPA").val();
            let course = $("#course").val().trim();
            let startYear = $("#startYear").val();
            let endYear = $("#endYear").val();
            let passwd = $("#password").val().trim();
            let conPasswd = $("#confirmPassword").val().trim();

            // Your validation logic here
            // For example, you can check if fields are empty or if they meet certain criteria
            if (idNumber === "" || contactNumber === "" || email === "" || averageCGPA === "" || course === "" || startYear === "" || endYear === ""|| passwd === "" || conPasswd === "") {
                alert("All fields are required");
                return false;
            }

            // Perform validation checks
            if (idNumber.length !== 8) {
                alert("ID Number must be 8 alphanumeric characters");
                return false;
            }

            if (!isNumber(contactNumber) || contactNumber.length !== 10) {
                alert("Contact Number must be a 10-digit number");
                return false;
            }

            if (!isNumber(averageCGPA)) {
                alert("Average CGPA must be a valid floating-point number");
                return false;
            }

            if (!isString(course)) {
                alert("Course must be a string");
                return false;
            }

            if (parseInt(startYear) >= parseInt(endYear)) {
                alert("Start year must be less than end year");
                return false;
            }

            if(passwd.length > 20){
                alert("Length of password must not cross 20 characters");
                return false;
            }

            if(passwd !== conPasswd){
                alert("Passwords not Matching");
                return false;
            }

            return true;
        }

        function submitForm() {
            let signupForm = $("#signupForm");
            let formData = signupForm.serialize(); // Serialize form data

            $.ajax({
                url: signupForm.attr("action"),
                method: signupForm.attr("method"),
                data: formData,
                success: function (response) {
                    // Handle the success response as needed
                    alert(response);
                    window.location.href = "SignIn.jsp";
                },
                error: function (error) {
                    // Handle the error as needed
                    alert("Some error has occurred. Please try again.");
                }
            });
        }


    });
</script>
</html>

