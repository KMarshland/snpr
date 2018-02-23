import Immutable from 'immutable'

export default function SourceReducer(state, action) {
    if (state === undefined) {
        state = null;
    }

    if (action.type === 'SET_SOURCE') {
        if (action.source) {
            state = Immutable.Map(action.source)
        } else {
            state = null;
        }
    }

    return state;
}