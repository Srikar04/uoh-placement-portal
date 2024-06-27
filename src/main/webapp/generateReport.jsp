<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate Reports</title>
    <link rel="icon" href="images/uohyd_bg.png" type="image/x-icon">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="header.jsp"/>
<jsp:include page="charimanSideBar.jsp"/>
<div class="max-w-4xl min-w-3xl mx-80 bg-white rounded p-6 shadow-md mt-20" style="width: 48rem">
    <h1 class="text-2xl font-semibold mb-4">Generate Reports</h1>
    <div class="mb-4">
        <select id="reportOptions" class="font-bold py-2 px-4 rounded">
            <option value="overallOptions">Generate Overall Reports</option>
            <option value="schoolOptions">Generate Reports by School</option>
            <option value="departmentOptions">Generate Reports by Department</option>
            <option value="durationOptions">Generate Reports by Duration</option>
            <option value="yearOptions">Generate Reports by Year</option>
        </select>
    </div>


    <div id="schoolOptions" class="options hidden">
        <form>
            <div class="mb-4">
                <label class="block text-gray-700 font-bold mb-2">
                    Select Schools
                </label>
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <input type="checkbox" id="school1" class="mr-2" value="School of Mathematics & Statistics">
                        <label for="school1">School of Mathematics & Statistics</label>
                    </div>
                    <div>
                        <input type="checkbox" id="school2" class="mr-2" value="School of Physics">
                        <label for="school2">School of Physics</label>
                    </div>
                    <div>
                        <input type="checkbox" id="school3" class="mr-2" value="School of Chemistry">
                        <label for="school3">School of Chemistry</label>
                    </div>
                    <div>
                        <input type="checkbox" id="school4" class="mr-2" value="School of Computer & Information Sciences">
                        <label for="school4">School of Computer & Information Sciences</label>
                    </div>
                    <div>
                        <input type="checkbox" id="school5" class="mr-2" value="School of Life Sciences">
                        <label for="school5">School of Life Sciences</label>
                    </div>
                    <div>
                        <input type="checkbox" id="school6" class="mr-2" value="School of Humanities">
                        <label for="school6">School of Humanities</label>
                    </div>
                    <div>
                        <input type="checkbox" id="school7" class="mr-2" value="School of Social Sciences">
                        <label for="school7">School of Social Sciences</label>
                    </div>
                    <div>
                        <input type="checkbox" id="school8" class="mr-2" value="School of Management Studies">
                        <label for="school8">School of Management Studies</label>
                    </div>
                    <div>
                        <input type="checkbox" id="school9" class="mr-2" value="S N School of Arts & Communication">
                        <label for="school9">S N School of Arts & Communication</label>
                    </div>
                    <div>
                        <input type="checkbox" id="school10" class="mr-2" value="School of Engg. Sciences & Tech">
                        <label for="school10">School of Engg. Sciences & Tech</label>
                    </div>
                    <div>
                        <input type="checkbox" id="school11" class="mr-2" value="School of Economics">
                        <label for="school11">School of Economics</label>
                    </div>
                    <div>
                        <input type="checkbox" id="school12" class="mr-2" value="School of Medical Sciences">
                        <label for="school12">School of Medical Sciences</label>
                    </div>
                    <div>
                        <input type="checkbox" id="school13" class="mr-2" value="Centre for Health Psychology">
                        <label for="school13">Centre for Health Psychology</label>
                    </div>
                    <div>
                        <input type="checkbox" id="school14" class="mr-2" value="Centre for Neural and Cognitive Sciences">
                        <label for="school14">Centre for Neural and Cognitive Sciences</label>
                    </div>
                    <div>
                        <input type="checkbox" id="school15" class="mr-2" value="Centre for Earth and Atmospheric Ocean">
                        <label for="school15">Centre for Earth and Atmospheric Ocean</label>
                    </div>
                </div>
            <br>
            <button type="submit" data-report-type="school" class="generate-report-btn bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
                Generate Report
            </button>
            </div>
        </form>
    </div>

    <div id="departmentOptions" class="options hidden">
        <form>
            <div class="mb-4">
                <label class="block text-gray-700 font-bold mb-2">
                    Select Departments
                </label>
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <input type="checkbox" id="department1" value="Centre for Health Psychology" class="mr-2">
                        <label for="department1">Centre for Health Psychology</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department2" value="Centre for Neural and Cognitive Sciences" class="mr-2">
                        <label for="department2">Centre for Neural and Cognitive Sciences</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department3" value="Department of Optometry" class="mr-2">
                        <label for="department3">Department of Optometry</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department4" value="Department of Public Health" class="mr-2">
                        <label for="department4">Department of Public Health</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department5" value="Department of Biochemistry" class="mr-2">
                        <label for="department5">Department of Biochemistry</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department6" value="Department of Plant Sciences" class="mr-2">
                        <label for="department6">Department of Plant Sciences</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department7" value="Department of Animal Biology" class="mr-2">
                        <label for="department7">Department of Animal Biology</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department8" value="Department of Biotechnology & Bioinformatics" class="mr-2">
                        <label for="department8">Department of Biotechnology & Bioinformatics</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department9" value="Department of Systems & Computational Biology" class="mr-2">
                        <label for="department9">Department of Systems & Computational Biology</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department10" value="School of Mathematics and Statistics" class="mr-2">
                        <label for="department10">School of Mathematics and Statistics</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department11" value="School of Physics" class="mr-2">
                        <label for="department11">School of Physics</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department12" value="Centre for Earth and Atmospheric Ocean" class="mr-2">
                        <label for="department12">Centre for Earth and Atmospheric Ocean</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department13" value="School of Chemistry" class="mr-2">
                        <label for="department13">School of Chemistry</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department14" value="Department of History" class="mr-2">
                        <label for="department14">Department of History</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department15" value="Department of Sociology" class="mr-2">
                        <label for="department15">Department of Sociology</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department16" value="Department of Political Science" class="mr-2">
                        <label for="department16">Department of Political Science</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department17" value="Department of Anthropology" class="mr-2">
                        <label for="department17">Department of Anthropology</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department18" value="Department of Education" class="mr-2">
                        <label for="department18">Department of Education</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department19" value="Department of English" class="mr-2">
                        <label for="department19">Department of English</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department20" value="Department of Philosophy" class="mr-2">
                        <label for="department20">Department of Philosophy</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department21" value="Department of Hindi" class="mr-2">
                        <label for="department21">Department of Hindi</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department22" value="Department of Telugu" class="mr-2">
                        <label for="department22">Department of Telugu</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department23" value="Department of Urdu" class="mr-2">
                        <label for="department23">Department of Urdu</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department24" value="Department of Sanskrit Studies" class="mr-2">
                        <label for="department24">Department of Sanskrit Studies</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department25" value="School of Engineering Sciences and Technology" class="mr-2">
                        <label for="department25">School of Engineering Sciences and Technology</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department26" value="School of Management Studies" class="mr-2">
                        <label for="department26">School of Management Studies</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department27" value="School of Economics" class="mr-2">
                        <label for="department27">School of Economics</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department28" value="Department of Communication" class="mr-2">
                        <label for="department28">Department of Communication</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department29" value="Department of Dance" class="mr-2">
                        <label for="department29">Department of Dance</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department30" value="Department of Fine Arts" class="mr-2">
                        <label for="department30">Department of Fine Arts</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department31" value="Department of Theatre Arts" class="mr-2">
                        <label for="department31">Department of Theatre Arts</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department32" value="Department of Music" class="mr-2">
                        <label for="department32">Department of Music</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department33" value="School of Computer and Information Sciences" class="mr-2">
                        <label for="department33">School of Computer and Information Sciences</label>
                    </div>
                    <div>
                        <input type="checkbox" id="department34" value="School of Engineering Sciences and Technology" class="mr-2">
                        <label for="department34">School of Engineering Sciences and Technology</label>
                    </div>
                </div>
            </div>
            <br>
            <button type="submit" data-report-type="department" class="generate-report-btn bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
                Generate Report
            </button>
        </form>
    </div>

    <div id="durationOptions" class="options hidden">
        <form>
            <div class="mb-4">
                <label class="block text-gray-700 font-bold mb-2">
                    Select Durations
                </label>
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <input type="checkbox" id="duration2" value="2" class="mr-2">
                        <label for="duration2">2 Years</label>
                    </div>
                    <div>
                        <input type="checkbox" id="duration3" value="3" class="mr-2">
                        <label for="duration3">3 Years</label>
                    </div>
                    <div>
                        <input type="checkbox" id="duration4" value="4" class="mr-2">
                        <label for="duration4">4 Years</label>
                    </div>
                    <div>
                        <input type="checkbox" id="duration5" value="5" class="mr-2">
                        <label for="duration5">5 Years</label>
                    </div>
                </div>
            </div>
            <br>
            <button type="submit" data-report-type="duration" class="generate-report-btn bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
                Generate Report
            </button>
        </form>
    </div>

    <div id="yearOptions" class="options hidden">
        <form>
            <div class="mb-4">
                <label class="block text-gray-700 font-bold mb-2" for="year">
                    Select Year
                </label>
                <input type="number" id="year" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" placeholder="Enter Year">
            </div>
            <br>
            <button type="submit" data-report-type="year" class="generate-report-btn bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
                Generate Report
            </button>
        </form>
    </div>

    <div id="overallOptions" class="options">
        <div class="mb-4">
            <button  data-report-type="overall" class="generate-report-btn bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
                Generate Overall Report
            </button>
        </div>
    </div>

    <div id="container">
        <canvas id="barGraph" class="hidden" style="width: 100%; height: 400px;"></canvas>
    </div>
    <div id="reportResults" class="hidden mt-8">
