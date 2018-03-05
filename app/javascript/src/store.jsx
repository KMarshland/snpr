import { createStore, combineReducers } from 'redux'

import DocumentReducer from "./reducers/document_reducer";
import SourcesReducer from "./reducers/sources_reducer";
import SourceReducer from "./reducers/source_reducer";
import DiseaseReducer from "./reducers/disease_reducer";

let store = createStore(combineReducers({
    document: DocumentReducer,
    sources: SourcesReducer,
    source: SourceReducer,
    disease: DiseaseReducer
}));

window.store = store;

export default store;