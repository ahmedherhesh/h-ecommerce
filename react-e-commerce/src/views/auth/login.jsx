import React, { Component } from 'react';
import http from '../../axios';

class Login extends Component {

    state    = {};
    errors   = {};
    email    = React.createRef();
    password = React.createRef();

    handelSubmit = e => {
        e.preventDefault();
        let data = {
            email: this.email.current.value,
            password: this.password.current.value,
        };
        http.post('login', data).then(r => console.log(r)).catch(r => {
            let res = r.response;
            if (res.status == 422) {
                for (let i = 0; i < Object.keys(res.data).length; i++) {
                    this.errors[Object.keys(res.data)[i]] = Object.values(res.data)[i][0];
                }
                console.log(this.errors);
            }
        });
    }
    render() {
        return (
            <form onSubmit={this.handelSubmit} className="login-form">
                <input ref={this.email} type="text" className='form-control' placeholder='Username' />
                {this.errors.hasOwnProperty('email') ?? this.errors.email}
                <input ref={this.password} type="password" className='form-control' placeholder='Password' />
                {this.errors.hasOwnProperty('password') ?? this.errors.password}
                <button className="btn btn-primary">Login</button>
            </form>
        );
    }
}

export default Login;