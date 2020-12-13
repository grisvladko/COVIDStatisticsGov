var ctx = document.getElementById('lastChart').getContext('2d')

const lightBlue = 'rgba(88,223,255,1)'
const mainGreen = '#b6ca51'
const darkBlue = '#1e898a'

let labels = []

const data = {
    labels: labels,
    datasets: [{
        backgroundColor: lightBlue,
        borderColor: lightBlue,
        barThickness: 15,
        fill: 'start',
        data: []
    }]
}


var myChart = new Chart(ctx, {
    type: 'bar', 
    data: data,
    options: {
        responsive: true,
        maintainAspectRatio: false,
        cornerRadius: 20,
        plugins: {
            datalabels: {
                formatter: function(value, context) {
                    const date = new Date(value.x)
                    return `${date.getDay()}%`
                },
                align: 'start',
                anchor: 'start',
                offset: -40,
                font: {
                    size: 20
                },
                borderColor: darkBlue,
                backgroundColor: 'white',
                borderWidth: 2,
                borderRadius: 4,
            }
        },
        legend: {
            display: false,
        },
        tooltips: {
            intersect: true,
            mode: 'index',
        },
        scales: {
            xAxes: [{   
               ticks: {
                   callback: (value,index,values) => {
                        const date = new Date(value)
                        return `${date.getDay()}.${date.getMonth()}`
                   },
                   autoSkip: true,
                   maxTicksLimit: 7,
               }, 
               scaleLabel: {
                    labelString: 'תאריך בדיקה',
                    display: true
               },
                gridLines: {
                    display: false
                }
            }],
            yAxes: [{
                gridLines: {
                    display: false
                }, 
                scaleLabel: {
                    labelString: 'מספר בדיקות',
                    display: true
               },
            }]
          }
    },
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
        changeProperties(constants.cellBGDM, 'white', [constants.lightBlueDM, constants.peachDM])
    } else {
        changeProperties('white', constants.darkBlueLM, [constants.lightBlueLM,constants.deemBlueLM])
    }
    isDarkModeOn = !isDarkModeOn
    myChart.update()
}

function changeProperties(bg, labelColor, colors) {
    document.getElementById('canvas_container').style.backgroundColor = bg
    myChart.data.datasets[0].backgroundColor = colors[0]
    myChart.options.plugins.datalabels.color = labelColor
    myChart.options.plugins.datalabels.borderColor = colors[1]
    myChart.options.plugins.datalabels.backgroundColor = bg

    myChart.options.scales.xAxes[0].ticks.fontColor = labelColor
    myChart.options.scales.xAxes[0].scaleLabel.fontColor = labelColor
    myChart.options.scales.yAxes[0].ticks.fontColor = labelColor
    myChart.options.scales.yAxes[0].scaleLabel.fontColor = labelColor
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