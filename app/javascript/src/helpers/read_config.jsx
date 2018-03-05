export default function readConfig(store) {

    (function getDocument() {
        store.dispatch({
            type: 'SET_DOCUMENT',
            document: window.backend_document
        });
    })();
    
    (function getDisease() {
        store.dispatch({
            type: 'SET_DISEASE',
            disease: window.disease
        });
    })();

    (function getSources() {
        store.dispatch({
            type: 'SET_SOURCES',
            sources: window.sources
        });

        store.dispatch({
            type: 'SET_SOURCE',
            source: window.source
        });
    })();

}