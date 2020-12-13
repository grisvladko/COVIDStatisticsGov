var ctx = document.getElementById('spreadChart').getContext('2d')

const lightBlue = 'rgba(88,223,255,1)'
const darkBlue = '#1e898a'
const mainGreen = '#b6ca51'

let labels = ['0-9', '10-19', '20-29', '30-39','40-49','50-59','60-69','70-79','80-89','+90'].reverse()

const data = {
    labels: labels,
    datasets: [{
        datalabels: {
            display: true,
            formatter: function(value, context) {
                const date = new Date(value.y)
                return `${date.getDay()}%`
            },
            font: {
                size: 12
            },
            align: 'end',
            anchor: 'end',
            clip: true,
            offset: 0,
            labels: {
                title: {
                    weight: 'bold'
                }
            }
        },
        backgroundColor: lightBlue,
        borderColor: darkBlue,
        barPercentage: 0.8,
        categoryPercentage: 0.15,
        data: [{
            x: 19,
            y: 2
        }, {
            x: 11,
            y: 4
        }, {
            x: 11,
            y: 5
        }, {
            x: 1,
            y: 88
        }, {
            x: 20,
            y: 12
        }]
    }, {
        datalabels: {
            display: true,
            formatter: function(value, context) {
                const date = new Date(value.y)
                return `${date.getDay()}%`
            },
            font: {
                size: 12
            },
            clip: true,
            align: 'start',
            anchor: 'start',
            offset: 0,
            labels: {
                title: {
                    weight: 'bold'
                }
            }
        },
        barPercentage: 0.8,
        categoryPercentage: 0.15,
        backgroundColor: mainGreen,
        data: [{
            x: -11,
            y: 21
        }, {
            x: -11,
            y: 42
        }, {
            x: -16,
            y: 51
        }, {
            x: -5,
            y: 1
        }, {
            x: -14,
            y: 16
        }]
    }]
}


var myChart = new Chart(ctx, {
    type: 'horizontalBar', 
    data: data,
    options: {
        responsive: true,
        maintainAspectRatio: false,
        cornerRadius: 20,
        legend: {
            display: false
        },
        plugins: {
            datalabels: {
                display: false
            }
        },
        indexAxis: 'y',
        scales: {
            xAxes: [{ 
                stacked: true,
                scaleLabel: {
                    labelString: 'סה"כ %',
                    display: true,
                },
                ticks: {
                    callback: (value,index,values) => {
                        if (value < 0) {
                            return value * -1
                        } else {
                            return value
                        }
                   },
                   autoSkip: true,
                   maxTicksLimit: 5,
               }, 
            }],
            yAxes: [{
                stacked: true,
                scaleLabel: {
                    labelString: 'קבוצת גיל',
                    display: true
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

function boom() {
    myChart.update()
}
