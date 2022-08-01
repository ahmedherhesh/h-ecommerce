import React, { Component } from 'react';
class Login extends Component {
    state = {}
    render() {
        return (
            <div className="login-form">
                <input type="text" className='form-control' placeholder='Username' />
                <input type="password" className='form-control' placeholder='Password' />
                <button className="btn btn-primary">Login</button>
            </div>
        );
    }
}

export default Login;