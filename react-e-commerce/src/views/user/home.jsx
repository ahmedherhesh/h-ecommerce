import React, { Component } from "react";
import Products from "../../components/products";
import Carousel from "../../components/layout/carousel";
import phone from '../../assets/images/phone.png';

class Home extends Component {
  state = {};
  style = {
    subSection: {
      boxShadow: "1px 1px 2px #ddd",
      borderRadius: '10px',
      overflow: 'hidden'
    },
    subSectionImg: {
      width: '100%',
      height: '400px',
    }
  };
  render() {
    return (
      <div className="container">
        <div className="row mt-3">
          <div className="bg-dark sub-section" style={{ ...this.style.subSection, flex: 1 }}>
            <img src={phone} style={this.style.subSectionImg} />
          </div>
          <div className="p-0 ms-1 me-1 " style={{ ...this.style.subSection, flex: 3 }}>
            <Carousel />
          </div>
          <div className="bg-dark sub-section" style={{ ...this.style.subSection, flex: 1 }}>
            <img src={phone} style={this.style.subSectionImg} />
          </div>
        </div>
        <Products />
      </div>
    );
  }
}

export default Home;
