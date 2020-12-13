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
          data: [{x: 1, y: 2}, {x: 2, y: 4}, {x: 3, y: 8},{x: 4, y: 16}],
          showLine: true,
          fill: false,
          borderColor: mainGreen,
          pointStyle: 'rectRounded',
          pointBorderWidth: 3,
          pointRadius: 25,
          pointBackgroundColor: 'white',
          pointHoverRadius: 25,
          pointHoverBackgroundColor: 'white',
          pointHoverBorderWidth: 3
          },
        {
          data: [{x: 1, y: 3}, {x: 3, y: 4}, {x: 4, y: 6}, {x: 6, y: 9}],
          showLine: true,
          fill: false,
          borderColor: lightBlue,
          pointStyle: 'rectRounded',
          pointBorderWidth: 3,
          pointRadius: 25,
          pointBackgroundColor: 'white',
          pointHoverRadius: 25,
          pointHoverBackgroundColor: 'white',
          pointHoverBorderWidth: 3
          },
        {
          data: [{x: 2, y: 4}, {x: 3, y: 1}, {x: 5, y: 1}, {x: 2, y: 2}],
          showLine: true,
          fill: false,
          borderColor: darkBlue,
          pointStyle: 'rectRounded',
          pointBorderWidth: 3,
          pointRadius: 25,
          pointBackgroundColor: 'white',
          pointHoverRadius: 25,
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
                formatter: function(value, context) {
                    const date = new Date(value.x)
                    return `${date.getDay()}`
                },
                font: {
                    size: 20
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
                beginAtZero:true
                },
            }],
            xAxes: [{
                gridLines: {
                    display: false
                },
                ticks: {
    
                    maxTicksLimit: 10, 
                    autoSkip: true
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
