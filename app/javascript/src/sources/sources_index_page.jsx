import React from 'react'
import PropTypes from 'prop-types'
import Immutable from "immutable";
import SourcesIndexRow from "./sources_index_row";

export default class SourcesIndexPage extends React.PureComponent {

    render() {
        return (
            <table className="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>Source</th>
                    <th>Document count</th>
                    <th>SNP count</th>
                </tr>
                </thead>

                <tbody>
                {
                    this.props.sources.map(function (source, i) {
                        return <SourcesIndexRow
                            key={i}
                            source={source}
                        />
                    }).toArray()
                }
                </tbody>
            </table>
        )
    }

}

SourcesIndexPage.propTypes = {
    sources: PropTypes.instanceOf(Immutable.OrderedMap).isRequired
};

