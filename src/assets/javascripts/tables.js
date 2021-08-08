/* eslint-disable no-undef */
document$.subscribe(function () {
  var tables = document.querySelectorAll("article table")
  tables.forEach(function (table) {
    new Tablesort(table)
  })
})
