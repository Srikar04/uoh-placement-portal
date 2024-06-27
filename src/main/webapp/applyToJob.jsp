<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="homeStyles.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <title>UoH Placement Portal</title>
    <link rel="icon" href="images/uohyd_bg.png" type="image/x-icon">
</head>
<body class="bg-gray-200">
<div class="container mx-auto">
    <jsp:include page="header.jsp"/>
    <jsp:include page="studentSideBar.jsp"/>
    <div id="toast-success" class="hidden fixed top-5 right-5 z-50 flex items-center w-full max-w-xs p-4 mb-4 text-gray-500 bg-white rounded-lg shadow dark:text-gray-400 dark:bg-gray-800" role="alert">
        <div class="inline-flex items-center justify-center flex-shrink-0 w-8 h-8 text-green-500 bg-green-100 rounded-lg dark:bg-green-800 dark:text-green-200">
            <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 20">
                <path d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5Zm3.707 8.207-4 4a1 1 0 0 1-1.414 0l-2-2a1 1 0 0 1 1.414-1.414L9 10.586l3.293-3.293a1 1 0 0 1 1.414 1.414Z"/>
            </svg>
            <span class="sr-only">Check icon</span>
        </div>
        <div class="ms-3 text-sm font-normal">Applied Successfully.</div>
        <button type="button" class="ms-auto -mx-1.5 -my-1.5 bg-white text-gray-400 hover:text-gray-900 rounded-lg focus:ring-2 focus:ring-gray-300 p-1.5 hover:bg-gray-100 inline-flex items-center justify-center h-8 w-8 dark:text-gray-500 dark:hover:text-white dark:bg-gray-800 dark:hover:bg-gray-700" data-dismiss-target="#toast-success" aria-label="Close">
            <span class="sr-only">Close</span>
            <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
            </svg>
        </button>
    </div>
    <div id="toast-danger" class="hidden fixed top-5 right-5 z-50 flex items-center w-full max-w-xs p-4 mb-4 text-gray-500 bg-white rounded-lg shadow dark:text-gray-400 dark:bg-gray-800" role="alert">
        <div class="inline-flex items-center justify-center flex-shrink-0 w-8 h-8 text-red-500 bg-red-100 rounded-lg dark:bg-red-800 dark:text-red-200">
            <svg class="w-5 h-5" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 20">
                <path d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5Zm3.707 11.793a1 1 0 1 1-1.414 1.414L10 11.414l-2.293 2.293a1 1 0 0 1-1.414-1.414L8.586 10 6.293 7.707a1 1 0 0 1 1.414-1.414L10 8.586l2.293-2.293a1 1 0 0 1 1.414 1.414L11.414 10l2.293 2.293Z"/>
            </svg>
            <span class="sr-only">Error icon</span>
        </div>
        <div class="ms-3 text-sm font-normal">Some error has occurred.</div>
        <button type="button" class="ms-auto -mx-1.5 -my-1.5 bg-white text-gray-400 hover:text-gray-900 rounded-lg focus:ring-2 focus:ring-gray-300 p-1.5 hover:bg-gray-100 inline-flex items-center justify-center h-8 w-8 dark:text-gray-500 dark:hover:text-white dark:bg-gray-800 dark:hover:bg-gray-700" data-dismiss-target="#toast-danger" aria-label="Close">
            <span class="sr-only">Close</span>
            <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
            </svg>
        </button>
    </div>
    <div class="p-4 sm:ml-64">
        <div class="p-4 rounded-lg  mt-14">
            <h1 class="text-3xl font-semibold mb-6 pt-3">Apply for Job</h1>
            <div id="jobDetails" class="mb-6">
                <!-- Job details will be dynamically added here -->
            </div>

            <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="file_input">Upload file</label>
            <input class="block w-full text-sm text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400" aria-describedby="file_input_help" id="file_input" type="file">
            <p class="mt-1 text-sm text-gray-500 dark:text-gray-300" id="file_input_help">PDF( MAX SIZE 5mb).</p>

            <br>

        <%--            <div class="mb-4">--%>
