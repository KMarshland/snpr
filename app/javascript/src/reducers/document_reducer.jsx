import Immutable from 'immutable'

export default function DocumentReducer(state, action) {
    if (state === undefined) {
        state = null;
    }

    if (action.type === 'SET_DOCUMENT') {
        if (action.document) {
            state = new Immutable.Map(action.document);
        } else {
            state = null;
        }
    }

    return state;
}