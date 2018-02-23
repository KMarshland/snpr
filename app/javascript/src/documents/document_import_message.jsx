import React from 'react'

export default class DocumentImportMessage extends React.PureComponent {

    render() {
        return (
            <div className="text-center">
                <h2>Still importing</h2>
                <br />
                <i className="fa fa-spin fa-refresh fa-5x"/>
            </div>
        )
    }

}

DocumentImportMessage.propTypes = {

};