<%--                <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white" for="resume">Upload Resume/CV</label>--%>
<%--                <div class="flex justify-center items-center w-full">--%>
<%--                    <label for="resume" class="flex flex-col justify-center items-center w-full bg-gray-50 rounded-lg border-2 border-gray-300 border-dashed cursor-pointer dark:hover:bg-bray-800 dark:bg-gray-700 hover:bg-gray-100 dark:border-gray-600 dark:hover:border-gray-500 dark:hover:bg-gray-600">--%>
<%--                        <div class="flex flex-col justify-center items-center pt-5 pb-6">--%>
<%--                            <svg aria-hidden="true" class="mb-3 w-10 h-10 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"></path></svg>--%>
<%--                            <p class="mb-2 text-sm text-gray-500 dark:text-gray-400"><span class="font-semibold">Click to upload</span> or drag and drop</p>--%>
<%--                            <p class="text-xs text-gray-500 dark:text-gray-400">PDF, DOC or DOCX (MAX. 2MB)</p>--%>
<%--                        </div>--%>
<%--                        <input id="resume" type="file" class="hidden" />--%>
<%--                    </label>--%>
<%--                    <span id="selectedFileName"></span>--%>
<%--                </div>--%>
<%--            </div>--%>
            <div class="flex items-start mb-6">
                <div class="flex items-center h-5">
                    <input id="selfDeclaration" type="checkbox" value="" class="w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-blue-300 dark:bg-gray-700 dark:border-gray-600 dark:focus:ring-blue-600 dark:ring-offset-gray-800 dark:focus:ring-offset-gray-800" required>
                </div>
                <label for="selfDeclaration" class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-300">I hereby declare that all the information provided by me in this application is true and accurate to the best of my knowledge. I understand that any false or misleading information may result in the rejection of my application or termination of employment.</label>
            </div>
            <div class="flex items-start mb-6">
                <div class="flex items-center h-5">
                    <input id="updateProfile" type="checkbox" value="" class="w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-blue-300 dark:bg-gray-700 dark:border-gray-600 dark:focus:ring-blue-600 dark:ring-offset-gray-800 dark:focus:ring-offset-gray-800" required>
                </div>
                <label for="updateProfile" class="ml-2 text-sm font-medium text-gray-900 dark:text-gray-300">I have read and understood the privacy policy of this portal and consent to the processing of my personal data for the purpose of job applications and placement activities.</label>
            </div>
            <div id="errorContainer" class="hidden flex items-center p-4 mb-4 text-sm text-red-800 rounded-lg bg-red-50 dark:bg-gray-800 dark:text-red-400" role="alert">
                <svg class="flex-shrink-0 inline w-4 h-4 me-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z"/>
                </svg>
                <span class="sr-only">Info</span>
                <div>
                    <div id="errorMessages">
                    </div>
                </div>
            </div>
            <button type="button" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800" onclick="showConfirmationDialog()">Apply</button>
        </div>
    </div>
</div>

