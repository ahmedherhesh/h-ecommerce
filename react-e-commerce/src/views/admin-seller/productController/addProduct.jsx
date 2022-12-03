import React, { Component } from "react";
import axios from '../../../axios';

class AddProduct extends Component {
    state = {
        categories: [],
        brands: []
    };
    style = {
        form: {
            maxWidth: 1000,
            margin: 'auto'
        },
        label: {
            fontSize: 16,
            fontWeight: 'bold',
            marginBottom: 5,
            userSelect: 'none'
        },
        title: {
            border: '1px solid #000',
            padding: 10,
            borderRadius: 10,
            borderTopLeftRadius: 0,
            borderBottomRightRadius: 0,
        }

    };
    async getCategories() {
        let { data: categories } = await axios.get('categories');
        this.setState({ categories });
    }
    async getBrands() {
        let { data: brands } = await axios.get('brands');
        this.setState({ brands });
    }
    async handleSubmit(e) {
        e.preventDefault();
        let fields = [
            ...document.querySelectorAll('#addProduct input'),
            ...document.querySelectorAll('#addProduct select'),
            ...document.querySelectorAll('#addProduct textarea')
        ];

        let data = new FormData();
        fields.forEach(field => field.id ? data.append(field.id, field.value) : data.append('images[]', field.files[0]));

        let res = await axios.post('product/create', data);
        console.log(res);
    }
    componentDidMount() {
        this.getCategories();
        this.getBrands();
    }
    render() {
        return (
            <React.Fragment>
                <div className="container">
                    <form onSubmit={this.handleSubmit} id="addProduct" style={this.style.form} encType='multipart/form-data'>
                        <div className="title text-center">
                            <h3 style={this.style.title} className="mb-4 m-2 d-inline-block">Add Product</h3>
                        </div>
                        <div className="row form-content">
                            <div className="product-details col-6">
                                <div className="form-group">
                                    <label style={this.style.label} htmlFor="title">Product title</label>
                                    <input type='text' maxLength={16} className="product-title form-control" id="title" />
                                </div>
                                <div>
                                    <label style={this.style.label} htmlFor="category_id">Category</label>
                                    <select className="category form-select" id="category_id">
                                        <option value=""></option>
                                        {this.state.categories.map(cat => <option key={cat.id} value={cat.id}>{cat.name}</option>)}
                                    </select>
                                </div>
                                <div>
                                    <label style={this.style.label} htmlFor="brand_id">Brand</label>
                                    <select className="brands form-select" id="brand_id">
                                        <option value=""></option>
                                        {this.state.brands.map(brand => <option key={brand.id} value={brand.id}>{brand.name}</option>)}
                                    </select>
                                </div>
                                <div>
                                    <label style={this.style.label} htmlFor="description">Description</label>
                                    <textarea className="description d-block form-control" id="description" cols="30" rows="5"></textarea>
                                </div>
                                <div className="form-group">
                                    <label style={this.style.label} htmlFor="price">Product price</label>
                                    <input type='number' className="product-price form-control" id="price" />
                                </div>
                                <div className="form-group">
                                    <label style={this.style.label} htmlFor="stock">Stock</label>
                                    <input type='number' className="product-stock form-control" id="stock" />
                                </div>
                            </div>
                            <div className="product-gallery col-6">
                                <div className="mb-3">
                                    <label style={this.style.label} htmlFor="Images" className="form-label">Product Images</label>
                                    <input className="form-control image" type="file" data-name="images" />
                                </div>
                                <div className="mb-3">
                                    <input className="form-control image" type="file" data-name="images" />
                                </div>
                                <div className="mb-3">
                                    <input className="form-control image" type="file" data-name="images" />
                                </div>
                                <div className="mb-3">
                                    <input className="form-control image" type="file" data-name="images" />
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