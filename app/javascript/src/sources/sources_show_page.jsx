import React from 'react'
import PropTypes from 'prop-types'
import Immutable from "immutable";
import SummaryRow from "../helpers/summary_row";
import numberWithCommas from "../helpers/number_with_commas";

export default class SourcesShowPage extends React.PureComponent {

    render() {
        return (
            <div>
                <div className="panel panel-default">
                    <div className="panel-body">
                        <SummaryRow
                            label="Name"
                            value={this.props.source.get('name')}
                        />
                        <SummaryRow
                            label="Documents"
                            value={this.props.source.get('documents')}
                        />
                        <SummaryRow
                            label="SNPs"
                            value={numberWithCommas(this.props.source.get('snps'))}
                        />
                    </div>
                </div>
            </div>
        )
    }

}

SourcesShowPage.propTypes = {
    source: PropTypes.instanceOf(Immutable.Map).isRequired
};

