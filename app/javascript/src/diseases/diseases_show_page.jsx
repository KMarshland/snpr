import React from 'react'
import PropTypes from 'prop-types'
import Immutable from "immutable";
import SummaryRow from "../helpers/summary_row";

export default class DiseaseShowPage extends React.PureComponent {

    render() {
        return (
            <div className="panel panel-default">
                <div className="panel-body">
                    <SummaryRow
                        label="Name"
                        value={this.props.disease.get('name')}
                    />
                    <SummaryRow
                        label="Short form"
                        value={this.props.disease.get('short_form')}
                    />
                    <SummaryRow
                        label="Associated SNPs"
                        value={this.props.disease.get('snps')}
                    />
                </div>
            </div>
        )
    }

}

DiseaseShowPage.propTypes = {
    disease: PropTypes.instanceOf(Immutable.Map).isRequired
};

