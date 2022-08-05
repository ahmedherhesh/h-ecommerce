import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import data from '../data';
class Products extends Component {
    state = {}
    styles = {
        productsContainer: {marginTop:20,justifyContent: 'space-between' },
        product: { width: '15rem', marginBottom: 10, borderRadius: 0, color: '#000', textDecoration: 'none'},
        productImg: { width: '100%' },
        productBody: { marginTop: 5 }
    }
    render() {
        return (
            <div className='row' style={this.styles.productsContainer}>
                {data.map(product => {
                    return (
                        <Link to={product.url} key={product.id} className='product' style={this.styles.product}>
                            <img src={product.image} className='product-img' style={this.styles.productImg} alt='...' />
                            <div className='product-body'>
                                <h5 className='product-title' style={this.styles.productBody}>{product.title}</h5>
                                <p className='product-text'>{product.description}</p>
                            </div>
                        </Link>
                    )
                })}
            </div>
        );
    }
}

export default Products;