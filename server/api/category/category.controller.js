var Category = require('./category.model');

'use strict';

// Get list of categories for current user
exports.index = function (req, res) {
    Category.find({'email': req.user.email}, function (err, categories) {
        if (err) {
            return handleError(res, err);
        }
        return res.json(200, categories);
    });
};

// Creates a new thing in the DB.
exports.create = function (req, res) {
    var category = new Category(req.body);
    category.email = req.user.email;

    category.save(function (err) {
        if (err) {
            return handleError(res, err);
        }
        return res.json(201);
    });
};


function handleError(res, err) {
    return res.send(500, err);
}