import React from 'react'
import PropTypes from 'prop-types'
import Immutable from 'immutable'

export default class VennDiagram extends React.PureComponent {

    constructor(props) {
        super(props);

        this.id = 'venn-' + Math.floor(Math.random() * Math.pow(36, 12)).toString(36);
        this.draw();
    }

    draw() {
        if (this.drawTimeout) {
            clearTimeout(this.drawTimeout);
        }

        if (!$('#' + this.id).is(':visible')) {
            this.drawTimeout = setTimeout(this.draw.bind(this), 50);
            return;
        }

        const sets = this.props.sets.toJS();

        const chart = venn.VennDiagram();
        d3.select('#' + this.id).datum(sets).call(chart);
    }

    render() {
        return (<div id={this.id}>

        </div>)
    }

}

VennDiagram.propTypes = {
    sets: PropTypes.instanceOf(Immutable.List).isRequired // should look like [{sets: ['A', 'B'], size: 4}]
};

