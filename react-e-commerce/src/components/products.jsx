import React, { Component } from "react";
import { Link } from "react-router-dom";
import data from "../data";
import OwlCarousel from "react-owl-carousel";
import "owl.carousel/dist/assets/owl.carousel.css";
import "owl.carousel/dist/assets/owl.theme.default.css";
import { MdOutlineFavoriteBorder } from "react-icons/md";
class Products extends Component {
  state = {};
  styles = {
    productsContainer: {marginTop: 20},
    product: {
      marginBottom: 10,
      color: "#000",
      textDecoration: "none",
      backgroundColor:'#000 !important',
      borderRadius:'10px',
      overflow:'hidden',
    },
    productImg: { width: "100%", objectFit: "cover", height: 130 },
    productBody: { marginTop: 5 ,padding: '0 10px'},
  };
  render() {
    return (
      <div style={this.styles.productsContainer}>
        {Object.values(data).map((cat, i) => {
          let category = Object.keys(data)[i];
          return (
            <div key={++i} className="">
              <h3 key={i} style={{ textTransform: "capitalize" }}>
                {category}
              </h3>
              <OwlCarousel
                className="home-products"
                dots={false}
                margin={10}
                nav
                responsive={{
                  0: { items: 1, nav: false },
                  200: { items: 2, nav: false },
                  300: { items: 2, nav: false },
                  400: { items: 3, nav: false },
                  500: { items: 4, nav: false },
                  760: { items: 5, nav: false },
                  950: { items: 6 },
                  1200: { items: 7 },
                  1400: { items: 8 },
                }}
              >
                {cat.map((product) => {
                  return (
                    <Link
                      to={"/" + product.title.replaceAll(" ", "-")}
                      key={product.id}
                      className="product"
                      style={this.styles.product}
                    >
                      <img
                        src={product.image}
                        className="product-img"
                        style={this.styles.productImg}
                        alt="..."
                      />
                      <div className="product-body" style={this.styles.productBody}>
                        <h5 className="product-title">
                          {product.title}
                        </h5>
                        <div className="d-flex justify-content-between">
                          <p className="product-price">{product.price}</p>
                          <MdOutlineFavoriteBorder className="" />
                        </div>
                      </div>
                    </Link>
                  );
                })}
              </OwlCarousel>
            </div>
          );
        })}
      </div>
    );
  }
}

export default Products;
