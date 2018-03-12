
/*
 * Returns the power set of an array
 * Does not include the empty set, which is properly part of all power sets
 */
export default function powerSet(array) {
    return powerSetIncludingEmptySet(array).filter(function (set) {
        return set.length > 0;
    });
}

/*
 * Returns the power set of an array
 */
function powerSetIncludingEmptySet(array) {
    if (array.length === 0) {
        return [
            []
        ];
    }

    let powerset = [
        []
    ];

    for (let i = 0; i < array.length; i++) {
        const subPowerSet = powerSetIncludingEmptySet(array.slice(i+1));

        for (let j = 0; j < subPowerSet.length; j++) {
            powerset.push([array[i]].concat(subPowerSet[j]));
        }
    }

    return powerset;
}
