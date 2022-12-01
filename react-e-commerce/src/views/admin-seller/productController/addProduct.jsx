import React, { Component } from "react";

class AddProduct extends Component {
    state = {};
    style = {
        form: {
            maxWidth: 1000,
            margin: 'auto'
        },
        label: {
            fontSize: 16,
            fontWeight: 'bold',
            marginBottom: 5,
            userSelect:'none'
        },
        title: {
            border: '1px solid #000',
            padding: 10,
            borderRadius: 10,
            borderTopLeftRadius: 0,
            borderBottomRightRadius: 0,
        }

    };
    render() {
        return (
            <React.Fragment>
                <div className="container">
                    <form id="addProduct" style={this.style.form}>
                        <div className="title text-center">
                            <h3 style={this.style.title} className="mb-4 m-2 d-inline-block">Add Product</h3>
                        </div>
                        <div className="row form-content">
                            <div className="product-details col-6">
                                <div className="form-group">
                                    <label style={this.style.label} htmlFor="productName">Product name</label>
                                    <input type='text' className="product-name form-control" id="productName" />
                                </div>
                                <div>
                                    <label style={this.style.label} htmlFor="cateogry">Category</label>
                                    <select className="category form-select" id="category">
                                        <option value=""></option>
                                        <option value="1">Cat 1</option>
                                        <option value="2">Cat 2</option>
                                        <option value="3">Cat 3</option>
                                    </select>
                                </div>
                                <div>
                                    <label style={this.style.label} htmlFor="brand">Brand</label>
                                    <select className="brand form-select" id="brand">
                                        <option value=""></option>
                                        <option value="1">Cat 1</option>
                                        <option value="2">Cat 2</option>
                                        <option value="3">Cat 3</option>
                                    </select>
                                </div>
                                <div>
                                    <label style={this.style.label} htmlFor="description">Description</label>
                                    <textarea className="description d-block form-control" id="description" cols="30" rows="5"></textarea>
                                </div>
                                <div className="form-group">
                                    <label style={this.style.label} htmlFor="productPrice">Product price</label>
                                    <input type='number' className="product-price form-control" id="productPrice" />
                                </div>
                                <div className="form-group">
                                    <label style={this.style.label} htmlFor="productStock">Stock</label>
                                    <input type='number' className="product-stock form-control" id="productStock" />
                                </div>
                            </div>
                            <div className="product-gallery col-6">
                                <div class="mb-3">
                                    <label style={this.style.label} for="productImages" class="form-label">Product Images</label>
                                    <input class="form-control" type="file" id="productImages" />
                                </div>
                                <div class="mb-3">
                                    <input class="form-control" type="file" id="productImages" />
                                </div>
                                <div class="mb-3">
                                    <input class="form-control" type="file" id="productImages" />
                                </div>
                                <div class="mb-3">
                                    <input class="form-control" type="file" id="productImages" />
                                </div>
                                <button className="btn btn-outline-success">Add Product</button>
                            </div>
                        </div>

                    </form>
                </div>
            </React.Fragment>
        )
    }
}
export default AddProduct;