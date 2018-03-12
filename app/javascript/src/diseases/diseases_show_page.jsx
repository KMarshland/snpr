import React from 'react'
import PropTypes from 'prop-types'
import Immutable from "immutable";
import DiseaseSummary from "./disease_summary";
import DiseaseSNPs from "./disease_snps";
import DiseaseSources from "./disease_sources";
import DiseaseVennDiagram from "./disease_venn_diagram";

export default class DiseaseShowPage extends React.PureComponent {

    render() {
        return (
            <div>
                <DiseaseSummary disease={this.props.disease}/>

                <div className="row">
                    <div className="col-md-6">
                        <DiseaseSources disease={this.props.disease}/>
                    </div>
                    <div className="col-md-6">
                        <DiseaseSNPs disease={this.props.disease}/>
                    </div>
                </div>

                <DiseaseVennDiagram disease={this.props.disease} />
            </div>
        )
    }

}

DiseaseShowPage.propTypes = {
    disease: PropTypes.instanceOf(Immutable.Map).isRequired
};

