export default function readConfig(store) {

    (function getDocument() {
        store.dispatch({
            type: 'SET_DOCUMENT',
            document: window.backend_document
        });
    })();

    (function getSources() {
        store.dispatch({
            type: 'SET_SOURCES',
            sources: window.sources
        });
    })();

}