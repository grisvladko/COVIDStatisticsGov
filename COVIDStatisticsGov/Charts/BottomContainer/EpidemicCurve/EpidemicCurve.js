var ctx = document.getElementById('epidemicCurveChart').getContext('2d')

const lightBlue = 'rgba(88,223,255,0.6)'
const darkBlue = '#1e898a'

var gradientStroke = ctx.createLinearGradient(0, 0, 0, 800);
gradientStroke.addColorStop(0, 'rgba(88,223,255,0.6)');
gradientStroke.addColorStop(1, "rgba(255, 255, 255, 0.6)");

let labels = []

var data = {
    labels: ["Chocolate", "Vanilla", "Strawberry"],
    datasets: [
        {
            type: 'line',
            backgroundColor: gradientStroke,
            borderColor: lightBlue,
            data: [3 , 5 , 1],
            yAxisID: 'line-chart'
        },
        {
            label: "Red",
            backgroundColor: darkBlue,
            barPercentage: 0.8,
            categoryPercentage: 0.15,
            data: [3,7,4],
            yAxisID: 'bar-chart'
        },
        {
            label: "Green",
            backgroundColor: "gray",
            barPercentage: 0.8,
            categoryPercentage: 0.15,
            data: [7,2,6]
        }, 
    ]
};

var myBarChart = new Chart(ctx, {
    type: 'bar',
    data: data,
    options: {
        responsive: true,
        maintainAspectRatio: false,
        legend: {
            display: false
        },
        cornerRadius: 20,
        scales: {
            yAxes: [{
                display: false,
                ticks: {
                    min: 0,
                },
                gridLines: {
                    display: false
                }
            }, {
                id: 'line-chart',
                display: true,
                scaleLabel: {
                    labelString: 'כמות מסכנים',
                    display: true,
                    fontSize: 20,
                    fontColor: lightBlue
                },
                gridLines: {
                    display: false
                }
            }, {
                id: 'bar-chart',
                display: true,
                position: 'right',
                scaleLabel: {
                    labelString: 'מספר מקרים חדשים',
                    display: true,
                    fontSize: 20,
                    fontColor: darkBlue,
                }, gridLines: {
                    display: false
                }
            }],
            xAxes: [{
                gridLines: {
                    display: false
                },
                scaleLabel: {
                    labelString: 'תאריך',
                    display: true,
                    fontSize: 20,
                    fontColor: darkBlue,
                },
            }]
        }
    }
});

function generateDate() {
    const years = [2010,2011,2012,2013,2014,2015,2016]
    const months = [1,2,3,4,5,6,7,8,9,10,11,12]
    let days = []

    for (i = 1; i <= 30; i++) {
        days.push(i)
    }

    const random = getRndInteger(0, years.length - 1)
    const date = new Date(years[random], months[random], days[random])
    labels.push(date)

    return date
}

function getRndInteger(min, max) {
    return Math.floor(Math.random() * (max - min) ) + min;
}
