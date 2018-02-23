import React from 'react'
import PropTypes from 'prop-types'

export default class DocumentSummaryRow extends React.PureComponent {

    render() {
        return (
            <div className="row">
                <div className="col-sm-2 text-right">
                    {this.props.label}
                </div>
                <div className="col-sm-10 text-bold">
                    {this.props.value}
                </div>
            </div>
        )
    }

}

DocumentSummaryRow.propTypes = {
    label: PropTypes.string.isRequired,
    value: PropTypes.oneOfType([
        PropTypes.number,
        PropTypes.string
    ]).isRequired
};

