var ctx = document.getElementById('heavilySickChart').getContext('2d')

const lightBlue = 'rgba(88,223,255,0.6)'
const darkBlue = '#1e898a'
const mainGreen = '#b6ca51'

var gradientStroke = ctx.createLinearGradient(0, 0, 0, 800);
gradientStroke.addColorStop(0, 'rgba(88,223,255,0.6)');
gradientStroke.addColorStop(1, "rgba(255, 255, 255, 0.6)");

let labels = []

var myChart = new Chart(ctx, {
    type: 'scatter',
    data: {
      datasets: [
        {
          data: [],
          showLine: true,
          fill: false,
          borderColor: constants.greenLM,
          pointStyle: 'rectRounded',
          pointBorderWidth: 3,
          pointRadius: 15,
          pointBackgroundColor: 'white',
          pointHoverRadius: 15,
          pointHoverBackgroundColor: 'white',
          pointHoverBorderWidth: 3
          },
        {
          data: [],
          showLine: true,
          fill: false,
          borderColor: constants.lightBlueLM,
          pointStyle: 'rectRounded',
          pointBorderWidth: 3,
          pointRadius: 15,
          pointBackgroundColor: 'white',
          pointHoverRadius: 15,
          pointHoverBackgroundColor: 'white',
          pointHoverBorderWidth: 3
          },
        {
          data: [],
          showLine: true,
          fill: false,
          borderColor: constants.darkBlueLM,
          pointStyle: 'rectRounded',
          pointBorderWidth: 3,
          pointRadius: 15,
          pointBackgroundColor: 'white',
          pointHoverRadius: 15,
          pointHoverBackgroundColor: 'white',
          pointHoverBorderWidth: 3
        }
      ]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            datalabels: {
                color: constants.darkBlueLM,
                formatter: function(value, context) {
                    const date = new Date(value.x)
                    return `${date.getDay()}`
                },
                font: {
                    size: 14
                },
                offset: -5,
                labels: {
                    title: {
                        weight: 'bold'
                    }
                }
            }
        },
        legend: {
            display: false
        },
        tooltips: {
            mode: 'index',
            intersect: true,
        },
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true,
                    fontColor: constants.darkBlueLM
                },
                scaleLabel: {
                    fontColor: constants.darkBlueLM
                }
            }],
            xAxes: [{
                gridLines: {
                    display: false
                },
                ticks: {
                    maxTicksLimit: 10, 
                    autoSkip: true,
                    fontColor: constants.darkBlueLM
                },
                scaleLabel: {
                    fontColor : constants.darkBlueLM
                }
            }]
        }, 
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
        changeProperties(constants.cellBGDM,'white',[constants.peachDM, constants.lightBlueDM, constants.greenDM])
    } else {
        changeProperties('white', constants.darkBlueLM,[constants.greenLM, constants.lightBlueDM, constants.deemBlueLM])
    }
    isDarkModeOn = !isDarkModeOn
    myChart.update()
}

function changeProperties(bg, labelColor, colors) {
    document.getElementById('canvas_container').style.backgroundColor = bg

    myChart.data.datasets[0].borderColor = colors[0]
    myChart.data.datasets[0].pointBackgroundColor = bg
    myChart.data.datasets[0].pointHoverBackgroundColor = bg

    myChart.data.datasets[1].borderColor = colors[1]
    myChart.data.datasets[1].pointBackgroundColor = bg
    myChart.data.datasets[1].pointHoverBackgroundColor = bg

    myChart.data.datasets[2].borderColor = colors[2]
    myChart.data.datasets[2].pointBackgroundColor = bg
    myChart.data.datasets[2].pointHoverBackgroundColor = bg

    myChart.options.scales.xAxes[0].ticks.fontColor = labelColor
    myChart.options.scales.xAxes[0].scaleLabel.fontColor = labelColor

    myChart.options.scales.yAxes[0].ticks.fontColor = labelColor
    myChart.options.scales.yAxes[0].scaleLabel.fontColor = labelColor

    myChart.options.plugins.datalabels.color = labelColor
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
        dataset.data.push(data);
    });
  
    chart.update()
    return  chart.data.datasets.data
  }
