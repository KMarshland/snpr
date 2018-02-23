
import React from 'react'
import ReactDOM from 'react-dom'
import { connect, Provider } from 'react-redux'

import store from './store'
import readConfig from './helpers/read_config'

import DocumentShowPage from "./documents/document_show_page";
import SourcesIndexPage from "./sources/sources_index_page";


let pages = {
    'document-show': DocumentShowPage,
    'source-index': SourcesIndexPage
};

document.addEventListener('turbolinks:load', () => {

    const root = document.getElementById('react-root');

    if (!root) {
        return;
    }

    const pageName = root.getAttribute('data-page');

    if (!pageName || !pages[pageName]) {
        return;
    }

    const page = pages[pageName];

    readConfig(store);

    const Connection = connect(function (store) {
        return store;
    })(page);

    ReactDOM.render(
        <Provider store={store}>
            <Connection />
        </Provider>,
        document.getElementById('react-root')
    );
});
