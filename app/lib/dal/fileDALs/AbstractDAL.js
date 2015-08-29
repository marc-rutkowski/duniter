/**
 * Created by cgeek on 22/08/15.
 */

var Q = require('q');

module.exports = AbstractDAL;

function AbstractDAL(dal) {

  "use strict";

  var that = this;
  this.dal = dal;
  this.RECURSIVE = true;

  var existsFileFunc, readFileFunc, writeFileFunc, removeFileFunc, listFilesFunc, makeTreeFunc;

  this.setExists = function(f) {
    existsFileFunc = f;
  };

  this.setList = function(f) {
    listFilesFunc = f;
  };

  this.setRead = function(f) {
    readFileFunc = f;
  };

  this.setWrite = function(f) {
    writeFileFunc = f;
  };

  this.setRemove = function(f) {
    removeFileFunc = f;
  };

  this.setMakeTree = function(f) {
    makeTreeFunc = f;
  };

  this.list = function(path) {
    return listFilesFunc(path);
  };

  this.exists = function(path) {
    return existsFileFunc(path);
  };

  this.read = function(path) {
    return readFileFunc(path);
  };

  this.write = function(path, what) {
    return writeFileFunc(path, what);
  };

  this.remove = function(path, recursive) {
    return removeFileFunc(path, recursive);
  };

  this.makeTree = function(path) {
    return makeTreeFunc(path);
  };

  this.reduceTo = function reduceTo(subpath, certs) {
      return function(files){
        return files.reduce(function(p, file) {
          return p.then(function(){
            return that.read(subpath + file)
              .then(function(data){
                certs.push(data);
              })
              .fail(function(err){
                throw err;
              });
          });
        }, Q());
      };
    };
}