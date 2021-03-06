import React from 'react'
import PropTypes from 'prop-types'
import Immutable from 'immutable'
import numberWithCommas from "../helpers/number_with_commas";

export default class SourcesIndexRow extends React.PureComponent {

    render() {
        return (
            <tr>
                <td>
                    <a href={'/sources/' + this.props.source.get('id')}>
                        {this.props.source.get('name')}
                    </a>
                </td>
                <td>{this.props.source.get('documents')}</td>
                <td>{numberWithCommas(this.props.source.get('snps'))}</td>
            </tr>
        )
    }

}

SourcesIndexRow.propTypes = {
    source: PropTypes.instanceOf(Immutable.Map).isRequired
};

