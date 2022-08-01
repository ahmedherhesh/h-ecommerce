import './App.css';
import Home from './views/home';
import Login from './views/auth/login';
import Register from './views/auth/register';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import NavBar from './layout/navbar';
import React from 'react';

function App() {
  return (
    <BrowserRouter>
      <NavBar />
      <Routes>
        <Route path='/' element={<Home />} />
        <Route path='/login' element={<Login />} />
        <Route path='/register' element={<Register />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
