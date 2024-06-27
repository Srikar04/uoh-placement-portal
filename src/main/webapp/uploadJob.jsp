<%--
  Created by IntelliJ IDEA.
  User: srikar
  Date: 29/02/24
  Time: 9:13 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Job Details</title>
    <link rel="icon" href="images/uohyd_bg.png" type="image/x-icon">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gradient-to-br from-white to-gray-600">
<jsp:include page="header.jsp"/>
<jsp:include page="charimanSideBar.jsp"/>
<div class="max-w-2xl mx-auto bg-white rounded p-6 shadow-md mt-20">
    <h1 class="text-2xl font-semibold mb-4">Upload Job</h1>
    <form id="jobForm" action="${pageContext.request.contextPath}/uploadJob" method="POST" class="space-y-4">

        <div>
            <label for="organizationName" class="block text-sm font-medium text-gray-600">Organization Name</label>
            <input type="text" id="organizationName" name="organizationName" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="organizationDetails" class="block text-sm font-medium text-gray-600">Organisation Details</label>
            <textarea id="organizationDetails" name="organizationDetails" class="mt-1 p-2 w-full border rounded-md" rows="3"></textarea>
        </div>

        <div>
            <label for="qualificationsRequired" class="block text-sm font-medium text-gray-600">Qualifications Required</label>
            <input type="text" id="qualificationsRequired" name="qualificationsRequired" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="numberOfOpenings" class="block text-sm font-medium text-gray-600" >Number of Openings</label>
            <input type="number" id="numberOfOpenings" name="numberOfOpenings" class="mt-1 p-2 w-full border rounded-md" min="1" >
        </div>

        <div>
            <label for="departments" class="block text-sm font-medium text-gray-600">Select a Department</label>
            <select multiple id="departments"  name="departments" class="mt-1 p-2 w-full border rounded-md h-40">
                <!-- Options will be dynamically loaded here -->
            </select>
        </div>

<%--        <div>--%>
<%--            <label for="departments" class="block text-sm font-medium text-gray-600">Select a Department</label>--%>
<%--            <div id="departments" class="mt-1 p-2 w-full border rounded-md h-40 overflow-y-auto">--%>
<%--                <!-- Options will be dynamically loaded here -->--%>
<%--            </div>--%>
<%--        </div>--%>

        <div>
            <label for="jobDesignation" class="block text-sm font-medium text-gray-600">Job Designation</label>
            <input type="text" id="jobDesignation" name="jobDesignation" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="jobDescription" class="block text-sm font-medium text-gray-600">Job Description</label>
            <textarea id="jobDescription" name="jobDescription" class="mt-1 p-2 w-full border rounded-md" rows="3"></textarea>
        </div>

        <div>
            <label for="jobLocation" class="block text-sm font-medium text-gray-600">Job Location</label>
            <input type="text" id="jobLocation" name="jobLocation" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="skillsRequired" class="block text-sm font-medium text-gray-600">Skills Required</label>
            <input type="text" id="skillsRequired" name="skillsRequired" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="lastDateToApply" class="block text-sm font-medium text-gray-600">Last Date to Apply</label>
            <input type="date" id="lastDateToApply" name="lastDateToApply" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <label for="graduationYear" class="block text-sm font-medium text-gray-600">Graduation Year</label>
            <input type="number" id="graduationYear" name="graduationYear" class="mt-1 p-2 w-full border rounded-md">
        </div>

        <div>
            <button type="button"  id="submitBtn" class="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600">Submit</button>
        </div>
    </form>
</div>

<script>
    $(document).ready(function() {

        $("#submitBtn").click(function() {
            if(validateForm())
                submitForm()
        });

        // $.ajax({
        //     url: 'fetchAllDepartments',
        //     method: 'GET',
        //     dataType: 'json',
        //     success: function(response) {
        //         console.log(response);
        //         let departments = response.departments;
        //         let departmentsContainer = $('#departments');
        //         // Clear existing options
        //         departmentsContainer.empty();
        //         // Add options as checkboxes
        //         departments.forEach(function(department) {
        //             let label = $('<label></label>').addClass('flex items-center');
        //             let checkbox = $('<input type="checkbox" class="form-checkbox h-4 w-4 text-indigo-600 transition duration-150 ease-in-out mr-2">').attr('value', department.trim());
        //             let span = $('<span></span>').text(department.trim());
        //             label.append(checkbox, span);
        //             departmentsContainer.append(label);
        //         });
        //     },
        //     error: function(jqXHR, textStatus, errorThrown) {
        //         console.error("Error fetching departments:", errorThrown);
        //     }
        // });

        $.ajax({
            url: 'fetchAllDepartments',
            method: 'GET',
            dataType: 'json',
            success: function(response) {
                console.log(response);
                let departments = response.departments;
                let selectElement = $('#departments');

                // Clear existing options
                selectElement.empty();

                // Add options to the select element
                departments.forEach(function(department) {
                    let option = $('<option></option>').attr('value', department.trim()).text(department.trim());
                    selectElement.append(option);
                });
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error("Error fetching departments:", errorThrown);
            }
        });


        // Function to validate the form
        function validateForm() {
            // Your validation logic goes here
            let lastDateToApply = new Date($("#lastDateToApply").val());
            let today = new Date();
            let openings = $("#numberOfOpenings").val();

            if (lastDateToApply <= today) {
                alert("Last Date to Apply must be after Start Date.");
                return false;
            }

            // Validate that Job Location contains only text
            let jobLocation = $("#jobLocation").val();
            if (!/^[a-zA-Z,\s]+$/.test(jobLocation)) {
                alert("Job Location should contain only letters and spaces.");
                return false;
            }

            if(!/^[0-9]+$/.test(openings)){
                alert("Number of openings should be only numbers.");
                return false;
            }

            return true;
        }

        // Function to submit the form using AJAX
        function submitForm() {
            let jobForm =  $("#jobForm");
            let formData = jobForm.serialize();
            $.ajax({
                url: jobForm.attr("action"),
                method: jobForm.attr("method"),
                data : formData,
                success: function(response) {
                    // Handle the success response as needed
                    alert("Job Posted Successfully");
                    window.location.href="uploadJob.jsp";
                },
                error: function(error) {
                    // Handle the error as needed
                    alert("Some error has Occurred. Please try again.");
                }
            });
        }
    });
</script>

</body>
</html>

