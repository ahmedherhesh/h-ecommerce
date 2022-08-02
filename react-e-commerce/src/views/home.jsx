import React, { Component } from 'react';
import Products from '../components/products';
import Carousel from '../components/layout/carousel';

class Home extends Component {
    state = {}
    render() {
        return (
            <div className='container'>
                <Carousel/>
                <Products/>
            </div>
        )
    }
}

export default Home;