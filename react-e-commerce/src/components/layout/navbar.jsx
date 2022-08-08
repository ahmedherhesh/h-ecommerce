import React, { Component } from 'react';
import { FaSearch, FaRegUser } from 'react-icons/fa';
import { BsCart3 } from "react-icons/bs";
import { AiOutlineHome } from "react-icons/ai";
import { MdOutlineFavoriteBorder } from "react-icons/md";
import { Link } from 'react-router-dom';
class NavBar extends Component {
    state = {}
    removeActiveClass() {
        document.querySelectorAll('.nav-link').forEach(anchor => {
            anchor.classList.remove('active');
        });
    }
    componentDidMount() {
        let navItem = document.querySelectorAll('.nav-item');
        document.querySelectorAll('.nav-link').forEach(link => {
            link.onclick = () => {
                this.removeActiveClass();
                link.classList.add('active');
            }
        });
        document.querySelector('.navbar-brand').onclick = () => {
            this.removeActiveClass();
            navItem[0].querySelector('.nav-link').classList.add('active');
        }
    }
    render() {
        return (
            <div className="header" >
                <nav className="navbar navbar-expand-lg bg-white" style={{ position: 'fixed', top: 0, left: 0, width: '100%', zIndex: 1000 }}>
                    <div className="container">
                        <Link className="navbar-brand" to="/">E-Commerce</Link>
                        <button className="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                            <span className="navbar-toggler-icon"></span>
                        </button>
                        <div className="collapse navbar-collapse d-flex justify-content-around align-items-center" id="navbarNav">
                            <ul className="navbar-nav">
                                <li className="nav-item" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Tooltip on bottom">
                                    <Link className="nav-link active" aria-current="page" to="/"><AiOutlineHome /></Link>
                                </li>
                                <li className="nav-item" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Tooltip on bottom">
                                    <Link className="nav-link" to="/cart"><BsCart3 /></Link>
                                </li>
                                <li className="nav-item" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Tooltip on bottom">
                                    <Link className="nav-link" to="/favorite"><MdOutlineFavoriteBorder /></Link>
                                </li>
                            </ul>
                            <form action="">
                                <input type="text" className='input-style' placeholder='Search' />
                                <button type="submit" className='btn-style'><FaSearch /></button>
                            </form>
                            <ul className="navbar-nav">
                                <li className="nav-item dropdown">
                                    <span className="nav-link dropdown-toggle" id="navbarDarkDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <FaRegUser />
                                    </span>
                                    <ul className="dropdown-menu dropdown-menu-white" aria-labelledby="navbarDarkDropdownMenuLink">
                                        <li><Link className="dropdown-item" to="/login">Login</Link></li>
                                        <li><Link className="dropdown-item" to="/register">Register</Link></li>
                                    </ul>
                                </li>
                            </ul>

                        </div>
                    </div>
                </nav>
            </div>
        );
    }
}

export default NavBar;