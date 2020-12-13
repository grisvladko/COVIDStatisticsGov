const Constants = require("../Constants");

var ctx = document.getElementById('popUpChart').getContext('2d')

var gradientStroke = ctx.createLinearGradient(0, 0, 0, 800);
gradientStroke.addColorStop(0, 'rgba(88,223,255,0.6)');
gradientStroke.addColorStop(1, "rgba(255, 255, 255, 0.6)");

let labels = []

const data = {
    labels: labels,
    datasets: [{
        backgroundColor: gradientStroke,
        pointHoverRadius: 10,
        pointHoverBackgroundColor: Constants.lightBlueLM,
        borderColor: Constants.lightBlueLM,
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
        hover: {
            intersect: false,
            mode: 'index',
        },
        plugins: {
            datalabels: {
                display: false
            }
        },
        legend: {
            display: false
        },
        tooltips: {
            backgroundColor: 'white',
            titleFontColor: '#1e898a',
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
                   fontColor: Constants.darkBlueLM
               },
                scaleLabel: {
                    labelString: 'תאריך',
                    display: true,
                    fontSize: 20,
                    fontColor: Constants.darkBlueLM
                },
                gridLines: {
                    display: false
                }
            }],
            yAxes: [{
                ticks: {
                    fontColor: Constants.darkBlueLM
                },
                scaleLabel: {
                    labelString: 'כמות מסכנים',
                    display: true,
                    fontSize: 20,
                    fontColor: Constants.darkBlueLM
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

Chart.Tooltip.positioners.cursor = function(chartElements, coordinates) {
    console.log(coordinates)
    return coordinates;
  };

let parentEventHandler = Chart.Controller.prototype.eventHandler;
Chart.Controller.prototype.eventHandler = function () {
    let ret = parentEventHandler.apply(this, arguments);

    let topY, bottomY, maxX, minX, x , y

    var activePoint = this.chart.tooltip._active[0]
    if(activePoint) {
         ctx = this.chart.ctx

         const yScale = this.chart.scales['y-axis-0']
         const xScale = this.chart.scales['x-axis-0']
         x = activePoint.tooltipPosition().x
         y = activePoint.tooltipPosition().y
         topY = yScale.top,
         bottomY = yScale.bottom

         maxX = xScale.getPixelForValue(xScale.max)
         minX = xScale.getPixelForValue(xScale.min)
    }
         // draw line
         ctx.save();
         ctx.setLineDash([5,5])
         ctx.beginPath();
         ctx.moveTo(x, topY);
         ctx.lineTo(x, bottomY);
         ctx.lineWidth = 2;
         ctx.strokeStyle = '#07C';
         ctx.stroke();

         ctx.beginPath();
         ctx.setLineDash([])
         ctx.moveTo(minX, y);
         ctx.lineTo(maxX, y);
         ctx.lineWidth = 2;
         ctx.strokeStyle = '#07C';
         ctx.stroke();
         
         ctx.restore();

    return ret;
};

function callModeChange() {
    constants.changeChartMode(myChart,undefined,undefined)
}