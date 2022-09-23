import React, { Component } from "react";
import Products from "../../components/products";
import Carousel from "../../components/layout/carousel";

class Home extends Component {
  state = {};
  style = {
    boxShadow: "1px 1px 2px #ddd",
    borderRadius:'10px',
    overflow:'hidden'
  };
  render() {
    return (
      <div className="container">
        <div className="row mt-3">
          <div className="bg-dark sub-section" style={{...this.style,flex:1}}></div>
          <div className="p-0 m-1" style={{...this.style,flex:3}}>
            <Carousel />
          </div>
          <div className="bg-dark sub-section" style={{...this.style,flex:1}}></div>
        </div>
        <Products />
      </div>
    );
  }
}

export default Home;
