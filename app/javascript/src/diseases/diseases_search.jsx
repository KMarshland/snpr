import React from 'react'
import PropTypes from 'prop-types'

export default class DiseaseSearch extends React.PureComponent {

    constructor(props) {
        super(props);

        this.state = {
            query: '',
            diseases: [],
            candidates: []
        };

        this.fetchDiseases();
        this.onType = this.onType.bind(this)
    }

    fetchDiseases() {
        $.ajax({
            url: '/diseases.json',
            success: (function (result) {
                console.log(result);

                this.setState({diseases: result.diseases})
            }).bind(this)
        });
    }

    onType() {
        if (this.searchTimeout) {
            clearTimeout(this.searchTimeout);
        }

        const query = this.refs.search.value;

        this.setState({
            query: query
        });

        if (!this.state.diseases.length || query.length < 3) {
            this.searchTimeout = setTimeout(this.onType.bind(this), 250);
            this.setState({
                candidates: []
            });

            return;
        }

        let candidates = [];

        for (let i = 0; i < this.state.diseases.length; i++) {
            const disease = this.state.diseases[i];

            if (disease.name.indexOf(query) !== -1 || query.indexOf(disease.name) !== -1) {
                candidates.push(disease)
            }
        }

        this.setState({
            candidates: candidates
        })
    }

    render() {
        return (
            <div className="disease-search">
                <input className="form-control main-search"
                       placeholder="Search for a disease..."
                       ref="search"
                       onChange={this.onType}
                       value={this.props.query}
                />

                <div>
                    {this.state.candidates.map(function (disease, i) {
                        const link = '/diseases/' + disease.short_form;
                        return (
                            <div className="search-result" key={i} onClick={() => {window.location = link}}>
                                <a href={link}>
                                    {disease.name}
                                </a>
                            </div>
                        )
                    })}
                </div>
            </div>
        )
    }

}

DiseaseSearch.propTypes = {
};

