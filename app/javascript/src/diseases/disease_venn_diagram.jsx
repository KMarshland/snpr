import React from 'react'
import PropTypes from 'prop-types'
import Immutable from "immutable";
import VennDiagram from "../helpers/venn_diagram";


export default class DiseaseVennDiagram extends React.PureComponent {

    render() {
        return (
            <VennDiagram/>
        )
    }

}

DiseaseVennDiagram.propTypes = {
    disease: PropTypes.instanceOf(Immutable.Map).isRequired
};

