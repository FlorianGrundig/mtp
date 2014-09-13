'use strict';

var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var CategorySchema = new Schema({
    name: String,
    email: { type: String, lowercase: true }
});

// Validate empty email
CategorySchema
    .path('email')
    .validate(function(email) {
        return email.length;
    }, 'Email cannot be blank');

// Validate empty password
CategorySchema
    .path('name')
    .validate(function(name) {
        return name.length;
    }, 'Name cannot be blank');

/**
 * Pre-save hook
 */
CategorySchema
    .pre('save', function(next) {
        next();
    });

/**
 * Methods
 */
CategorySchema.methods = {

};

module.exports = mongoose.model('Category', CategorySchema);
