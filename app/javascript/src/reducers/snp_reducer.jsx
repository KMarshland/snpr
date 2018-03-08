import Immutable from 'immutable'

export default function SnpReducer(state, action) {
    if (state === undefined) {
        state = null;
    }

    if (action.type === 'SET_SNP') {
        if (action.snp) {
            state = new Immutable.Map(action.snp);
        } else {
            state = null;
        }
    }

    return state;
}