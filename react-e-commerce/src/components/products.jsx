import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import data from '../data';
class Products extends Component {
    state = {}
    render() {
        return (
            <div className="row container" style={{ margin: "50px auto", justifyContent: "space-around" }}>
                {data.map(product => {
                    return (
                        <div className="card" style={{ width: "15rem", marginBottom: 10, borderRadius: 0 }} >
                            <img src={product.image} className="card-img-top" alt="..." />
                            <div className="card-body">
                                <h5 className="card-title">{product.title}</h5>
                                <p className="card-text">{product.description}</p>
                                <Link to={product.url} className="btn btn-primary">Go somewhere</Link>
                            </div>
                        </div>
                    )
                })}
            </div>


        );;
    }
}

export default Products;