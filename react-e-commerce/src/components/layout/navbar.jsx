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
        document.querySelectorAll('.nav-link').forEach(link => {
            link.onclick = () => {
                this.removeActiveClass();
                link.classList.add('active');
            }
        });
        document.querySelector('.navbar-brand').onclick = () => {
            this.removeActiveClass();
            document.querySelector('.nav-link').classList.add('active');
        }

    }
    render() {
        return (
            <React.Fragment>
                <div className="header">
                    <nav className="navbar navbar-expand-lg bg-white" style={{ position: 'fixed', top: 0, left: 0, width: '100%', zIndex: 1000 }}>
                        <div className="container">
                            <Link className="navbar-brand" to="/">E-Commerce</Link>
                            <ul className="bottom-navbar d-flex justify-content-around bg-white m-0 p-2">
                                <li className="nav-item" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Tooltip on bottom">
                                    <Link className="nav-link active" aria-current="page" to="/"><AiOutlineHome /></Link>
                                </li>
                                <li className="nav-item" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Tooltip on bottom">
                                    <Link className="nav-link" to="/cart"><BsCart3 /></Link>
                                </li>
                                <li className="nav-item" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Tooltip on bottom">
                                    <Link className="nav-link" to="/favorite"><MdOutlineFavoriteBorder /></Link>
                                </li>
                                <li className="nav-item" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Tooltip on bottom">
                                    <Link className="nav-link" to="/login"><FaRegUser /></Link>
                                </li>
                            </ul>
                         
                                <form action="">
                                    <input type="text" className='input-style' placeholder='Search' />
                                    <button type="submit" className='btn-style'><FaSearch /></button>
                                </form>

                        </div>
                    </nav>
                </div>

            </React.Fragment>
        );
    }
}

export default NavBar;