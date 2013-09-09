/**
 * UsersController
 *
 * @module		:: Controller
 * @description	:: Contains logic for handling requests.
 */

module.exports = {
  index: function(req, res) {
    User.find().done(function(err, users) {
      if(err) {
        res.send(500, { error: "DB Error" })
      }
      res.view({
        users: users,
        title: 'List of users'
      })
    })
  }
}
