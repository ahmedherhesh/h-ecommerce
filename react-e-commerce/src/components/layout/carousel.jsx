import React, { Component } from 'react';
import moto from 'D:/Mix/backgrounds/moto.jpg';
import white_car from 'D:/Mix/backgrounds/white-car.jpg';
import orange_car from 'D:/Mix/backgrounds/orange-car.jpg';
class Carousel extends Component {
    state = {}

    render() {
        return (
            <div id="carouselExampleIndicators" className="carousel slide overflow-hidden" data-bs-ride="carousel" style={{ maxHeight: 500 }}>
                <div className="carousel-indicators">
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" className="active" aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                </div>
                <div className="carousel-inner">
                    <div className="carousel-item active">
                        <img className='w-100' src={white_car} alt="" style={{height:500,objectFit:'cover'}}/>
                    </div>
                    <div className="carousel-item">
                        <img className='w-100' src={moto} alt="" style={{height:500,objectFit:'cover'}}/>
                    </div>
                    <div className="carousel-item">
                        <img className='w-100' src={orange_car} alt="" style={{height:500,objectFit:'cover'}}/>
                    </div>
                </div>
                <button className="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                    <span className="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span className="visually-hidden">Previous</span>
                </button>
                <button className="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                    <span className="carousel-control-next-icon" aria-hidden="true"></span>
                    <span className="visually-hidden">Next</span>
                </button>
            </div>
        );
    }
}

export default Carousel;