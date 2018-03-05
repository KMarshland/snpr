import Immutable from 'immutable'

export default function DiseaseReducer(state, action) {
    if (state === undefined) {
        state = null;
    }

    if (action.type === 'SET_DISEASE') {
        if (action.disease) {
            state = new Immutable.Map(action.disease);
        } else {
            state = null;
        }
    }

    return state;
}