<%--        <div class="flex items-center justify-between mb-4">--%>
<%--            <h2 class="text-xl font-semibold">Report Results</h2>--%>
<%--            <button id="printButton" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">--%>
<%--                Print--%>
<%--            </button>--%>
<%--        </div>--%>
        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                <tr>
                    <th scope="col" class="px-6 py-3 text-center text-base font-medium text-gray-500 uppercase tracking-wider">
                        Statistics
                    </th>
                    <th scope="col" class="px-6 py-3 text-center text-base font-medium text-gray-500 uppercase tracking-wider">
                        CTC
                    </th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200 odd:bg-gray-100 dark:odd:bg-gray-700 even:bg-white dark:even:bg-gray-800">
                <!-- Rows will be added dynamically here -->
                </tbody>
            </table>
        </div>
    </div>

</div>

<script>
    $(document).ready(function() {
        $('#reportOptions').change(function () {
            let selectedOption = $(this).val();
            $('#reportResults').addClass('hidden');
            $('#reportResults tbody').empty();

            showOptions(selectedOption);
            $('#barGraph').remove();
            $('#container').append('<canvas id="barGraph" class="hidden" style="width: 100%; height: 400px;"></canvas>'); // Add a new canvas element with the same id

        });

        $('.generate-report-btn').click(function (event) {
            event.preventDefault();

            const reportType = $(this).data('report-type');
            const checkedBoxes = [];

            if (reportType === 'year') {
                checkedBoxes.push($('#year').val());
            } else {
                let selector = "#" + reportType + "Options input[type=\"checkbox\"]:checked";
                $(selector).each(function () {
                    checkedBoxes.push($(this).attr('value'));
                });
            }

            let url;
            switch (reportType) {
                case 'school':
                    url = 'GenRepSchool';
                    break;
                case 'department':
                    url = 'GenRepDept';
                    break;
                case 'duration':
                    url = 'GenRepDuration';
                    break;
                case 'year':
                    url = 'GenRepYear';
                    break;
                case 'overall':
                    url = 'GenRep';
                    break;
                default:
                    console.error('Invalid report type:', reportType);
                    return; // Exit if invalid report type
            }

            $.ajax({
                url: url,
                method: 'POST',
                data: {
                    selectedItems: checkedBoxes
                },
                success: function(response) {
                    console.log('AJAX request successful:', response);
                    const reportData = response.reportData[0];
                    const tableBody = $('#reportResults tbody');
                    tableBody.empty();

                    for (const key in reportData) {
                        const row = $('<tr>').addClass('bg-white hover:bg-gray-100');
                        const th = $('<th>')
                            .addClass('px-6 py-4 text-base font-medium text-gray-900 text-center')
                            .text(key.toUpperCase()); // Call toUpperCase() on the key string
                        const td = $('<td>').addClass('px-6 py-4 text-base text-gray-500 text-center').text(reportData[key]);
                        row.append(th, td);
                        tableBody.append(row);
                    }

                    createBarGraph(reportData);

                    $('#barGraph').show();


                    $('#reportResults').removeClass('hidden');
                },
                error: function(error) {
                    console.error('AJAX request failed:', error);
                }
            });

        });
    });

    function createBarGraph(data) {
        const labels = Object.keys(data);
        const values = Object.values(data);

        const ctx = document.getElementById('barGraph').getContext('2d');
        const barGraph = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Report Data',
                    data: values,
                    backgroundColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }

    function showOptions(optionId) {
        const options = document.querySelectorAll('.options');
        options.forEach(option => option.classList.add('hidden'));
        document.getElementById(optionId).classList.remove('hidden');
    }
</script>
</body>
</html>