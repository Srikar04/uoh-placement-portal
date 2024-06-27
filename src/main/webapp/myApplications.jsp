<%--
  Created by IntelliJ IDEA.
  User: srikar
  Date: 04/04/24
  Time: 3:38 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>UoH Placement Portal</title>
    <link rel="icon" href="images/uohyd_bg.png" type="image/x-icon">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body onload="fetchApplications()" class="bg-gradient-to-br from-white to-gray-600">
<jsp:include page="header.jsp"/>
<jsp:include page="studentSideBar.jsp"/>
<div class="p-4 sm:ml-64">
    <div class="p-4 mt-14">
        <h2 class="text-2xl font-bold mb-4 ">Your Applications</h2>
        <div class="relative overflow-x-auto shadow-md sm:rounded-lg">
            <table id="applicationsTable" class="w-full text-base text-left text-gray-500 dark:text-gray-400">
                <thead class="text-sm text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                <tr>
                    <th scope="col" class="px-6 py-3">Job Name</th>
                    <th scope="col" class="px-6 py-3">Org Name</th>
                    <th scope="col" class="px-6 py-3">Status</th>
                    <th scope="col" class="px-6 py-3">Applied On</th>
                    <th scope="col" class="px-6 py-3">Action</th>
                </tr>
                </thead>
                <tbody class="odd:bg-gray-100 dark:odd:bg-gray-700 even:bg-white dark:even:bg-gray-800">
                <!-- Rows will be dynamically added here -->
                </tbody>
            </table>
        </div>
    </div>
</div>
<script>
    $(document).ready(function() {
        fetchApplications();
    })

    function fetchApplications() {
        $.ajax({
            url: "fetchApplication",
            type: "GET",
            success: function (response) {
                const applicationsTable = $("#applicationsTable");
                const tableBody = applicationsTable.find("tbody");

                tableBody.empty();

                // Add new rows
                for (const application of response.applications) {
                    const row = $("<tr>").addClass("bg-white border-b dark:bg-gray-800 dark:border-gray-700");
                    const jobNameCell = $("<th>").addClass("px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white").text(application.JobDetails.JobName);
                    const orgNameCell = $("<td>").addClass("px-6 py-4").text(application.JobDetails.OrgName);

                    let statusBadge;
                    switch (application.Status) {
                        case "Selected":
                            statusBadge = $("<span>").addClass("inline-flex items-center bg-green-100 text-green-800 text-base font-medium px-2.5 py-0.5 rounded-full dark:bg-green-900 dark:text-green-300").text("Selected");
                            break;
                        case "Rejected":
                            statusBadge = $("<span>").addClass("inline-flex items-center bg-red-100 text-red-800 text-base font-medium px-2.5 py-0.5 rounded-full dark:bg-red-900 dark:text-red-300").text("Rejected");
                            break;
                        case "In Progress":
                            statusBadge = $("<span>").addClass("inline-flex items-center bg-yellow-100 text-yellow-800 text-base font-medium px-2.5 py-0.5 rounded-full dark:bg-yellow-900 dark:text-yellow-300").text("In Progress");
                            break;
                        case "Accepted":
                            statusBadge = $("<span>").addClass("inline-flex items-center bg-purple-100 text-purple-800 text-base font-medium px-2.5 py-0.5 rounded-full dark:bg-purple-900 dark:text-purple-300").text("Accepted");
                            break;
                        default:
                            statusBadge = $("<td>").addClass("px-6 py-4").text(application.Status);
                    }

                    const statusCell = $("<td>").addClass("px-6 py-4").append(statusBadge);
                    const appliedOnCell = $("<td>").addClass("px-6 py-4").text(application.AppliedOn);

                    let actionButton;
                    if (application.Status === "Rejected" || application.Status === "In Progress") {
                        actionButton = $("<button>").addClass("bg-gradient-to-br from-pink-500 to-orange-400 hover:bg-gradient-to-bl focus:ring-4 focus:outline-none focus:ring-pink-200 text-white font-bold py-2 px-2 rounded")
                            .text("Download Resume")
                            .click(function() {
                                downloadResume(application.URL);
                            });
                    } else if (application.Status === "Selected") {
                        actionButton = $("<button>").addClass("bg-gradient-to-br from-green-400 to-blue-600 hover:bg-gradient-to-bl focus:ring-4 focus:outline-none focus:ring-green-200 text-white font-bold py-2 px-2 rounded")
                            .text("Upload Offer Letter")
                            .click(function() {
                                uploadOfferLetter(application.JobDetails.JobID);
                            });
                    } else {
                        actionButton = $("<button>").addClass("bg-gradient-to-r from-purple-500 to-pink-500 hover:bg-gradient-to-l focus:ring-4 focus:outline-none focus:ring-purple-200 text-white font-bold py-2 px-2 rounded")
                            .text("Download Offer Letter")
                            .attr("data-application-id", application.ApplicationID) // Add this line
                            .click(function() {
                                downloadOfferLetter($(this).data("application-id")); // Modify this line
                            });
                    }


                    const actionCell = $("<td>").addClass("px-2 py-2").append(actionButton);
                    row.append(jobNameCell, orgNameCell, statusCell, appliedOnCell, actionCell);
                    tableBody.append(row);
                }
            },
            error: function (xhr, status, error) {
                console.error("Error fetching applications:", error);
            }
        });
    }

    function downloadResume(fileURL) {
        $.ajax({
            url: "downloadResume",
            type: "GET",
            data: { fileURL: fileURL },
            xhrFields: {
                responseType: 'blob'
            },
            success: function (response) {
                console.log(response);
                const url = window.URL.createObjectURL(response);
                const link = document.createElement('a');
                link.href = url;
                link.setAttribute('download', 'file.pdf');
                document.body.appendChild(link);
                link.click();
                console.log("Resume downloaded successfully.");
            },
            error: function (xhr, status, error) {
                console.error("Error downloading resume:", error);
            }
        });
    }

    function uploadOfferLetter(jobId) {
        const fileInput = document.createElement('input');
        fileInput.type = 'file';
        fileInput.accept = '.pdf';

        fileInput.onchange = function () {
            const file = this.files[0];
            const formData = new FormData();
            formData.append('offerLetter', file);
            formData.append('jobId', jobId);

            $.ajax({
                url: 'uploadOfferLetter',
                method: 'POST',
                data: formData,
                contentType: false,
                processData: false,
                success: function (response) {
                    alert(response);
                },
                error: function (error) {
                    console.error("Error uploading offer letter:", error);
                    alert("Error uploading offer letter. Please try again.");
                }
            });
        };
    }
</script>
</body>
</html>