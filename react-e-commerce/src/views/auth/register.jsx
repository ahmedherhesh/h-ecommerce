import React, { Component } from 'react';
import http from '../../axios';
class Register extends Component {
    state = {}
    vars = ['name', 'email', 'mobile', 'password', 'repaetPassword'];
    name            = React.createRef();
    email           = React.createRef();
    mobile          = React.createRef();
    password        = React.createRef();
    repaetPassword  = React.createRef();

    handelSubmit = e => {
        e.preventDefault();
        let data = {};
        this.vars.map(v => data[v] = this[v].current.value);
        http.post('register', data).then(r => console.log(r)).catch(r => console.log(r));
    }

    render() {
        return (
            <form onSubmit={this.handelSubmit} className="register-form">
                <input ref={this.name} id='name' type="text" className='form-control' placeholder='name' />
                <input ref={this.email} type="email" className='form-control' placeholder='Email' />
                <input ref={this.mobile} type="tel" className='form-control' placeholder='Mobile' />
                <input ref={this.password} type="password" className='form-control' placeholder='Password' />
                <input ref={this.repaetPassword} type="password" className='form-control' placeholder='Repeat Password' />
                <button className="btn btn-primary">Register</button>
            </form>
        );
    }
}

export default Register;