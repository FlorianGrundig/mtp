'use strict';

var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var ExerciseSchema = new Schema({
    name: String,
    email: String,
    categories: [String],
    duration: Number,
    source: String,
    hints: String,
    level: Number,
    max_experience: Number,
    replay: Number,
    history: [{date: Date, experience: Number}]
});

// Validate empty email
ExerciseSchema
    .path('email')
    .validate(function(email) {
        return email.length;
    }, 'Email cannot be blank');

// Validate empty password
ExerciseSchema
    .path('name')
    .validate(function(name) {
        return name.length;
    }, 'Name cannot be blank');

/**
 * Pre-save hook
 */
ExerciseSchema
    .pre('save', function(next) {
        next();
    });

/**
 * Methods
 */
ExerciseSchema.methods = {

};

module.exports = mongoose.model('Exercise', ExerciseSchema);
