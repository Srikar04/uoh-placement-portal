<%--  Created by IntelliJ IDEA.  User: srikar  Date: 29/02/24  Time: 10:40 pm  To change this template use File | Settings | File Templates.--%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="homeStyles.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <title>Home</title>
    <link rel="icon" href="images/uohyd_bg.png" type="image/x-icon">
</head>
<body class="bg-gradient-to-br from-white to-gray-600">
<div class="container mx-auto">
    <jsp:include page="header.jsp"/>
    <jsp:include page="studentSideBar.jsp"/>
    <div class="p-4 sm:ml-64">
        <div class="p-4 mt-14">
            <h1 class="text-3xl font-semibold mb-6 pt-3 ">Job Openings</h1>
            <div id="jobCards" class="flex flex-col space-y-4">
                <!-- Job cards will be dynamically added here -->
            </div>
        </div>
    </div>
</div>
<script>

    $(document).ready(function() {
        fetchJobs();
    });

    function fetchJobs() {
        $.ajax({
            url: 'fetchJobs',
            type: 'GET',
            success: function(response) {
                response.jobs.forEach(function(job) {
                    var cardHtml = '<div class="bg-white border border-gray-200 rounded-lg shadow">' +
                        '<div class="p-6">' +
                        '<p><span class="font-bold">Organization:</span> ' + job.OrgName + '</p>' +
                        '<p><span class="font-bold">Job Name:</span> ' + job.JobName + '</p>' +
                        '<p><span class="font-bold">Qualification:</span> ' + job.Qualification + '</p>' +
                        '<p><span class="font-bold">Number of Openings:</span> ' + job.NumberOfOpenings + '</p>' +
                        '<p><span class="font-bold">Skills Required:</span> ' + job.SkillsRequired + '</p>' +
                        '<p><span class="font-bold">Last Date to Apply:</span> ' + job.LastDateToApply + '</p>' +
                        '<p><span class="font-bold">Graduation Year:</span> ' + job.GraduationYear + '</p>' +
                        '</div>' +
                        '<div class="p-6 border-t border-gray-200">' +
                        '<Button class="applyButton inline-flex items-center px-3 py-2 text-sm font-medium text-center text-white bg-gradient-to-br from-green-400 to-blue-600 hover:bg-gradient-to-bl focus:ring-4 focus:outline-none focus:ring-green-200 dark:focus:ring-green-800 font-medium rounded-lg" onclick="applyToJob(\'' + encodeURIComponent(JSON.stringify(job)) + '\')">' +
                        'Apply Now' +
                        '</Button>' +
                        '</div>' +
                        '</div>';
                    $('#jobCards').append(cardHtml);
                });
            },
            error: function(xhr, status, error) {
                console.error(error);
            }
        });
    }

    function applyToJob(jobData) {
       window.location.href = 'applyToJob.jsp?jobData=' + jobData;
    }
</script>
</body>
</html>