import React from 'react'
import PropTypes from 'prop-types'
import Immutable from 'immutable'
import SummaryRow from "../helpers/summary_row";

export default class DocumentSummary extends React.PureComponent {

    render() {
        const source = this.props.sources.get(this.props.document.get('source_id'));

        return (
            <div className="panel panel-default">
                <div className="panel-body">
                    <SummaryRow
                        label="Source"
                    >
                        <a href={'/sources/' + source.get('id')}>{source.get('name')}</a>
                    </SummaryRow>

                    <SummaryRow
                        label="File URL"
                    >
                        <a href={this.props.document.get('file_url')} target="_blank">{this.props.document.get('file_url')}</a>
                    </SummaryRow>
                    <SummaryRow
                        label="External ID"
                        value={this.props.document.get('external_id')}
                    />
                </div>
            </div>
        )
    }

}

DocumentSummary.propTypes = {
    document: PropTypes.instanceOf(Immutable.Map).isRequired,
    sources: PropTypes.instanceOf(Immutable.OrderedMap).isRequired
};

