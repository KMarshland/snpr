import React from 'react'
import PropTypes from 'prop-types'
import Immutable from "immutable";
import VennDiagram from "../helpers/venn_diagram";
import powerSet from "../helpers/power_set";


export default class DiseaseVennDiagram extends React.PureComponent {

    labeler(d) {
        return d.names.join(', ') + ': ' +
            d.size + '/' + this.props.disease.get('snps').length +
            ' SNPs';
    }

    render() {
        let sourceNames = {
            0: 'Relevant SNPs'
        };

        this.props.disease.get('sources').map(function (source) {
            sourceNames[source.id] = source.name;
        });

        // create a mapping from each snp to an array of the sources that track it
        let by_snp = {};
        const snps_source = this.props.disease.get('snps_source');
        for (let i = 0; i < snps_source.length; i++) {
            const snp_id = snps_source[i].snp_id;

            if (!by_snp[snp_id]) {
                if (this.props.includeOuter) {
                    by_snp[snp_id] = [0];
                } else {
                    by_snp[snp_id] = [];
                }
            }

            by_snp[snp_id].push(snps_source[i].source_id);
        }

        // Figure out the sizes of each set
        // in this case, make the key a comma separated array of source ids, and the value the count seen
        let setSizes = {};

        for (let snp_id in by_snp) {
            // enumerate the power set of the keys

            const source_variations = powerSet(by_snp[snp_id]);

            for (let i = 0; i < source_variations.length; i++) {
                const source_variation = source_variations[i];

                const key = source_variation.sort().join(',');

                if (!setSizes[key]) {
                    setSizes[key] = 0;
                }

                setSizes[key]++;
            }
        }

        // build sets suitable for use in the venn diagram
        let sets = [];

        for (let key in setSizes) {
            const names = key.split(',').map(function (id) {
                return sourceNames[id]
            });

            sets.push({
                sets: names.map(function (name) {
                    return 'In ' + name
                }),
                names: names,
                size: setSizes[key]
            })
        }
        
        return (
            <VennDiagram
                sets={Immutable.List(sets)}
                labeler={this.labeler.bind(this)}
            />
        )
    }

}

DiseaseVennDiagram.propTypes = {
    disease: PropTypes.instanceOf(Immutable.Map).isRequired,
    includeOuter: PropTypes.bool
};

