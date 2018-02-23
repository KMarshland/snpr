import React from 'react'
import PropTypes from 'prop-types'
import Immutable from "immutable";

import DocumentSummary from "./document_summary";
import DocumentImportMessage from "./document_import_message";

export default class DocumentShowPage extends React.PureComponent {

    render() {
        return (
            <div>
                <DocumentSummary document={this.props.document} sources={this.props.sources} />

                {
                    !this.props.document.get('imported') &&
                    <DocumentImportMessage />
                }
            </div>
        )
    }

}

DocumentShowPage.propTypes = {
    document: PropTypes.instanceOf(Immutable.Map).isRequired,
    sources: PropTypes.instanceOf(Immutable.OrderedMap).isRequired
};

