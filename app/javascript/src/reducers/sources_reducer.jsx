import Immutable from 'immutable'

export default function SourcesReducer(state, action) {
    if (state === undefined) {
        state = Immutable.OrderedMap();
    }

    if (action.type === 'SET_SOURCES') {
        if (action.sources) {
            state = Immutable.OrderedMap(action.sources.map(function (source) {
                return [source.id, Immutable.Map(source)]
            }));
        } else {
            state = Immutable.OrderedMap();
        }
    }

    return state;
}