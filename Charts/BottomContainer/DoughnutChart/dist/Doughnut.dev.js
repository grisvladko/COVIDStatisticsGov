"use strict";

var ctx = document.getElementById('doughnutChart').getContext('2d');
var lightBlue = 'rgba(88,223,255,0.6)';
var darkBlue = '#1e898a';
var mainGreen = '#b6ca51';
var myChart = new Chart(ctx, {
  type: 'doughnut',
  data: {
    labels: [constants.chartData, constants.chartData, constants.chartData],
    pointHoverRadius: 20,
    datasets: [{
      label: "Population (millions)",
      backgroundColor: [constants.lightBlueLM, constants.greenLM, constants.deemBlueLM],
      data: []
    }]
  },
  options: {
    responsive: true,
    maintainAspectRatio: false,
    tooltips: {},
    layout: {
      padding: 50
    },
    elements: {
      center: {
        text: '678',
        color: constants.darkBlueLM,
        // Default is #000000
        fontStyle: 'Arial',
        // Default is Arial
        sidePadding: 20,
        // Default is 20 (as a percentage)
        minFontSize: 20,
        // Default is 20 (in px), set to false and text will not wrap.
        lineHeight: 25 // Default is 25 (in px), used for when text wraps

      }
    },
    plugins: {
      legend: false,
      outlabels: {
        color: 'white',
        stretch: 30,
        font: {
          resizable: true,
          minSize: 12,
          maxSize: 18
        }
      }
    },
    onHover: function onHover(evt, elements) {
      if (elements && elements.length) {
        segment = elements[0];
        this.chart.update({
          duration: 50,
          easing: 'easeOutBounce'
        });
        selectedIndex = segment["_index"];
        segment._model.outerRadius += 15;
      } else {
        if (segment) {
          segment._model.outerRadius -= 15;
        }

        segment = null;
      }
    },
    cutoutPercentage: 75
  }
});
Chart.pluginService.register({
  beforeDraw: function beforeDraw(chart) {
    if (chart.config.options.elements.center) {
      // Get ctx from string
      var ctx = chart.chart.ctx; // Get options from the center object in options

      var centerConfig = chart.config.options.elements.center;
      var fontStyle = centerConfig.fontStyle || 'Arial';
      var txt = centerConfig.text;
      var color = centerConfig.color || '#000';
      var maxFontSize = centerConfig.maxFontSize || 75;
      var sidePadding = centerConfig.sidePadding || 20;
      var sidePaddingCalculated = sidePadding / 100 * (chart.innerRadius * 2); // Start with a base font of 30px

      ctx.font = "30px " + fontStyle; // Get the width of the string and also the width of the element minus 10 to give it 5px side padding

      var stringWidth = ctx.measureText(txt).width;
      var elementWidth = chart.innerRadius * 2 - sidePaddingCalculated; // Find out how much the font can grow in width.

      var widthRatio = elementWidth / stringWidth;
      var newFontSize = Math.floor(30 * widthRatio);
      var elementHeight = chart.innerRadius * 2; // Pick a new font size so it will not be larger than the height of label.

      var fontSizeToUse = Math.min(newFontSize, elementHeight, maxFontSize);
      var minFontSize = centerConfig.minFontSize;
      var lineHeight = centerConfig.lineHeight || 25;
      var wrapText = false;

      if (minFontSize === undefined) {
        minFontSize = 20;
      }

      if (minFontSize && fontSizeToUse < minFontSize) {
        fontSizeToUse = minFontSize;
        wrapText = true;
      } // Set font settings to draw it correctly.


      ctx.textAlign = 'center';
      ctx.textBaseline = 'middle';
      var centerX = (chart.chartArea.left + chart.chartArea.right) / 2;
      var centerY = (chart.chartArea.top + chart.chartArea.bottom) / 2;
      ctx.font = fontSizeToUse + "px " + fontStyle;
      ctx.fillStyle = color;

      if (!wrapText) {
        ctx.fillText(txt, centerX, centerY);
        return;
      }

      var words = txt.split(' ');
      var line = '';
      var lines = []; // Break words up into multiple lines if necessary

      for (var n = 0; n < words.length; n++) {
        var testLine = line + words[n] + ' ';
        var metrics = ctx.measureText(testLine);
        var testWidth = metrics.width;

        if (testWidth > elementWidth && n > 0) {
          lines.push(line);
          line = words[n] + ' ';
        } else {
          line = testLine;
        }
      } // Move the center up depending on line height and number of lines


      centerY -= lines.length / 2 * lineHeight;

      for (var n = 0; n < lines.length; n++) {
        ctx.fillText(lines[n], centerX, centerY);
        centerY += lineHeight;
      } //Draw text in center


      ctx.fillText(line, centerX, centerY);
    }
  }
});

function callModeChange(isDarkModeOn) {
  if (!isDarkModeOn) {
    changeProperties(constants.cellBGDM, 'white', [constants.lightBlueDM, constants.peachDM, constants.greenDM]);
  } else {
    changeProperties('white', constants.darkBlueLM, [constants.lightBlueLM, constants.greenLM, constants.deemBlueLM]);
  }

  isDarkModeOn = !isDarkModeOn;
  myChart.update();
}

function changeProperties(bg, labelColor, colors) {
  document.getElementById('canvas_container').style.backgroundColor = bg;
  myChart.data.datasets[0].backgroundColor = colors;
  myChart.options.elements.center.color = labelColor;
}

function changeContainer(data) {
  removeData(myChart);
  updateChart(myChart, data);
}

function removeData(chart) {
  chart.data.datasets.forEach(function (dataset) {
    dataset.data.pop();
  });
}

function updateChart(chart, data) {
  chart.data.datasets.forEach(function (dataset) {
    dataset.data.push(data);
  });
  chart.update();
}