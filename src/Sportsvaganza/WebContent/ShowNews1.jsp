<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<%@ page import="java.util.Scanner, java.lang.String, java.io.*, org.apache.jena.query.Query, org.apache.jena.query.QueryFactory, org.apache.jena.query.QueryExecution, org.apache.jena.query.QueryExecutionFactory, org.apache.jena.query.ResultSet, org.apache.jena.query.ResultSetFormatter, org.apache.jena.query.QuerySolution" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% PrintWriter out1 = response.getWriter(); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="generator" content="Mobirise v3.9.0, mobirise.com">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="shortcut icon" href="assets/images/logo.png" type="image/x-icon">
  <meta name="description" content="">
  
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic&amp;subset=latin">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,700">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i">
  <link rel="stylesheet" href="assets/bootstrap-material-design-font/css/material.css">
  <link rel="stylesheet" href="assets/tether/tether.min.css">
  <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="assets/animate.css/animate.min.css">
  <link rel="stylesheet" href="assets/theme/css/style.css">
  <link rel="stylesheet" href="assets/mobirise/css/mbr-additional.css" type="text/css">
  
  
  
</head>
<body>
<%! String headline, snippet, sports, country_name, user_input; 
	String [] tweets1 = new String[]{"","","","","","","","","","",""};
	String [] tweets2 = new String[]{"","","","","","","","","","",""};;
	String [] name = new String[]{"","","","","","","","","","",""};;
	String [] twitter_handle = new String[]{"","","","","","","","","","",""};;
	String [] event_date = new String[]{"","","","","","","","","","",""};;
	String [] event_venue = new String[]{"","","","","","","","","","",""};;
	String [] event_name = new String[]{"","","","","","","","","","",""};;
	String wiki_event;
	int count=0,i=0;
	static int index;
	int length_country;
	String[] countries = new String[]{"","","","","","","","","","",""};;
	String queryString;
%> 
	

<% 
	user_input = request.getParameter("country");
	countries[0]  = "Canada";
	countries[1]  = "USA";
	countries[2]  = "Russia";
	countries[3]  = "China";
	countries[4]  = "Australia";
	countries[5]  = "Japan";
	countries[6]  = "India";
	countries[7]  = "Pakistan";
	length_country = user_input.length();
	char[] country_characters = new char[length_country];
	user_input.getChars(0,length_country-1,country_characters,0);
	int match_characters = 0;
	  for(int i=0; i<8; i++)
	  {
		  match_characters = 0;
		  for(int j=0; j<length_country; j++)
		  {
			  
			if(countries[i].indexOf(country_characters[j])!= -1)
			{
				match_characters = match_characters + 1;
				index = i;
			}			 
		  }
		  		  
	if((length_country == (match_characters - 1)) || (length_country == (match_characters + 1))){
		
		break;	
		
	}			
	}	
	country_name = countries[index];	
	queryString = "SELECT ?snippet ?headline ?sport_name WHERE {?id <http://www.semanticweb.org/newsanalytics/ontologies/2016//has_country> '" + country_name + "'. ?id  <http://www.semanticweb.org/newsanalytics/ontologies/2016//snippet> ?snippet.?id <http://www.semanticweb.org/newsanalytics/ontologies/2016//headline> ?headline.?id <http://www.semanticweb.org/newsanalytics/ontologies/2016//name> ?sport_name.}LIMIT 3";
	Query query = QueryFactory.create(queryString);
	QueryExecution qe = QueryExecutionFactory.sparqlService(
        "http://localhost:3030/ds/query", query );
	ResultSet results = qe.execSelect();
	QuerySolution qs = null;
	int pageN;
	if(request.getParameter("page")== null){
		pageN=1;
	}
	else{
		pageN=Integer.parseInt(request.getParameter("page"));
	}
	for(int k=0; k<pageN; k++){
		qs = results.nextSolution();
		snippet = qs.getLiteral("?snippet").getString();
		headline = qs.getLiteral("?headline").getString();
		sports = qs.getLiteral("?sport_name").getString();
	}
	qe.close();
%>

