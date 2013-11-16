<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
	<h2>Categories</h2>
	<ul class="categories">
		<li class="category"><a href="ItemSearch.aspx?category=Appliances">Appliances</a></li>
		<li class="category"><a href="ItemSearch.aspx?category=Baby and Children">Baby and Children</a></li>
		<li class="category"><a href="ItemSearch.aspx?category=Computers and Electronics">Computers and Electronics</a></li>
		<li class="category"><a href="ItemSearch.aspx?category=Jewelry and Watches">Jewelry and Watches</a></li>
		<li class="category"><a href="ItemSearch.aspx?category=Luggage">Luggage</a></li>
		<li class="category"><a href="ItemSearch.aspx?category=Men">Men</a></li>
		<li class="category"><a href="ItemSearch.aspx?category=Toys and Games">Toys and Games</a></li>
		<li class="category"><a href="ItemSearch.aspx?category=Women">Women</a></li>
	</ul>
</asp:Content>
