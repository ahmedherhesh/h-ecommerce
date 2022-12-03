import React, { Component } from 'react';
import axios from '../../axios';
import validator from '../../validator';
import { Link } from 'react-router-dom';
class Login extends Component {
    state = {};
    email = React.createRef();
    password = React.createRef();

    handelSubmit = e => {
        e.preventDefault();
        let data = {
            email: this.email.current.value,
            password: this.password.current.value,
        };
        axios.post('login', data).then(r => { 
            localStorage.setItem('token', r.data.token); 
            window.location.href = '/';
        }).catch(r => {
            let res = r.response;
            if (res.status === 422) {
                validator(res.data, {
                    email: this.email.current,
                    password: this.password.current
                });
            }
        });
    }
    render() {
        return (
            <form onSubmit={this.handelSubmit} className="login-form">
                <h1 className='w-100 fs-5 text-center p-3 mb-3' style={{ color: 'var(--main-color)', borderRadius: 20, borderBottom: '1px solid var(--main-color)' }}>Login</h1>
                <input ref={this.email} type="text" className='input-style' placeholder='Username' />
                <input ref={this.password} type="password" className='input-style' placeholder='Password' />
                <button className="btn-style w-50">Login</button>
                <div className="more-options d-flex justify-content-between align-items-center">
                    <Link to='/register' className='d-block' style={{ color: 'var(--main-color)' }}>New around here? Sign up</Link>
                    <Link to='#' style={{ color: 'var(--main-color)' }}>Forgot password?</Link>
                </div>
            </form>
        );
    }
}

export default Login;