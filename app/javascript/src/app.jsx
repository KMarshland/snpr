
import React from 'react'
import ReactDOM from 'react-dom'
import { connect, Provider } from 'react-redux'

import store from './store'
import readConfig from './helpers/read_config'

import DocumentShowPage from "./documents/document_show_page";
import SourcesIndexPage from "./sources/sources_index_page";
import SourcesShowPage from "./sources/sources_show_page";
import DiseaseShowPage from "./diseases/diseases_show_page";
import DiseaseSearch from "./diseases/diseases_search";
import SnpShowPage from "./snps/snp_show_page";


let pages = {
    'document-show': DocumentShowPage,
    'source-index': SourcesIndexPage,
    'source-show': SourcesShowPage,
    'disease-show': DiseaseShowPage,
    'disease-search': DiseaseSearch,
    'snp-show': SnpShowPage
};

document.addEventListener('turbolinks:load', () => {

    let roots = [];

    const byId = document.getElementById('react-root');
    if (byId) {
        roots.push(byId);
    }

    const byClass = document.getElementsByClassName('react-root');
    for (let i = 0; i < byClass.length; i++) {
        roots.push(byClass[i])
    }

    if (!roots.length) {
        return;
    }

    readConfig(store);

    for (let i = 0; i < roots.length; i++) {
        const root = roots[i];

        if (!root) {
            continue;
        }

        const pageName = root.getAttribute('data-page');

        if (!pageName || !pages[pageName]) {
            return;
        }

        const page = pages[pageName];

        const Connection = connect(function (store) {
            return store;
        })(page);

        ReactDOM.render(
            <Provider store={store}>
                <Connection/>
            </Provider>,
            root
        );
    }
});
