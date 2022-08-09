import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import data from '../data';
import OwlCarousel from 'react-owl-carousel';
import 'owl.carousel/dist/assets/owl.carousel.css';
import 'owl.carousel/dist/assets/owl.theme.default.css';
class Products extends Component {
    state = {}
    styles = {
        productsContainer: { marginTop: 20, justifyContent: 'space-between' },
        product: { width: '15rem', marginBottom: 10,  color: '#000', textDecoration: 'none' },
        productImg: { width: '100%', objectFit: 'cover', height:130},
        productBody: { marginTop: 5 }
    }
    render() {
        return (
            <div style={this.styles.productsContainer}>
                {Object.values(data).map((cat, i) => {
                    let category = Object.keys(data)[i];
                    return (
                        <div class='bg-white p-2 mb-4'>
                            <h3 key={i} style={{textTransform:'capitalize'}}>{category}</h3>
                            <OwlCarousel dots={false} margin={10} nav responsive={{
                                0  :  {items : 1, nav:false},
                                300:  {items : 2, nav:false},
                                750:  {items : 3, nav:false},
                                950: {items : 4},
                                1200: {items : 5},
                                1400: {items : 6},
                            }}>
                                {cat.map(product => {
                                    return (
                                        <Link to={'/' + product.title.replaceAll(' ', '-')} key={product.id} className='product' style={this.styles.product}>
                                            <img src={product.image} className='product-img' style={this.styles.productImg} alt='...' />
                                            <div className='product-body'>
                                                <h5 className='product-title' style={this.styles.productBody}>{product.title}</h5>
                                                <p className='product-text'>{product.description}</p>
                                            </div>
                                        </Link>
                                    )
                                })}
                            </OwlCarousel>
                        </div>
                    )
                })}
            </div>
        );
    }
}

export default Products;