import React from 'react';
import OwlCarousel from 'react-owl-carousel';
import 'owl.carousel/dist/assets/owl.carousel.css';
import 'owl.carousel/dist/assets/owl.theme.default.css';
import { useParams } from 'react-router-dom';
import moto from 'D:/Mix/backgrounds/moto.jpg';
import white_car from 'D:/Mix/backgrounds/white-car.jpg';
import orange_car from 'D:/Mix/backgrounds/orange-car.jpg';
import eye from 'D:/Mix/backgrounds/eye.jpg';
let changeMainImg = e => document.querySelector('.main-image').src = e.target.src;

let Product = () => {
    const { title } = useParams();
    return (
        <div className="container mt-4">
            <div className="row product">
                <div className='row bg-white col-9'>
                    <div className="gallery col-4 text-center overflow-hidden">
                        <img src={moto} className="main-image mt-3" style={{width:300,height:300}} alt='' />
                        <div className="sub-images mt-3">
                            <OwlCarousel className="owl-theme" navElement items={5}>
                                <img onClick={changeMainImg}src={moto} className="sub-image" alt='' style={{width:50,height:50}}/>
                                <img onClick={changeMainImg}src={white_car} className="sub-image" alt='' style={{width:50,height:50}}/>
                                <img onClick={changeMainImg}src={moto} className="sub-image" alt='' style={{width:50,height:50}}/>
                                <img onClick={changeMainImg}src={orange_car} className="sub-image" alt='' style={{width:50,height:50}}/>
                                <img onClick={changeMainImg}src={eye} className="sub-image" alt='' style={{width:50,height:50}}/>
                            </OwlCarousel>
                        </div>
                    </div>
                    <div className='product-body col-8'>
                        <h3 className="title fs-5 fw-normal pt-3">
                            Samsung Galaxy A52 - 6.5 256GB/8GB Dual Sim Mobile Phone - Awesome White
                        </h3>
                        <p className='mb-2 brand'>Brand: Samsung | Similar products from Samsung</p>
                        <p className='mb-2 rating'>No ratings available</p><hr />
                        <p className="mb-2 price">EGP 8,490.00</p>
                        <p className="old-price d-inline-block"><s>EGP 8,990.00</s></p><span className='discount'>-6%</span>
                        <button className="add-to-cart btn-style d-block w-100 p-3 mt-3" >ADD TO CART</button>
                    </div>
                </div>
                <div className='bg-white col-3'></div>
            </div>
        </div>
    );
}

export default Product;