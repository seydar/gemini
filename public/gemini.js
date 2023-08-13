var all_divs = ["about", "toc", "parties", "ari", "daniel", "rachel", "graylin", "eleni", "caitlin"];

var selected = "logo";

function focus_on_div(focus) {
  // hide the current one
  var div = document.getElementById(selected);
  div.style.display = "none";

  // show this one
  var div = document.getElementById(focus);
  div.style.display = "block";
  selected = focus;
}
