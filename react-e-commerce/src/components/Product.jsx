import React from 'react';
import OwlCarousel from 'react-owl-carousel';
import 'owl.carousel/dist/assets/owl.carousel.css';
import 'owl.carousel/dist/assets/owl.theme.default.css';
import { useParams } from 'react-router-dom';
import moto from '../moto.jpg';
import logo from '../logo.png';
import '../assets/css/product.css';

let changeMainImg = e => document.querySelector('.main-image').src = e.target.src;

let Product = () => {
    const { title } = useParams();
    return (
        <div className="container">
            <div className="row product">
                <div className='row left-col'>
                    <div className="gallery">
                        <img src={moto} className="main-image" alt='' />
                        <div className="sub-images">
                            <OwlCarousel className="owl-theme" loop navElement>
                                <img onClick={changeMainImg}src={moto} className="sub-image" alt='' />
                                <img onClick={changeMainImg}src={logo} className="sub-image" alt='' />
                                <img onClick={changeMainImg}src={moto} className="sub-image" alt='' />
                                <img onClick={changeMainImg}src={logo} className="sub-image" alt='' />
                                <img onClick={changeMainImg}src={moto} className="sub-image" alt='' />
                            </OwlCarousel>
                        </div>
                    </div>
                    <div className='product-body'>
                        <h3 className="title">
                            Samsung Galaxy A52 - 6.5 256GB/8GB Dual Sim Mobile Phone - Awesome White
                        </h3>
                        <p className='brand'>Brand: Samsung | Similar products from Samsung</p>
                        <p className='rating'>No ratings available</p>
                        <hr />
                        <p className="price">EGP 8,490.00</p>
                        <p className="old-price">EGP 8,990.00</p><span className='discount'>-6%</span>
                        <button className="add-to-cart btn btn-info">ADD TO CART</button>
                    </div>
                </div>
                <div className='right-col'></div>
            </div>
        </div>
    );
}

export default Product;