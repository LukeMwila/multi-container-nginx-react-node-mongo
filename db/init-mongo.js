db.createUser(
  {
    user: "lukemwila",
    pwd: "doesitreallymatterwhatthisis",
    roles: [
      {
        role: "readWrite",
        db: "multicontainer-database"
      }
    ]
  }
)