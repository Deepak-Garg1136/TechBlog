<%@page import="org.json.JSONObject"%>
<%@page import="java.io.BufferedReader"%>
<%
StringBuilder sb = new StringBuilder();
String data = "";
BufferedReader reader = request.getReader();
while((data = reader.readLine()) != null){
	sb.append(data);
}

JSONObject jsonData = new JSONObject(sb.toString());
int postCategoryId = jsonData.getInt("postCategoryId");
session.setAttribute("postCategoryId", postCategoryId);
response.setContentType("application/json");
response.getWriter().println("{\"message\" : \" success\", \"redirect\" : \"posts.jsp\"}");
%>