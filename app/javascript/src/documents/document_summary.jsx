import React from 'react'
import PropTypes from 'prop-types'
import Immutable from 'immutable'
import DocumentSummaryRow from "./document_summary_row";

export default class DocumentSummary extends React.PureComponent {

    render() {
        return (
            <div className="panel panel-default">
                <div className="panel-body">
                    <DocumentSummaryRow
                        label="Source"
                        value={this.props.document.get('source')}
                    />
                    <DocumentSummaryRow
                        label="File URL"
                        value={this.props.document.get('file_url')}
                    />
                    <DocumentSummaryRow
                        label="External ID"
                        value={this.props.document.get('external_id')}
                    />
                </div>
            </div>
        )
    }

}

DocumentSummary.propTypes = {
    document: PropTypes.instanceOf(Immutable.Map).isRequired
};

