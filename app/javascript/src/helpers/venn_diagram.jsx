import React from 'react'
import PropTypes from 'prop-types'
import Immutable from 'immutable'

export default class VennDiagram extends React.PureComponent {

    constructor(props) {
        super(props);

        this.id = 'venn-' + Math.floor(Math.random() * Math.pow(36, 12)).toString(36);
        this.selector = '#' + this.id;

        this.draw();
    }

    draw() {
        if (this.drawTimeout) {
            clearTimeout(this.drawTimeout);
        }

        const el = $(this.selector);

        if (!el.is(':visible')) {
            this.drawTimeout = setTimeout(this.draw.bind(this), 50);
            return;
        }

        const sets = this.props.sets.toJS();

        const chart = venn.VennDiagram().width(el.width());
        const div = d3.select(this.selector).datum(sets).call(chart);

        let smallestSize = Infinity;
        let smallestIndex = 0;

        for (let i = 0; i < sets.length; i++) {
            if (sets[i].size < smallestSize) {
                smallestSize = sets[i].size;
                smallestIndex = i;
            }
        }

        venn.sortAreas(div, sets[smallestIndex]);

        // style code pulled from http://bl.ocks.org/bessiec/986e971203b4b8ddc56d3d165599f9d0
        div.selectAll("text").style("fill", "white");
        div.selectAll(".venn-circle path")
            .style("fill-opacity", .8)
            .style("stroke-width", 1)
            .style("stroke-opacity", 1)
            .style("stroke", "fff");

        const tooltip = d3.select(this.selector).append("div")
            .attr("class", "venntooltip");


        const labeler = this.props.labeler;

        div.selectAll("g")
            .on("mouseover", function(d, i) {
                // sort all the areas relative to the current item
                venn.sortAreas(div, d);

                // Display a tooltip with the current size
                tooltip.transition().duration(40).style("opacity", 1);
                if (labeler) {
                    tooltip.text(labeler(d));
                } else {
                    tooltip.text(d.size);
                }

                // highlight the current path
                // highlight the current path
                var selection = d3.select(this).transition("tooltip").duration(400);
                selection.select("path")
                    .style("stroke-width", 3)
                    .style("fill-opacity", d.sets.length == 1 ? .8 : 0)
                    .style("stroke-opacity", 1);
            })

            .on("mousemove", function() {
                tooltip.style("left", (d3.event.pageX - 128) + "px")
                    .style("top", (d3.event.pageY - 350) + "px");
            })

            .on("mouseout", function(d, i) {
                tooltip.transition().duration(2000).style("opacity", 0);
                var selection = d3.select(this).transition("tooltip").duration(400);
                selection.select("path")
                    .style("stroke-width", 3)
                    .style("fill-opacity", d.sets.length == 1 ? .8 : 0)
                    .style("stroke-opacity", 1);
            });
    }

    render() {
        return (<div id={this.id}>

        </div>)
    }

}

VennDiagram.propTypes = {
    sets: PropTypes.instanceOf(Immutable.List).isRequired, // should look like [{sets: ['A', 'B'], size: 4}]
    labeler: PropTypes.func
};

