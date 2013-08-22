var Sidebar = {
  open: function(company) {
    var that = this;
    var hoodData = "<h1 class='grade'>" + company.neighborhood_grade + "</h1>";
    var companyData = that.renderSideBar(company);
    $("#hood-info").children().remove();
    $("#hood-info").append(hoodData);
    $("#biz-info").children().remove();
    $("#biz-info").append(companyData);
  },
  renderCompany: function(company) {
    return $("<h3>" + company["trade_name"] + "</h3>" +
             "<h3>" + company["letter_grade"] + "</h3>" +
             "<span class='fade'>" + company["street"] + "<br/>" + company["city"] + ", " + company["state"] + " " + company["zip"] + "</span>" +
             "<p>... has " + company["flsa_cl_violtn_count"] + " child labor violations.</p>" +
             "<p>...has paid $" + company["flsa_ot_bw_atp_amt"] + " dollars for violating overtime laws</p>" +
             "<a href='/companies/" + company['id'] + "' alt='" + company['trade_name'] + "'>" + company['trade_name'] + "</a>")
  }
};
