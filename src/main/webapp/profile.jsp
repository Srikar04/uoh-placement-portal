<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Profile</title>
    <link rel="icon" href="images/uohyd_bg.png" type="image/x-icon">
    <!-- Include Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gradient-to-br from-white to-gray-600">

<jsp:include page="header.jsp" />

<jsp:include page="studentSideBar.jsp" />

<div class="max-w-2xl mx-auto bg-white rounded p-6 shadow-md mt-20">
    <h1 class="text-2xl font-semibold mb-4">Student Profile</h1>

    <form id="profileForm" action="${pageContext.request.contextPath}/updateProfile" method="post" class="space-y-4">
        <div>
            <label for="idNumber" class="block text-sm font-medium text-gray-600">ID Number</label>
            <input type="text" id="idNumber" name="idNumber" class="mt-1 p-2 w-full border rounded-md" disabled>
        </div>

        <div>
            <label for="contactNumber" class="block text-sm font-medium text-gray-600">Contact Number</label>
            <input type="text" id="contactNumber" name="contactNumber" class="mt-1 p-2 w-full border rounded-md" disabled>
        </div>

        <div>
            <label for="email" class="block text-sm font-medium text-gray-600">Email</label>
            <input type="email" id="email" name="email" class="mt-1 p-2 w-full border rounded-md" disabled>
        </div>

        <div>
            <label for="school" class="block text-sm font-medium text-gray-600">School</label>
            <select id="school" name="school" class="mt-1 p-2 w-full border rounded-md" disabled>
                <!-- Options will be dynamically loaded here -->
            </select>
        </div>

        <div>
            <label for="department" class="block text-sm font-medium text-gray-600">Department</label>
            <select id="department" name="department" class="mt-1 p-2 w-full border rounded-md" disabled>
                <!-- Options will be dynamically loaded here -->
            </select>
        </div>

        <div>
            <label for="gender" class="block text-sm font-medium text-gray-600">Gender</label>
            <select id="gender" name="gender" class="mt-1 p-2 w-full border rounded-md" disabled>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>
        </div>

        <div>
            <label for="averageCGPA" class="block text-sm font-medium text-gray-600">Average CGPA</label>
            <input type="number" id="averageCGPA" name="averageCGPA" class="mt-1 p-2 w-full border rounded-md" disabled>
        </div>

        <div>
            <label for="course" class="block text-sm font-medium text-gray-600">Course</label>
            <input type="text" id="course" name="course" class="mt-1 p-2 w-full border rounded-md" disabled>
        </div>

        <div>
            <label for="startYear" class="block text-sm font-medium text-gray-600">Start Year</label>
            <input type="number" id="startYear" name="startYear" class="mt-1 p-2 w-full border rounded-md" disabled>
        </div>

        <div>
            <label for="endYear" class="block text-sm font-medium text-gray-600">End Year</label>
            <input type="number" id="endYear" name="endYear" class="mt-1 p-2 w-full border rounded-md" disabled>
        </div>

        <div>
            <button type="button" id="updateProfileBtn" class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600">Update Profile</button>
        </div>
    </form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function() {

        fetchAllSchools();

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

        fetchAllDepartments();

        function fetchAllDepartments() {
            $.ajax({
                url: 'fetchAllDepartments',
                method: 'GET',
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

        fetchStudentInfo(); // Fetch student data on page load

        // Function to fetch student information via AJAX
        function fetchStudentInfo() {
            $.ajax({
                url: 'fetchStudentInfo', // Endpoint to fetch student data
                method: 'POST',
                success: function(response) {
                    // Update form fields based on response
                    console.log(response);
                    let studentInfo = response.studentInfo[0]; // Assuming you get an array with one object

                    $("#idNumber").val(studentInfo.StudentID);
                    $("#contactNumber").val(studentInfo.ContactNumber);
                    $("#email").val(studentInfo.Email);

                    $("#department option").each(function() {
                        if ($(this).val() === studentInfo.DepartmentName) { // Assuming DepartmentName is the value
                            $(this).prop("selected", true);
                            return false; // Stop iterating once found
                        }
                    });

                    $("#school option").each(function() {
                        if ($(this).val() === studentInfo.SchoolName) { // Assuming SchoolName is the value
                            $(this).prop("selected", true);
                            return false; // Stop iterating once found
                        }
                    });

                    $("#gender option").each(function() {
                        if ($(this).val() === studentInfo.Gender) {
                            $(this).prop("selected", true);
                            return false; // Stop iterating once found
                        }
                    });
                    $("#averageCGPA").val(studentInfo.AverageCGPA);
                    $("#course").val(studentInfo.Course);
                    $("#startYear").val(studentInfo.StartYear);
                    $("#endYear").val(studentInfo.EndYear);
                },
                error: function(error) {
                    // Handle the error as needed
                    console.error("Error fetching student information:", error);
                }
            });
        }

        // Enable form fields when "Update Profile" button is clicked
        $("#updateProfileBtn").click(function() {
            $("#profileForm input, #profileForm select").prop("disabled", false);
            $("#idNumber, #email").prop("disabled", true);

            // Change button text
            $(this).text("Save Changes");

            // Submit form data on button click
            $(this).off('click').on('click', function() {
                let profileForm = $("#profileForm");
                let formData = profileForm.serialize();

                $.ajax({
                    url: profileForm.attr("action"),
                    method: profileForm.attr("method"),
                    data: formData,
                    success: function(response, textStatus, jqXHR) {
                        let content ="";
                        let buttons= "";
                        if (jqXHR.status === 200) {
                            content = 'Profile updated successfully.';
                        } else {
                            content = 'An Error has occurred. Please try Again.';
                        }
                        buttons = '<button type="button" class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded mr-2" onclick="closeDialog()">Cancel</button>';
                        // showUniversalDialog(content, buttons);
                        window.location.href="profile.jsp"
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert("Error: " + jqXHR.status + " " + errorThrown);
                    }
                });
            });
        });

    });
</script>
</body>
</html>
