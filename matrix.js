var matrixCanvas = document.getElementById('matrixCanvas');
var matrixHeader = document.getElementById('matrixHeader');
matrixCanvas.height = matrixHeader.offsetHeight;
matrixCanvas.width = matrixHeader.offsetWidth;

var letters = Array(256).join(1).split('');

function drawMatrix() {
    matrixCanvas.getContext('2d').fillStyle='rgba(0,0,0,.05)';
    matrixCanvas.getContext('2d').fillRect(0,0,matrixCanvas.width,matrixCanvas.height);
    matrixCanvas.getContext('2d').fillStyle='#0F0';
    letters.map(function(y_pos, index){
        text = String.fromCharCode(3e4+Math.random()*33);
        x_pos = index * 10;
        matrixCanvas.getContext('2d').fillText(text, x_pos, y_pos);
        letters[index] = (y_pos > 758 + Math.random() * 1e4) ? 0 : y_pos + 10;
    });
}
setInterval(drawMatrix, 33);