<script>

    // Get the job data from the Apply Now button's data-job attribute
    const jobData = JSON.parse(decodeURIComponent(getUrlParameter('jobData')));

    $(document).ready(function() {

        $('#resume').on('change', function() {
            const selectedFile = $(this).val().split('\\').pop(); // Get file name
            $('#selectedFileName').text(selectedFile); // Assuming you have an element with id="selectedFileName"
        });

        var jobDetailsHtml = '<div class="grid grid-cols-1 md:grid-cols-2 gap-4">' +
            '<div class="bg-gray-100 p-4 rounded-lg">' +
            '<h2 class="text-lg font-semibold mb-2">Organization</h2>' +
            '<p>' + jobData.OrgName + '</p>' +
            '<p class="mt-2">' + jobData.OrgDesc + '</p>' +
            '</div>' +
            '<div class="bg-gray-100 p-4 rounded-lg">' +
            '<h2 class="text-lg font-semibold mb-2">Job Details</h2>' +
            '<p><span class="font-bold">Job Name:</span> ' + jobData.JobName + '</p>' +
            '<p class="mt-2">' + jobData.JobDesc + '</p>' +
            '</div>' +
            '<div class="bg-gray-100 p-4 rounded-lg">' +
            '<h2 class="text-lg font-semibold mb-2">Qualification</h2>' +
            '<p>' + jobData.Qualification + '</p>' +
            '</div>' +
            '<div class="bg-gray-100 p-4 rounded-lg">' +
            '<h2 class="text-lg font-semibold mb-2">Job Location</h2>' +
            '<p>' + jobData.JobLocation + '</p>' +
            '</div>' +
            '<div class="bg-gray-100 p-4 rounded-lg">' +
            '<h2 class="text-lg font-semibold mb-2">Number of Openings</h2>' +
            '<p>' + jobData.NumberOfOpenings + '</p>' +
            '</div>' +
            '<div class="bg-gray-100 p-4 rounded-lg">' +
            '<h2 class="text-lg font-semibold mb-2">Skills Required</h2>' +
            '<p>' + jobData.SkillsRequired + '</p>' +
            '</div>' +
            '<div class="bg-gray-100 p-4 rounded-lg">' +
            '<h2 class="text-lg font-semibold mb-2">Last Date to Apply</h2>' +
            '<p>' + jobData.LastDateToApply + '</p>' +
            '</div>' +
            '<div class="bg-gray-100 p-4 rounded-lg">' +
            '<h2 class="text-lg font-semibold mb-2">Graduation Year</h2>' +
            '<p>' + jobData.GraduationYear + '</p>' +
            '</div>';

        // Append the job details HTML to the container
        $('#jobDetails').html(jobDetailsHtml);

    });

    function getUrlParameter(name) {
        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
        var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
        var results = regex.exec(window.location.search);
        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    }

    function showConfirmationDialog() {
        if(!validateAndSubmit()){
            $('#errorContainer').removeClass('hidden');
            return;
        }
        $('#errorMessagesContainer').addClass('hidden');
        var content = 'Are you sure you want to apply? This cannot be reversed, and if you want, please update your profile from the Profile Section.';
        var buttons = '<button type="button" class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded mr-2" onclick="closeDialog()">Cancel</button>' +
            '<button type="button" class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded" onclick="submitApplication()">Confirm</button>';

        showUniversalDialog(content, buttons);
    }

    function closeDialog() {
        $('#universalDialog').addClass('hidden');
    }

    function validateAndSubmit() {
        const fileInput = document.getElementById('file_input');
        const file = fileInput.files[0];
        const selfDeclaration = document.getElementById('selfDeclaration');
        const updateProfile = document.getElementById('updateProfile');

        if (!file) {
            $('#errorMessages').html('Please select a file to upload.');
            return false;
        }
        if (!selfDeclaration.checked) {
            $('#errorMessages').html('Please agree to the self-declaration.');
            return false;
        }
        if (!updateProfile.checked) {
            $('#errorMessages').html('Please agree to the privacy policy.');
            return false;
        }

        $('#errorMessages').html('');
        return true;
    }

    function submitApplication() {
        // Get the job ID from the jobData object
        const jobId = jobData.JobID;

        // Get the selected file from the new input element
        const fileInput = document.getElementById('file_input'); // Use the new ID
        const file = fileInput.files[0];

        // Create a FormData object to send the data
        const formData = new FormData();
        formData.append('jobId', jobId); // Add job ID to FormData
        formData.append('resume', file); // Use the same key 'resume'

        $.ajax({
            url: 'uploadApplication',
            method: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
                // Handle the success response (e.g., show a success message)
                console.log('Application submitted successfully:', response);
                closeDialog();
                $('#toast-success').removeClass('hidden');
                setTimeout(function() {
                    window.location.href = "studentHome.jsp";
                }, 2000);
            },
            error: function(error) {
                // Handle the error (e.g., show an error message)
                console.error('Error submitting application:', error);
                closeDialog();
                $('#toast-danger').removeClass('hidden');
            }
        });
    }

</script>
</body>
</html>