<%
	queryString = "PREFIX sports:<http://www.semanticweb.org/newsanalytics/ontologies/2016/>\nSELECT ?id ?name ?id1 ?id2 ?twitter_handle ?tweets WHERE {?id <http://www.semanticweb.org/newsanalytics/ontologies/2016//has_country> '"+ country_name +"'.?id  <http://www.semanticweb.org/newsanalytics/ontologies/2016//snippet> ?snippet.?id <http://www.semanticweb.org/newsanalytics/ontologies/2016//name>'"+sports+"'.?id1 <http://www.semanticweb.org/newsanalytics/ontologies/2016//name>'"+sports+"'.?id1 sports:person_name ?name.?id1 <http://www.semanticweb.org/newsanalytics/ontologies/2016//name>'"+sports+"'.?id1 <http://www.semanticweb.org/newsanalytics/ontologies/2016//has_country> '"+ country_name +"'.?id2 sports:person_name ?name.?id2 <http://www.semanticweb.org/newsanalytics/ontologies/2016//twitter_handle> ?twitter_handle.?id2 <http://www.semanticweb.org/newsanalytics/ontologies/2016//tweets> ?tweets.}LIMIT 6";

	Query tweets_query = QueryFactory.create(queryString);
	QueryExecution tweets_query_execution = QueryExecutionFactory.sparqlService(
	        "http://localhost:3030/ds/query", tweets_query );
	ResultSet tweets_result = tweets_query_execution.execSelect();
	if(!tweets_result.hasNext()){
		name[0] = "No details available";
		name[1] = "No details available";
		twitter_handle[0] = "No details available";
		twitter_handle[1] = "No details available";
		for(int c=0; c<6; c++){
			tweets1[i] = "No details available";
			tweets2[i] = "No details available";
		}
	}
	else{
		QuerySolution tweets_query_solution = tweets_result.nextSolution();
		name[0] = tweets_query_solution.getLiteral("?name").getString();
		twitter_handle[0] = tweets_query_solution.getLiteral("?twitter_handle").getString();
		tweets1[i] = tweets_query_solution.getLiteral("?tweets").getString();
		i++;
		while(tweets_result.hasNext()){
			tweets_query_solution = tweets_result.nextSolution();
			if(name[0].equals(tweets_query_solution.getLiteral("?name").getString())){
				tweets1[i] = tweets_query_solution.getLiteral("?tweets").getString();
				i++;
				continue;
			}
			else{
				i=0;
				name[1] = tweets_query_solution.getLiteral("?name").getString();
				twitter_handle[1] = tweets_query_solution.getLiteral("?twitter_handle").getString();
				tweets2[i] = tweets_query_solution.getLiteral("?tweets").getString();
				i++;
				break;
			}	
		}
		while(tweets_result.hasNext()){
			tweets_query_solution = tweets_result.nextSolution();
			tweets2[i] = tweets_query_solution.getLiteral("?tweets").getString();
			i++;
		}	
		if(twitter_handle[1] == ""){
			tweets2[1] = "See more at twitter.com";
		}
	}
%>

<%
	queryString = "PREFIX sports:<http://www.semanticweb.org/newsanalytics/ontologies/2016/>\nSELECT ?id ?id1 ?id2 ?events ?date ?venue WHERE { ?id <http://www.semanticweb.org/newsanalytics/ontologies/2016//has_country> '"+country_name+"'.?id  <http://www.semanticweb.org/newsanalytics/ontologies/2016//snippet> ?snippet.?id <http://www.semanticweb.org/newsanalytics/ontologies/2016//name> '"+sports+"'.?id1 <http://www.semanticweb.org/newsanalytics/ontologies/2016//name> '"+sports+"'.?id1 sports:person_name ?name. ?id1 <http://www.semanticweb.org/newsanalytics/ontologies/2016//name> '"+sports+"'. ?id1 <http://www.semanticweb.org/newsanalytics/ontologies/2016//has_country> '"+ country_name+"'.?id2 <http://www.semanticweb.org/newsanalytics/ontologies/2016//name> '"+sports+"'.?id2 <http://www.semanticweb.org/newsanalytics/ontologies/2016//has_events> ?events. ?id2 <http://www.semanticweb.org/newsanalytics/ontologies/2016//date> ?date.?id2 <http://www.semanticweb.org/newsanalytics/ontologies/2016//venue> ?venue.}LIMIT 4";
	Query events_query = QueryFactory.create(queryString);
	QueryExecution events_query_execution = QueryExecutionFactory.sparqlService(
	        "http://localhost:3030/ds/query", events_query );
	ResultSet events_result = events_query_execution.execSelect();
	if(!events_result.hasNext()){
		for(int c=0; c<4; c++){
			event_date[i] = "No details available";
			event_venue[i] = "No details available";
			event_name[i] = "No details available";
		}	
	}
	else{
	QuerySolution events_query_solution = events_result.nextSolution();
	i=0;
	event_date[i] = events_query_solution.getLiteral("?date").getString();
	event_venue[i] = events_query_solution.getLiteral("?venue").getString();
	event_name[i] = events_query_solution.getLiteral("?events").getString();
	i++;
	
	while(events_result.hasNext()){
		events_query_solution = events_result.nextSolution();
		event_date[i] = events_query_solution.getLiteral("?date").getString();
		event_venue[i] = events_query_solution.getLiteral("?venue").getString();
		event_name[i] = events_query_solution.getLiteral("?events").getString();
		i++;
		
	}
	}
