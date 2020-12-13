var ctx = document.getElementById('middleSecondChart').getContext('2d')

const lightBlue = 'rgba(88,223,255,0.6)'
const darkBlue = '#1e898a'

var gradientStroke = ctx.createLinearGradient(0, 0, 0, 800);
gradientStroke.addColorStop(0, darkBlue);
gradientStroke.addColorStop(1, "rgba(255, 255, 255, 0.6)");

let labels = []

const data = {
    labels: labels,
    datasets: [{
        backgroundColor: gradientStroke,
        borderColor: darkBlue,
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
                font: {
                    size: 20
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
                   fontColor: darkBlue
               }, 
                gridLines: {
                    display: false
                }
            }],
            yAxes: [{
                gridLines: {
                    display: false
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
