---
layout: nil
---

var sidebar = {};

{% for cat in site.categories-list %}
sidebar["{{ cat }}"] = [];
{% for page in site.pages %}{% if page.categories == cat %}{% if page.parent != null %}
sidebar["{{ cat }}"].push({url:"{{ page.url }}", parent: "{{ page.parent }}", weight:{% if page.weight != null %} {{ page.weight }}{% else %} 0{% endif %}, title: "{{ page.title }}"});
{% endif %}{% endif %}{% endfor %}{% endfor %}

function transformArr(orig) {
  var newArr = [],
  parents = {},
  newItem, i, j, cur, x, y;
  for (i = 0, j = orig.length; i < j; i++) {
    cur = orig[i];
    if (!(cur.parent in parents)) {
      parents[cur.parent] = {parent: cur.parent, urls: []};
      newArr.push(parents[cur.parent]);
    }
    parents[cur.parent].urls.push({url:cur.url, weight:cur.weight, title:cur.title});
  }

  for (i = 0, j = newArr.length; i < j; i++) {
    newArr[i]['urls'] = newArr[i]['urls'].sort(function(a,b) {
      return(a.weight - b.weight)
    });
    for (x = 0, y = newArr[i]['urls'].length; x < y; x++) {
      delete newArr[i]['urls'][x]['weight'];
    }
  }

  return newArr;
}

function makeSideBar(orig, space) {
  without_parent = orig.filter(function(x) {return x.parent == 'none'})[0];
  with_parent = orig.filter(function(x) {return x.parent != 'none'});

  parent_html = makeParentMenu(without_parent, space);
  parent_object = $('<div/>').html(parent_html).contents();

  // dangerous recursion
  // Not finished yet, don't use this

  var counter = 0;
  while (with_parent.length != 0) {
    counter += 1;
    if (with_parent.length > 2) {
      var current_child = with_parent[~~(Math.random()*with_parent.length)];
    } else if (with_parent.length == 2) {
      var current_child = with_parent[Math.round(Math.random())];
    } else {
      var current_child = with_parent[0];
    }

    sidebar_url = '[href$="' + current_child['parent'] + '"]';
    find_a = parent_object.find(decodeURI(sidebar_url));
    if (find_a.length != 0) {
      with_parent = $.grep(with_parent, function(value) { return(value != current_child) });
      find_a.after("\n" + makeChildMenu(current_child) + "\n");
    }

    //failsafe 200 times iteration
    if (counter == 600) {
      with_parent = [];
    }

  }
  return parent_object.prop("outerHTML")
}

function makeParentMenu(orig, space) {
  output = "<ul id='toc_menu' style='display:none;'>\n";
  var i, j;
  for (i = 0, j = orig['urls'].length; i < j; i++) {
    var curr_menu = orig['urls'][i];
    output += '<li><a href="' + curr_menu['url'] + '">' + curr_menu['title'] + "</a></li>\n";
  }
  output += "</ul>";
  return output
}

function makeChildMenu(orig) {
  output = "<ul>\n";
  var ci, cj;
  for (ci = 0, cj = orig['urls'].length; ci < cj; ci++) {
    var curr_menu = orig['urls'][ci];
    output += '<li><a href="' + curr_menu['url'] + '">' + curr_menu['title'] + "</a></li>\n";
  }
  output += "</ul>";
  return output
}

function createBreadcrumbs(category, currentSection) {

  if (sidebar[category]) {
    var locations = [];
    var currentPath = location.pathname;
    var currentCrumb = sidebar[category].filter(function(x) {return x.url == currentPath})[0]
    while (currentCrumb) {
      locations.unshift(currentCrumb);
      if (currentCrumb.parent == "none") break;
      currentPath = "/" + category.toLowerCase() + "/" + currentCrumb.parent;
      currentCrumb = sidebar[category].filter(function(x) {return x.url == currentPath})[0]
    }
  }

  var breadcrumbsHtml = "<ol class='breadcrumb'>";
  breadcrumbsHtml += "<li><a href='/'>Home</a></li>";
  breadcrumbsHtml += "<li><a href='/" + category.toLowerCase() + "/'>" + currentSection + "</a></li>";
  if (locations.length > 0) {
    for (var i=0; i<locations.length; i++) {
      breadcrumbsHtml += "<li><a href='" + locations[i].url +"'>" + locations[i].title + "</a></li>";
    }
  }
  breadcrumbsHtml += "</ol>";
  $("#breadcrumbs").append(breadcrumbsHtml);

}