%>

<%
queryString = "PREFIX sports:<http://www.semanticweb.org/newsanalytics/ontologies/2016/>\nSELECT ?desc WHERE {?id <http://www.semanticweb.org/newsanalytics/ontologies/2016//has_country> '"+ country_name+"'.?id  <http://www.semanticweb.org/newsanalytics/ontologies/2016//snippet> ?snippet.?id <http://www.semanticweb.org/newsanalytics/ontologies/2016//name> '"+sports+"'.?id1 <http://www.semanticweb.org/newsanalytics/ontologies/2016//name> '"+sports+"'. ?id1 sports:person_name ?name.?id1 <http://www.semanticweb.org/newsanalytics/ontologies/2016//name> '"+sports+"'.?id1 <http://www.semanticweb.org/newsanalytics/ontologies/2016//has_country> '"+country_name+"'.?id2 <http://www.semanticweb.org/newsanalytics/ontologies/2016//name> '"+sports+"'.?id2 <http://www.semanticweb.org/newsanalytics/ontologies/2016//has_events> ?events.?id3 <http://www.semanticweb.org/newsanalytics/ontologies/2016//has_events> ?events.?id3 sports:db_description ?desc.}LIMIT 1";
Query wiki_query = QueryFactory.create(queryString);
	QueryExecution wiki_query_execution = QueryExecutionFactory.sparqlService(
         "http://localhost:3030/ds/query", wiki_query );
	ResultSet wiki_result = wiki_query_execution.execSelect();
	if(!wiki_result.hasNext()){
		wiki_event = "No details found";
	}
	else{
		QuerySolution wiki_query_solution = wiki_result.nextSolution();
		wiki_event = wiki_query_solution.getLiteral("?desc").getString();
		if(wiki_event == ""){
			wiki_event = "See more at wikipedia.com";
		}
	}
%>

<section class="mbr-section article mbr-parallax-background" id="msg-box8-1" style="background-image: url(assets/images/pexels-photo-54567.jpeg); padding-top: 120px; padding-bottom: 120px;">

    <div class="mbr-overlay" style="opacity: 0.5; background-color: rgb(34, 34, 34);">
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-8 col-md-offset-2 text-xs-center">
                <h3 class="mbr-section-title display-2">Sportsvaganza</h3>
                <div class="lead">Do you know the score?</div>
                
            </div>
        </div>
    </div>

</section>

<section class="engine"><a rel="external" href="https://mobirise.com">free drag and drop web generator</a></section><section class="mbr-section article" id="msg-box3-c" style="background-color: rgb(242, 242, 242); padding-top: 120px; padding-bottom: 120px;">

    
    <div class="container">
        <div class="row">
            <div class="col-md-8 col-md-offset-2 text-xs-center">
                <h3 class="mbr-section-title display-2"><%=headline%></h3>
                <div class="lead"><p><%=snippet%></p></div>
                <div><% if(pageN>=3){ }else{out.println("<a class='btn btn-secondary' href='ShowNews1.jsp?page="+(pageN+1)+"&country="+country_name +"' >NEXT</a>");} %></div>
                 </div>
        </div>
    </div>

</section>

<section class="mbr-section mbr-parallax-background" id="content5-6" style="background-image: url(assets/images/desert2.jpg) ; padding-top: 120px; padding-bottom: 120px;">

    <div class="mbr-overlay" style="opacity: 0.5; background-color: rgb(0, 0, 0);">
    </div>

    <div class="container">
        <h3 class="mbr-section-title display-2"><%=sports%></h3>
    </div>

</section>


