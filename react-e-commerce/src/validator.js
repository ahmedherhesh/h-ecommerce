function validator(errorResponse, elements = {}) {
    let errors     = {};
    let err_keys   = Object.keys(errorResponse);
    let err_values = Object.values(errorResponse);
    let el_keys    = Object.keys(elements);
    let el_values  = Object.values(elements);
    let old_errors = document.querySelectorAll('.error');

    //remove all errors in document
    for (let i = 0; i < old_errors.length; i++) {
        old_errors[i].remove();
    }
    //errors storage in errors object 
    for (let i = 0; i < err_keys.length; i++) {
        let span = document.createElement("span");
        span.className = 'text-danger p-1 error';
        span.innerHTML = err_values[i][0];
        errors[err_keys[i]] = span;
    }
    //show errors in document
    for (let i = 0; i < el_keys.length; i++) {
        if (errors.hasOwnProperty(el_keys[i])) {
            el_values[i].after(errors[el_keys[i]]);
        }
    }

}
export default validator;