import React from 'react'
import PropTypes from 'prop-types'
import Immutable from "immutable";

export default class DiseaseSNPs extends React.PureComponent {

    render() {
        const snps = this.props.disease.get('snps');

        return (
            <div className="panel panel-default">
                <div className="panel-heading">
                    Associated SNPs
                </div>
                <div className="panel-body">
                    <ul>
                        {snps.map(function (snp, i) {
                            return (
                                <li key={i}>
                                    <a href={'/snps/' + snp.rsid}>
                                        {snp.rsid}
                                    </a>
                                </li>
                            )
                        })}
                    </ul>
                </div>
            </div>
        )
    }

}

DiseaseSNPs.propTypes = {
    disease: PropTypes.instanceOf(Immutable.Map).isRequired
};

