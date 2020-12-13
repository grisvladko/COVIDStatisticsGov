var ctx = document.getElementById('middleThirdChart').getContext('2d')

const lightBlue = 'rgba(88,223,255,0.6)'
const mainGreen = '#b6ca51'

let labels = []

const data = {
    labels: labels,
    datasets: [{
        backgroundColor: constants.greenLM,
        borderColor: constants.lightBlueLM,
        barThickness: 15,
        fill: 'start',
        data: [{
            x: generateDate(),
            y: 2
        }, {
            x: generateDate(),
            y: 4
        }, {
            x: generateDate(),
            y: 5
        }, {
            x: generateDate(),
            y: 88
        }, {
            x: generateDate(),
            y: 12
        }   ]
    }]
}


var myChart = new Chart(ctx, {
    type: 'bar', 
    data: data,
    options: {
        responsive: true,
        maintainAspectRatio: false,
        annotation: {
            annotations: [{
                drawTime: "afterDatasetsDraw",
                id: 'hline',
                type: 'line',
                mode: 'horizontal',
                scaleID: "y-axis-0",
                value: 10,
                borderColor: "red",
                borderWidth: 3,
                label: {
                backgroundColor: "red",
                content: "100",
                enabled: true,
                position: 'left'
             },
            }]
        },
        cornerRadius: 20,
        plugins: {
            datalabels: {
                formatter: function(value, context) {
                    const date = new Date(value.x)
                    return `${date.getDay()}`
                },
                color: constants.darkBlueLM,
                align: 'top',
                offset: 0,
                anchor: 'end',
                font: {
                    size: 12
                },
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
            intersect: false,
            mode: 'index',
        },
        scales: {
            xAxes: [{   
               ticks: {
                   callback: (value,index,values) => {
                        const date = new Date(value)
                        return `${date.getDay()}.${date.getMonth()}`
                   },
                   fontColor: constants.darkBlueLM,
                   autoSkip: true,
                   maxTicksLimit: 7,
               },
                gridLines: {
                    display: false
                }
            }],
            yAxes: [{
                gridLines: {
                    display: false
                }, 
                ticks: {
                    fontColor: constants.darkBlueLM
                }
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
        changeProperties(constants.cellBGDM, 'white', constants.peachDM)
    } else {
        changeProperties('white', constants.darkBlueLM, constants.greenLM)
    }
    isDarkModeOn = !isDarkModeOn
    myChart.update()
}

function changeProperties(bg, labelColor, barColor) {
    document.getElementById('canvas_container').style.backgroundColor = bg
    myChart.data.datasets[0].backgroundColor = barColor
    myChart.options.scales.xAxes[0].ticks.fontColor = labelColor
    myChart.options.scales.yAxes[0].ticks.fontColor = labelColor
    myChart.options.scales.yAxes[0].scaleLabel.fontColor = labelColor
    myChart.options.plugins.datalabels.color = labelColor
}