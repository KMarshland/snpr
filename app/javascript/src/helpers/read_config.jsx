export default function readConfig(store) {

    (function getUser() {
        store.dispatch({
            type: 'SET_DOCUMENT',
            document: window.backend_document
        });
    })();

}