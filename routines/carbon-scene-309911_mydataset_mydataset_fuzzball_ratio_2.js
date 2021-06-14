
let options = {full_process:false}

result = fuzzball.ratio(str_1, str_2, options)

if (result === 100) {
        return `STRING "${str_1}" matches with STRING "${str_2}"`
    } else {
        return `STRING "${str_1}" does not match with STRING "${str_2}"`
    }


