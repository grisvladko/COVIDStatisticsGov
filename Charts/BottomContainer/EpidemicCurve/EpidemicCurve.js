var ctx = document.getElementById('epidemicCurveChart').getContext('2d')

const lightBlue = 'rgba(88,223,255,0.6)'
const darkBlue = '#1e898a'

var gradientStroke = ctx.createLinearGradient(0, 0, 0, 800);
gradientStroke.addColorStop(0, 'rgba(88,223,255,0.6)');
gradientStroke.addColorStop(1, "rgba(255, 255, 255, 0.6)");

let labels = []

var data = {
    labels: [constants.chartData, constants.chartData, constants.chartData],
    datasets: [
        {
            type: 'line',
            backgroundColor: gradientStroke,
            borderColor: constants.lightBlueLM,
            data: [],
            yAxisID: 'line-chart'
        },
        {
            label: "Red",
            backgroundColor: constants.deemBlueLM,
            barPercentage: 0.8,
            categoryPercentage: 0.15,
            data: [],
            yAxisID: 'bar-chart'
        },
        {
            label: "Green",
            backgroundColor: "gray",
            barPercentage: 0.8,
            categoryPercentage: 0.15,
            data: []
        }, 
    ]
};

var myChart = new Chart(ctx, {
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
                ticks: {
                    fontColor : constants.lightBlueLM
                },
                display: true,
                scaleLabel: {
                    labelString: 'כמות מסכנים',
                    display: true,
                    fontSize: 20,
                    fontColor: constants.lightBlueLM
                },
                gridLines: {
                    display: false
                }
            }, {
                id: 'line-chart',
                display: false,
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
                    fontColor: constants.darkBlueLM,
                }, gridLines: {
                    display: false
                }, 

            }],
            xAxes: [{
                ticks :{
                    fontColor: constants.darkBlueLM
                },
                gridLines: {
                    display: false
                },
                scaleLabel: {
                    labelString: 'תאריך',
                    display: true,
                    fontSize: 20,
                    fontColor: constants.darkBlueLM,
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

function callModeChange(isDarkModeOn) {
    if (!isDarkModeOn) {
        changeProperties(constants.cellBGDM,'white',[constants.lightBlueDM, constants.greenDM, constants.peachDM], 'rgba(0,0,0,0)')
    } else {
        changeProperties('white', constants.darkBlueLM,[constants.lightBlueLM, 'gray', constants.deemBlueLM], gradientStroke)
    }
    isDarkModeOn = !isDarkModeOn
    myChart.update()
}

function changeProperties(bg, labelColor, colors, lineColor) {
    document.getElementById('canvas_container').style.backgroundColor = bg
    myChart.data.datasets[0].backgroundColor = lineColor
    myChart.data.datasets[0].borderColor = colors[0]
    myChart.data.datasets[1].backgroundColor = colors[1]
    myChart.data.datasets[2].backgroundColor = colors[2]

    myChart.options.scales.xAxes[0].ticks.fontColor = labelColor
    myChart.options.scales.xAxes[0].scaleLabel.fontColor = labelColor

    myChart.options.scales.yAxes[0].ticks.fontColor = colors[0]
    myChart.options.scales.yAxes[0].scaleLabel.fontColor = labelColor

    myChart.options.scales.yAxes[2].ticks.fontColor = colors[2]
    myChart.options.scales.yAxes[2].scaleLabel.fontColor = colors[2]
}

function changeContainer(data) {
    removeData(myChart)
    updateChart(myChart,data)
  }
  
  function removeData(chart) {
    chart.data.datasets.forEach((dataset) => {
        dataset.data.pop();
    });
  }
  
  function updateChart(chart, data) {
   
    chart.data.datasets.forEach((dataset) => {
        dataset.data.push([1,2,3,4,5,6,7,8]);
    });
  
    chart.update()
  }
