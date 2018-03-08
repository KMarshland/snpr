import React from 'react'
import PropTypes from 'prop-types'
import Immutable from "immutable";
import SummaryRow from "../helpers/summary_row";

export default class SnpShowPage extends React.PureComponent {

    constructor(props) {
        super(props);

        this.state = {
            diseases: [],
            sources: []
        };

        this.fetchInformation();
    }

    fetchInformation() {
        $.ajax({
            url: '/snps/' + this.props.snp.get('rsid') + '.json',
            success: (function (result) {
                this.setState(result.snp)
            }).bind(this)
        });
    }

    render() {
        return (
            <div className="panel panel-default">
                <div className="panel-heading">
                    SNP {this.props.snp.get('rsid')}
                </div>

                <div className="panel-body">
                    <SummaryRow label="RSID" value={this.props.snp.get('rsid')}/>

                    <SummaryRow label="Chromosome" value={this.props.snp.get('chromosome')}/>

                    <SummaryRow label="Position" value={this.props.snp.get('position')}/>

                    <br />

                    <SummaryRow label="Tracked by">
                        {
                            this.state.sources.length === 0 ?
                                <i>Untracked by any source</i> :
                                <ul>
                                    {
                                        this.state.sources.map(function (source, i) {
                                            return <li key={i}>
                                                <a href={'/sources/' + source.id}>{source.name}</a>
                                            </li>
                                        })
                                    }
                                </ul>
                        }
                    </SummaryRow>

                    <SummaryRow label="Associated diseases">
                        {
                            this.state.diseases.length === 0 ?
                                <i>None</i> :
                                <ul>
                                    {
                                        this.state.diseases.map(function (disease, i) {
                                            return <li key={i}>
                                                <a href={'/diseases/' + disease.short_form}>{disease.name}</a>
                                            </li>
                                        })
                                    }
                                </ul>
                        }
                    </SummaryRow>

                </div>
            </div>
        )
    }

}

SnpShowPage.propTypes = {
    snp: PropTypes.instanceOf(Immutable.Map).isRequired
};

