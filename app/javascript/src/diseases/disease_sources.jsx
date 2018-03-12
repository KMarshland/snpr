import React from 'react'
import PropTypes from 'prop-types'
import Immutable from "immutable";
import DiseaseVennDiagram from "./disease_venn_diagram";

export default class DiseaseSources extends React.PureComponent {

    render() {
        const sources = this.props.disease.get('sources');

        return (
            <div className="panel panel-default">
                <div className="panel-heading">
                    Tracked by
                </div>
                <div className="panel-body">
                    <ul>
                        {sources.map(function (source, i) {
                            return (
                                <li key={i}>
                                    <a href={'/sources/' + source.id}>
                                        {source.name}
                                    </a>
                                </li>
                            )
                        })}
                    </ul>

                    <DiseaseVennDiagram disease={this.props.disease} />
                </div>
            </div>
        )
    }

}

DiseaseSources.propTypes = {
    disease: PropTypes.instanceOf(Immutable.Map).isRequired
};

