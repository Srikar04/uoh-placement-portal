<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>UOH Placement Portal</title>
    <link rel="icon" href="images/uohyd_bg.png" type="image/x-icon">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.3.0/flowbite.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="my-20">
    <div class="container flex flex-wrap items-center justify-center mx-auto py:5">
        <div class="flex py-6">
            <div class="block bg-gradient-to-r from-pink-400 to-orange-400 text-white p-5 rounded-lg">
                <ul class="flex flex-row space-x-8 text-md font-medium">
                    <li>
                        <a href="#motive" class="text-white hover:bg-white hover:text-blue-700 rounded py-2 px-3">Motivation</a>
                    </li>
                    <li>
                        <a href="#stats" class="text-white hover:bg-white hover:text-blue-700 rounded py-2 px-3">Placement Statistics</a>
                    </li>
                    <li>
                        <a href="#recr" class="text-white hover:bg-white hover:text-blue-700 rounded py-2 px-3">Recruitment Process</a>
                    </li>
                    <li>
                        <a href="#uoh" class="text-white hover:bg-white hover:text-blue-700 rounded py-2 px-3">Why UOH?</a>
                    </li>
                    <li>
                        <a href="#team" class="text-white hover:bg-white hover:text-blue-700 rounded py-2 px-3">Our Team</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <div class="container mx-auto">
        <div id="gallery" class="relative w-full" data-carousel="slide">
            <div class="relative h-56 overflow-hidden rounded-lg md:h-96">
                <div class="hidden duration-1500 ease-in-out" data-carousel-item>
                    <img src="images/image-9.jpg" class="absolute block max-w-2xl h-auto -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2" alt="">
                </div>
                <div class="hidden duration-700 ease-in-out" data-carousel-item="active">
                    <img src="images/image-1.jpg" class="absolute block max-w-2xl h-auto -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2" alt="">
                </div>
                <div class="hidden duration-700 ease-in-out" data-carousel-item>
                    <img src="images/image-10.jpg" class="absolute block max-w-2xl h-auto -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2" alt="">
                </div>

                <div class="hidden duration-700 ease-in-out" data-carousel-item>
                    <img src="images/image-4.webp" class="absolute block max-w-2xl h-auto -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2" alt="">
                </div>
                <div class="hidden duration-700 ease-in-out" data-carousel-item>
                    <img src="images/image-5.jpg" class="absolute block max-w-2xl h-auto -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2" alt="">
                </div>
                <div class="hidden duration-700 ease-in-out" data-carousel-item>
                    <img src="images/image-6.jpg" class="absolute block max-w-2xl h-auto -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2" alt="">
                </div>
                <div class="hidden duration-700 ease-in-out" data-carousel-item>
                    <img src="images/image-7.webp" class="absolute block max-w-2xl h-auto -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2" alt="">
                </div>
                <div class="hidden duration-700 ease-in-out" data-carousel-item>
                    <img src="images/image-8.webp" class="absolute block max-w-2xl h-auto -translate-x-1/2 -translate-y-1/2 top-1/2 left-1/2" alt="">
                </div>
            </div>
            <button type="button" class="absolute top-0 start-0 z-30 flex items-center justify-center h-full px-4 cursor-pointer group focus:outline-none" data-carousel-prev>
                <span class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-gray-200  group-hover:bg-white/50 group-focus:ring-4 group-focus:ring-white group-focus:outline-none">
                    <svg class="w-4 h-4 text-black  rtl:rotate-180" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 6 10">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 1 1 5l4 4"/>
                    </svg>
                    <span class="sr-only">Previous</span>
                </span>
            </button>
            <button type="button" class="absolute top-0 end-0 z-30 flex items-center justify-center h-full px-4 cursor-pointer group focus:outline-none" data-carousel-next>
                <span class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-gray-200  group-hover:bg-white/50  group-focus:ring-4 group-focus:ring-white group-focus:outline-none">
                    <svg class="w-4 h-4 text-black rtl:rotate-180" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 6 10">
                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 9 4-4-4-4"/>
                    </svg>
                    <span class="sr-only">Next</span>
                </span>
            </button>
        </div>
    </div>

    <div class="container mx-auto my-8" id="uoh">
        <div class="p-8 w-3/4 mx-auto ">
            <h2 class="text-2xl font-bold mb-4 text-center">
                <span class="text-transparent bg-clip-text bg-gradient-to-r to-emerald-600 from-sky-400">UoH at a Glance</span>
            </h2>
            <ol class="rounded-lg shadow-md p-3 list-none space-y-4 text-lg bg-gradient-to-r from-white to-red-200">
                <li class="flex items-center space-x-2">
                    <img src="images/star.svg" alt="Arrow" class="h-6 w-6 animate-spin">
                    <p>QS World Rankings <span class="font-bold">#801-850</span></p>
                </li>
                <li class="flex items-center space-x-2">
                    <img src="images/star.svg" alt="Arrow" class="h-6 w-6 animate-spin">
                    <p>NIRF <span class="font-bold">#10</span> India University Ranking</p>
                </li>
                <li class="flex items-center space-x-2">
                    <img src="images/star.svg" alt="Arrow" class="h-6 w-6 animate-spin">
                    <p>Scopus <span class="font-bold">#1097</span> Publications in 2023</p>
                </li>
                <li class="flex items-center space-x-2">
                    <img src="images/star.svg" alt="Arrow" class="h-6 w-6 animate-spin">
                    <p>MoU <span class="font-bold">#73</span> MoU's Signed</p>
                </li>
                <li class="flex items-center space-x-2">
                    <img src="images/star.svg" alt="Arrow" class="h-6 w-6 animate-spin">
                    <p>On Going Projects <span class="font-bold">#174</span> Ongoing Projects</p>
                </li>
                <li class="flex items-center space-x-2">
                    <img src="images/star.svg" alt="Arrow" class="h-6 w-6 animate-spin">
                    <p>Patents <span class="font-bold">#39</span> Patents Granted</p>
                </li>
            </ol>
        </div>
    </div>

    <div class="container mx-auto my-8" id="motive">
            <h2 class="text-2xl font-bold mb-4 text-center p-8">
                <span class="text-transparent bg-clip-text bg-gradient-to-r to-emerald-600 from-sky-400">Motivation</span>
            </h2>
        <div class="rounded-lg shadow-md w-3/4 p-4 mx-auto bg-gradient-to-r from-white to-indigo-200">
            <p class="text-lg mb-4">UoH(University of Hyderabad) Placement Portal aims to streamline the recruitment process for students and facilitate efficient management of job placements within the university. It provides a centralized platform where students can create profiles, view job opportunities, and apply for positions.</p>
            <p class="text-lg">Additionally, this portal enables T.P.O and Chairman to post job openings and access applicant details, while allowing the chairman to generate comprehensive reports and statistics related to placements across various academic years, departments, schools, streams, and program tenures.</p>
        </div>
    </div>

    <div class="container mx-auto my-8 flex justify-center">
        <div class="w-3/4">
            <h2 class="text-2xl font-bold mb-4 text-center" id="stats">
                <span class="text-transparent bg-clip-text bg-gradient-to-r to-emerald-600 from-sky-400">Placement Statistics</span>
            </h2>
            <canvas id="placementChart" class="my-8"></canvas>
            <div class="overflow-x-auto">
                <table class="w-full border-collapse border border-gray-300 text-center">
                    <thead>
                    <tr>
                        <th class="py-2 px-4 bg-gray-200 w-1/4">Year</th>
                        <th class="py-2 px-4 bg-gray-200 w-3/4">Report</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="py-2 px-4 border border-gray-300">2023</td>
                        <td class="py-2 px-4 border border-gray-300">
                            <a href="#" class="text-blue-500 hover:text-blue-700 flex justify-center">
                                <i class="fas fa-file-pdf"></i> Download PDF
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td class="py-2 px-4 border border-gray-300">2023</td>
                        <td class="py-2 px-4 border border-gray-300">
                            <a href="#" class="text-blue-500 hover:text-blue-700 flex justify-center">
                                <i class="fas fa-file-pdf"></i> Download PDF
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td class="py-2 px-4 border border-gray-300">2021</td>
                        <td class="py-2 px-4 border border-gray-300">
                            <a href="#" class="text-blue-500 hover:text-blue-700 flex justify-center">
                                <i class="fas fa-file-pdf"></i> Download PDF
                            </a>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="container mx-auto my-8 flex justify-center">
        <div class="w-3/4">
            <h2 class="text-2xl font-bold mb-4 text-center">
                <span class="text-transparent bg-clip-text bg-gradient-to-r to-emerald-600 from-sky-400">Our Top Recruiters</span>
            </h2>
            <div class="flex items-center gap-8 overflow-x-auto px-4" >
                <img src="images/ge.png" class="animate-pulse h-16 rounded-lg" alt="Company Logo">
                <img src="images/Intel-logo-2022.png" class="animate-pulse  h-14 rounded-lg" alt="Company Logo">
                <img src="images/Marvell.png" class="animate-pulse  h-12 rounded-lg" alt="Company Logo">
                <img src="images/Oracle-Logo.jpg" class="animate-pulse  h-14 rounded-lg" alt="Company Logo">
                <img src="images/Invesco-logo.jpg" class="animate-pulse h-14 rounded-lg" alt="Company Logo">
                <img src="images/Accenture-logo.png" class="animate-pulse h-14 rounded-lg" alt="Company Logo">
            </div>
        </div>
    </div>

    <br>
    <br>

    <div class="container mx-auto my-8 text-center" id="recr">
        <h2 class="text-2xl font-bold mb-4">
            <span class="text-transparent bg-clip-text bg-gradient-to-r to-emerald-600 from-sky-400">Recruitment Process</span>
        </h2>
        <div class="w-3/4 mx-auto flex flex-col items-center space-y-4 bg-gradient-to-r to-orange-100 from-white rounded-lg shadow-md p-6 border border-gray-300">
            <div class="flex items-center space-x-4">
                <div class="w-12 h-12 bg-gray-200 rounded-full flex items-center justify-center">
                    <span class="text-lg font-bold">1</span>
                </div>
                <p>T.P.O/Placement Coordinator uploads Job opportunities</p>
            </div>
            <img src="images/downArrow.svg" alt="Arrow" class="h-8 animate-bounce">
            <div class="flex items-center space-x-4">
                <div class="w-12 h-12 bg-gray-200 rounded-full flex items-center justify-center">
                    <span class="text-lg font-bold">2</span>
                </div>
                <p>Students apply to Job opportunities</p>
            </div>
            <img src="images/downArrow.svg" alt="Arrow" class="h-8 animate-bounce">
            <div class="flex items-center space-x-4">
                <div class="w-12 h-12 bg-gray-200 rounded-full flex items-center justify-center">
                    <span class="text-lg font-bold">3</span>
                </div>
                <p>Students check status of their jobs</p>
            </div>
            <img src="images/downArrow.svg" alt="Arrow" class="h-8 animate-bounce">
            <div class="flex items-center space-x-4">
                <div class="w-12 h-12 bg-gray-200 rounded-full flex items-center justify-center">
                    <span class="text-lg font-bold">4</span>
                </div>
                <p>If selected, students must upload offer letter</p>
            </div>
            <img src="images/downArrow.svg" alt="Arrow" class="h-8 animate-bounce">
            <div class="flex items-center space-x-4">
                <div class="w-12 h-12 bg-gray-200 rounded-full flex items-center justify-center">
                    <span class="text-lg font-bold">5</span>
                </div>
                <p>Coordinator approves the offer letter</p>
            </div>
            <img src="images/downArrow.svg" alt="Arrow" class="h-8 animate-bounce">
            <div class="flex items-center space-x-4">
                <div class="w-12 h-12 bg-gray-200 rounded-full flex items-center justify-center">
                    <span class="text-lg font-bold">6</span>
                </div>
                <p>Student's job is confirmed and considered into our Placement Statistics</p>
            </div>
        </div>
    </div>

    <br>
    <br>




    <div class="container mx-auto my-8" id="team">
        <h2 class="text-2xl font-bold mb-4 text-center">
            <span class="text-transparent bg-clip-text bg-gradient-to-r to-emerald-600 from-sky-400">Our Team</span>
        </h2>
        <div class="flex flex-col justify-center items-center">
            <div class="bg-gradient-to-r from-blue-300 to-white rounded-lg shadow-md p-6 mb-8 border border-gray-300 flex items-center">
                <img src="images/salman1.jpg" alt="Prof-in-charge" class="w-20 h-20 rounded-full object-cover mr-6">
                <div>
                    <h3 class="text-lg font-bold mb-2 text-gray-800">Prof-in-charge</h3>
                    <p class=" text-gray-700">Prof Salman Abdul Moiz</p>
                    <p class=" text-gray-600">E-Mail: chairmanpgab@uohyd.ac.in</p>
                </div>
            </div>
            <div class="bg-gradient-to-r from-blue-300 to-white rounded-lg shadow-md p-6 border border-gray-300 flex items-center">
                <img src="images/placeholder.webp" alt="Mrs. Prerna Akhouri" class="w-20 h-20 rounded-full object-cover mr-6">
                <div>
                    <h3 class="text-lg font-bold mb-2 text-gray-800">Mrs. Prerna Akhouri</h3>
                    <p class="text-gray-700">Training & Placement Officer</p>
                    <p class="text-gray-600">Telephone : (040) 23132140 /23011831</p>
                    <p class="text-gray-600">E-Mail: placementuoh@gmail.com</p>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    // Data for the bar chart
    const data = {
        labels: ['Total Placed Students', 'Highest Package','Number of Companies Visited'],
        datasets: [
            {
                label: '2021',
                backgroundColor: ['#12ef30'],
                barPercentage: 0.4,
                categoryPercentage: 0.5,
                data: [396, 17,185],
            },
            {
                label: '2022',
                backgroundColor: ['#ef1ff6'],
                barPercentage: 0.4,
                categoryPercentage: 0.5,
                data: [485, 23, 213],
            }
        ]
    };

    // Configuration options
    const options = {
        indexAxis: 'x',
        grouped: true,
        scales: {
            x: {
                stacked: false
            }
        }
    };


    // Get the canvas element
    const ctx = document.getElementById('placementChart').getContext('2d');

    // Create the bar chart
    const placementChart = new Chart(ctx, {
        type: 'bar',
        data: data,
        options: options
    });

</script>

</body>