<section class="mbr-section" id="testimonials1-8" style="background-color: rgb(255, 255, 255); padding-top: 120px; padding-bottom: 120px;">

    

        <div class="mbr-section mbr-section__container mbr-section__container--middle">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 text-xs-center">
                        <h3 class="mbr-section-title display-2">Tweets of sports players</h3>
                        <small class="mbr-section-subtitle"></small>
                    </div>
                </div>
            </div>
        </div>


    <div class="mbr-testimonials mbr-section mbr-section-nopadding">
        <div class="container">
            <div class="row">

                <div class="col-xs-12 col-md-6">

                    <div class="mbr-testimonial card mbr-testimonial-lg">
                        <div class="card-block"><p><%=tweets1[0] %></p><p><%=tweets1[1]%></p><p><%=tweets1[2] %></p></div>
                        <div class="mbr-author card-footer">
                           <!-- Image place holder -->
                            <div class="mbr-author-name"><%=name[0]%></div>
                            <small class="mbr-author-desc"><%=twitter_handle[0]%></small>
                        </div>
                    </div>
                </div><div class="col-xs-12 col-md-6">

                    <div class="mbr-testimonial card mbr-testimonial-lg">
                        <div class="card-block"><p><%=tweets2[0] %></p><p><%=tweets2[1] %></p><p><%=tweets2[2] %></p></div>
                        <div class="mbr-author card-footer">
                           <!-- Image place holder --> 
                            <div class="mbr-author-name"><%=name[1]%></div>
                            <small class="mbr-author-desc"><%=twitter_handle[1] %></small>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

</section>

<section class="mbr-section mbr-parallax-background" id="testimonials4-9" style="background-image: url(assets/images/sky.jpg); padding-top: 120px; padding-bottom: 120px;">

    <div class="mbr-overlay" style="opacity: 0.2; background-color: rgb(34, 34, 34);">
    </div>

        <div class="mbr-section mbr-section__container mbr-section__container--middle">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 text-xs-center">
                        <h3 class="mbr-section-title display-2">Sports events in country</h3>
                        
                    </div>
                </div>
            </div>
        </div>


    <div class="mbr-section mbr-section-nopadding">
        <div class="container">
            <div class="row">

                <div class="col-xs-12">

                    <div class="mbr-testimonial card">
                        <div class="card-block"><center><p><%=event_name[0]%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=event_date[0]%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=event_venue[0]%></p></center><p><%=wiki_event %></p></div>
                        <div class="mbr-author card-footer">
                            
                            <div class="mbr-author-name"></div>
                            
                        </div>
                    </div><div class="mbr-testimonial card">
                        <div class="card-block"><center><p><%=event_name[1]%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=event_date[1]%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=event_venue[1]%></p></center><p><%=wiki_event %></p></div>
                        <div class="mbr-author card-footer">
                            
                            <div class="mbr-author-name"></div>
                            
                        </div>
                    </div><div class="mbr-testimonial card">
                        <div class="card-block"><center><p><%=event_name[2]%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=event_date[2]%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=event_venue[2]%></p></center><p><%=wiki_event %></p></div>
                        <div class="mbr-author card-footer">
                            
                            <div class="mbr-author-name"></div>
                            
                        </div>
                    </div><div class="mbr-testimonial card">
                        <div class="card-block"><center><p><%=event_name[3]%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=event_date[3]%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=event_venue[3]%></p></center><p><%= wiki_event %></p></div>
                        <div class="mbr-author card-footer">
                            
                            <div class="mbr-author-name"></div>
                            
                        </div>
                    </div>

                </div>

            </div>

        </div>
    </div>
</section>

<footer class="mbr-small-footer mbr-section mbr-section-nopadding" id="footer1-2" style="background-color: rgb(50, 50, 50); padding-top: 1.75rem; padding-bottom: 1.75rem;">
    
    <div class="container">
        <p class="text-xs-center">Copyright (c) 2016 Mobirise.</p>
    </div>
</footer>


  <script src="assets/web/assets/jquery/jquery.min.js"></script>
  <script src="assets/tether/tether.min.js"></script>
  <script src="assets/bootstrap/js/bootstrap.min.js"></script>
  <script src="assets/smooth-scroll/SmoothScroll.js"></script>
  <script src="assets/viewportChecker/jquery.viewportchecker.js"></script>
  <script src="assets/jarallax/jarallax.js"></script>
  <script src="assets/theme/js/script.js"></script>
  
  
  <input name="animation" type="hidden">
  </body>
</html>