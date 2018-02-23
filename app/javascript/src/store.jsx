import { createStore, combineReducers } from 'redux'

import DocumentReducer from "./reducers/document_reducer";

let store = createStore(combineReducers({
    document: DocumentReducer
}));

export default store;