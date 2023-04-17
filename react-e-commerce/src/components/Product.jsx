import React from 'react';
import OwlCarousel from 'react-owl-carousel';
import 'owl.carousel/dist/assets/owl.carousel.css';
import 'owl.carousel/dist/assets/owl.theme.default.css';
import { useParams } from 'react-router-dom';
import moto from '../assets/images/moto.jpg';
import white_car from '../assets/images/white-car.jpg';
import orange_car from '../assets/images/orange-car.jpg';

let changeMainImg = e => document.querySelector('.main-image').src = e.target.src;

let Product = () => {
    const { title } = useParams();
    return (
        <div className="container mt-4">
            <div className="row product">
                <div className='row bg-white col-12'>
                    <div className="gallery  col-sm-12 col-md-6 col-lg-4 text-center overflow-hidden">
                        {/* <img src={moto} className="main-image mt-3" style={{ width: 300, height: 300 }} alt='' /> */}
                        <div className="product-images">
                            <OwlCarousel nav dots={false} items={1} loop responsive={{
                                750:  { nav:true},
                            }}>
                                <img src={white_car} alt=''/>
                                <img src={moto} alt=''/>
                                <img src={orange_car} alt=''/>
                            </OwlCarousel>
                        </div>
                    </div>
                    <div className='product-body col-md-6 col-lg-8'>
                        <h3 className="title fs-5 fw-normal pt-3">
                            Samsung Galaxy A52 - 6.5 256GB/8GB Dual Sim Mobile Phone - Awesome White
                        </h3>
                        <p className='mb-2 brand'>Brand: Samsung | Similar products from Samsung</p>
                        <p className='mb-4 rating'>No ratings available</p><hr />
                        <p className="mt-4 mb-2 price">EGP 8,490 <sup className="old-price d-inline-block text-secondary">EGP 8,990</sup></p>
                        <button className="add-to-cart btn-style p-3 mt-3 mb-3 col-xs-12 col-md-6" >ADD TO CART</button>
                    </div>
                </div>
            </div>
        </div>
    );
}

export default Product;