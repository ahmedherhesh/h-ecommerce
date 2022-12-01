import React from 'react';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import './App.css';
import NavBar from "./components/layout/navbar"
import Home from './views/user/home';
import Cart from './views/user/cart';
import Product from './components/Product';
import Login from './views/auth/login';
import Register from './views/auth/register';
import Favorite from './views/user/favorite';
import AddProduct from './views/admin-seller/productController/addProduct';

function App() {
  let sellerPrefix = 'seller';
  return (
    <BrowserRouter>
      <NavBar />
      <Routes >
        {/* all users */}
        <Route path='/login' element={<Login />} />
        <Route path='/register' element={<Register />} />
        <Route path='/' element={<Home />} />
        <Route path='/:title' element={<Product />} />
        {/* customer */}
        <Route path='/cart' element={<Cart />} />
        <Route path='/favorite' element={<Favorite />} />
        {/* admin or seller */}
        <Route path={sellerPrefix + '/add-product'} element={<AddProduct/>}/>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
