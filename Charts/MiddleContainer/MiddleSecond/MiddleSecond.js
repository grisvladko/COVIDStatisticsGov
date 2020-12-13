var ctx = document.getElementById('middleSecondChart').getContext('2d')

var gradientStroke = ctx.createLinearGradient(0, 0, 0, 500);
gradientStroke.addColorStop(0, constants.deemBlueLM);
gradientStroke.addColorStop(1, "rgba(0, 0, 0, 0)");

var darkModeGradientStroke = ctx.createLinearGradient(0, 0, 0, 500);
darkModeGradientStroke.addColorStop(0, constants.greenDM)
darkModeGradientStroke.addColorStop(1, "rgba(0, 0, 0, 0)")

let labels = []

const data = {
    labels: labels,
    datasets: [{
        backgroundColor: gradientStroke,
        borderColor: constants.deemBlueLM,
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
    type: 'line', 
    data: data,
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            datalabels: {
                formatter: function(value, context) {
                    const date = new Date(value.x)
                    return `${date.getDay()}`
                },
                align: 'top',
                offset: 0,
                color: constants.darkBlueLM,
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
        elements: {
            line: {
                tension: 0.0001
            }
        },legend: {
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
                   autoSkip: true,
                   maxTicksLimit: 7,
                   fontColor: constants.darkBlueLM
               }, 
                gridLines: {
                    display: false
                }
            }],
            yAxes: [{
                gridLines: {
                    display: false
                }, 
                ticks : {
                    fontColor: constants.darkBlueLM
                }
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
        changeProperties(darkModeGradientStroke, constants.cellBGDM, 'white', constants.greenDM)
    } else {
        changeProperties(gradientStroke,'white', constants.darkBlueLM, constants.deemBlueLM)
    }
    isDarkModeOn = !isDarkModeOn
    myChart.update()
}

function changeProperties(gradient,canvasBg, labelColor, borderColor) {
    document.getElementById('canvas_container').style.backgroundColor = canvasBg
    myChart.data.datasets[0].backgroundColor = gradient
    myChart.data.datasets[0].borderColor = borderColor
    myChart.options.scales.xAxes[0].ticks.fontColor = labelColor
    myChart.options.scales.yAxes[0].ticks.fontColor = labelColor
    myChart.options.plugins.datalabels.color = labelColor
}