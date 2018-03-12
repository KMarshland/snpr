
/*
 * Returns the power set of an array
 */
export default function powerSet(array) {

    if (array.length <= 1) {
        return [array];
    }

    let powerset = [
        [array[0]]
    ];

    for (let i = 0; i < array.length; i++) {
        const subPowerSet = powerSet(array.slice(i+1));

        for (let j = 0; j < subPowerSet.length; j++) {
            powerset.push([array[i]].concat(subPowerSet[j]));
        }
    }

    return powerset;
}

/*
function (array) {
    if (array.length <= 1) {
        return [array];
    }

    let powerset = [array];

    for (let i = 0; i < array.length; i++) {
        // the power set of it without that one index
        const subPowerSet = powerSet(array.slice(0, i).concat(array.slice(i + 1)));

        powerset = powerset.concat(subPowerSet)
    }

    return powerset;
}
*/
