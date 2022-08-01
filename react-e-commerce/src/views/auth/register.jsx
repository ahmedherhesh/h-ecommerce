import React, { Component } from 'react';
class Register extends Component {
    state = {}
    render() {
        return (
            <div className="register-form">
                <input type="text" className='form-control' placeholder='Username' />
                <input type="email" className='form-control' placeholder='Email' />
                <input type="number" className='form-control' placeholder='Mobile' />
                <input type="password" className='form-control' placeholder='Password' />
                <input type="password" className='form-control' placeholder='Repeat Password' />
                <button className="btn btn-primary">Register</button>
            </div>
        );
    }
}

export default Register;