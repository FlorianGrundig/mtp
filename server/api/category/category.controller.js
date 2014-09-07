/**
 * Using Rails-like standard naming convention for endpoints.
 * GET     /things              ->  index
 * POST    /things              ->  create
 * GET     /things/:id          ->  show
 * PUT     /things/:id          ->  update
 * DELETE  /things/:id          ->  destroy
 */
var Category = require('./category.model');

'use strict';


// Get list of categories for current user
exports.index = function(req, res) {
    Category.find(req.user.login, function (err, categories) {
        if(err) { return handleError(res, err); }
        return res.json(200, categories);
    });
};

// Get a single thing
//exports.show = function(req, res) {
//    Thing.findById(req.params.id, function (err, thing) {
//        if(err) { return handleError(res, err); }
//        if(!thing) { return res.send(404); }
//        return res.json(thing);
//    });
//    return res.json(thing1);
//};

// Creates a new thing in the DB.
exports.create = function(req, res) {
    var category = Category.create(req.body);
    category.login = req.user.login;

    category.save( function(err) {
        if(err) { return handleError(res, err); }
        return res.json(201);
    });

    return res.json(201);
};

// Updates an existing thing in the DB.
//exports.update = function(req, res) {
//    if(req.body._id) { delete req.body._id; }
//    Thing.findById(req.params.id, function (err, thing) {
//        if (err) { return handleError(res, err); }
//        if(!thing) { return res.send(404); }
//        var updated = _.merge(thing, req.body);
//        updated.save(function (err) {
//            if (err) { return handleError(res, err); }
//            return res.json(200, thing);
//        });
//    });
//      return res.json(200, thing1);
//};

// Deletes a thing from the DB.
exports.destroy = function(req, res) {
//    Thing.findById(req.params.id, function (err, thing) {
//        if(err) { return handleError(res, err); }
//        if(!thing) { return res.send(404); }
//        thing.remove(function(err) {
//            if(err) { return handleError(res, err); }
//            return res.send(204);
//        });
//    });
      return res.send(204);
};

function handleError(res, err) {
  return res.send(500, err);
}