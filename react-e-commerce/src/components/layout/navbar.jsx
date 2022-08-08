import React, { Component } from 'react';
import { FaSearch, FaHome} from 'react-icons/fa';
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
        navItem.forEach((item, i) => {
            item.onclick = () => {
                this.removeActiveClass();
                item.querySelector('.nav-link').classList.add('active')
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
                        <div className="collapse navbar-collapse d-flex justify-content-around" id="navbarNav">
                            <ul className="navbar-nav">
                                <li className="nav-item">
                                    <Link className="nav-link active" aria-current="page" to="/"><FaHome /></Link>
                                </li>
                                <li className="nav-item">
                                    <Link className="nav-link" to="/cart">Cart</Link>
                                </li>
                            </ul>
                            <form action="">
                                <input type="text" className='input-style' placeholder='Search' />
                                <button type="submit" className='btn-style'><FaSearch /></button>
                            </form>
                            <ul className="navbar-nav">
                                <li className="nav-item">
                                    <Link className="nav-link" to="/login">Login</Link>
                                </li>
                                <li className="nav-item">
                                    <Link className="nav-link" to="/register">Register</Link>
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