import React from 'react'
import PropTypes from 'prop-types'
import Immutable from "immutable";
import SummaryRow from "../helpers/summary_row";

export default class DiseaseSummary extends React.PureComponent {

    render() {
        const link = 'https://www.ebi.ac.uk/gwas/search?query=' + this.props.disease.get('short_form');

        return (
            <div className="panel panel-default">
                <div className="panel-heading">
                    {this.props.disease.get('name')}
                </div>
                <div className="panel-body">
                    <SummaryRow
                        label="Short form"
                        value={this.props.disease.get('short_form')}
                    />
                    <SummaryRow
                        label="Associated SNPs"
                        value={this.props.disease.get('snps').length}
                    />

                    <SummaryRow label="">
                        <a href={link} target="_blank">Read more in the GWAS catalog</a>
                    </SummaryRow>
                </div>
            </div>
        )
    }

}

DiseaseSummary.propTypes = {
    disease: PropTypes.instanceOf(Immutable.Map).isRequired
};

