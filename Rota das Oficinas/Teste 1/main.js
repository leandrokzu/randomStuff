function toArabic() {
    const roman = document.querySelector('#romanInput').value.toUpperCase();
    const newRoman = roman.split("");

    let erro = 0;
    newRoman.forEach(function (item, index) {
        switch (item) {
            case 'I':
                newRoman[index] = 1;
                break;
            case 'V':
                newRoman[index] = 5;
                break;
            case 'X':
                newRoman[index] = 10;
                break;
            case 'L':
                newRoman[index] = 50;
                break;
            case 'C':
                newRoman[index] = 100;
                break;
            case 'D':
                newRoman[index] = 500;
                break;
            case 'M':
                newRoman[index] = 1000;
                break;
            default:
                erro++;
                break;
        }
    });

    if (erro) {
        alert("Caractere inválido, tente novamente.");
    } else {

        let num = newRoman[0];
        for (let i = 1; i < newRoman.length; i++) {
            let currentNum = newRoman[i];
            let previousNum = newRoman[i - 1];

            if (currentNum <= previousNum) {
                num += currentNum;
            } else {
                num = num - previousNum * 2 + currentNum;
            }
        }

        document.querySelector('#arabicInput').value = num;
    }
}

function toRoman() {
    const romanChars = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
    const arabicChars = ["1000", "900", "500", "400", "100", "90", "50", "40", "10", "9", "5", "4", "1"];

    let arabic = document.querySelector('#arabicInput').value;

    if (arabic > 3999 || arabic < 1) alert("Número inválido, tente novamente.");

    let num = '';
    let i = 0;
    while (arabic > 0) {
        if (arabic - arabicChars[i] >= 0) {
            num += romanChars[i];
            arabic -= arabicChars[i];
        } else {
            i++;
        }
    }

    document.querySelector('#romanInput').value = num;
}
