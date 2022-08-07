import React, { Component } from 'react';
import '../assets/css/cart.css';
import moto from '../moto.jpg';
import { FaAccusoft } from 'react-icons/fa';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'

class Cart extends Component {
    state = {}
    render() {
        return (
            <div className='container'>
                <div className="row" style={{ flexWrap: 'no-wrap' }}>
                    <div className="product row" style={{ flexWrap: 'no-wrap', backgroundColor: '#fff', flex: 3, justifyContent: 'space-between' }}>
                        <div className='row col' style={{ flex: 3 }}>
                            <img className='img ' src={moto} alt="" />
                            <h3 className="title col">
                                Samsung Galaxy A52 - 6.5 256GB/8GB Dual Sim Mobile Phone - Awesome White
                            </h3>
                        </div>
                        <div className="price-section col" style={{ flex: 1, textAlign: 'right' }}>
                            <p className="price">EGP 8,490.00</p>
                            <p className="old-price">EGP 8,990.00</p><span className='discount'> -6%</span>
                        </div>
                        <div className="row" style={{ flexWrap: 'no-wrap' ,justifyContent:'space-between'}}>
                            <span className="remove-btn col btn btn-danger"> <FontAwesomeIcon icon={['fab', 'apple']} />Remove</span>
                            <div className="counter col" style={{ textAlign: 'right' }}>
                                <span className="decrement btn btn-info">-</span>
                                <span className="increment btn btn-info m-1">+</span>
                            </div>
                        </div>
                    </div>
                    <div style={{ flex: 1 }}></div>
                </div>
            </div>
        )
    }
}

export default Cart;