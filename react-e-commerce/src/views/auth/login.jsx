import React, { Component } from 'react';
import http from '../../axios';

class Login extends Component {
    state = {}
    email     = React.createRef();
    password  = React.createRef();

    handelSubmit = e => {
        e.preventDefault();
        let data = {
            email: this.email.current.value,
            password: this.password.current.value,
        };
        http.post('login', data).then(r => console.log(r)).catch(r => console.log(r));
    }
    render() {
        return (
            <form onSubmit={this.handelSubmit} className="login-form">
                <input ref={this.email}    type="text"     className='form-control' placeholder='Username' />
                <input ref={this.password} type="password" className='form-control' placeholder='Password' />
                <button className="btn btn-primary">Login</button>
            </form>
        );
    }
}

export default Login;