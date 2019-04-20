<%@ Page Title="" Language="C#" MasterPageFile="~/proj.Master" AutoEventWireup="true"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title> Project Documentation </title>
    <link rel="stylesheet" href="CSS/bootstrap.css" />
    <link rel="stylesheet" href="CSS/docs.css" />
    <script type="text/javascript" src="JS/jquery-2.1.1.js"></script>
    <script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css"/>
    
    <script>
    $(function()
    {
        $("#tabparas").tabs();
    });
    </script>
    <style>
        p{
            font-size:15px;
        }
        .ui-menu 
        { width: 200px; }
    </style>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="pageContent" runat="server">
    <div class="pageContent main-body">
        <div id="tabparas" class="left-align">
            <h2 style="text-align:center"> Project Documentation</h2>
            <br />
            <ul>
                <li><a href="#tab1">About the Site</a></li>
                <li><a href="#tab2">Home Page</a></li>
                <li><a href="#tab3">Search Page</a></li>
                <li><a href="#tab4">Product Page</a></li>
                <li><a href="#tab5">Profile Page</a></li>
                <li><a href="#tab6">Sell Page</a></li>
                <li><a href="#tab7">Cart Page</a></li>
                <li><a href="#tab8">Login Page</a></li>
            </ul>

        
            <div id="tab1">
                <h3>About the Site</h3>

                <a class="btn-link" style="color:#337ab7" href="http://net4.ccs.neu.edu/home/krish/project/default.aspx" target="_blank"> Vist Site </a>
                <br />
                <br />
                <p >
                    E-Mart is a E-commerce website dealing in electronics. 
                    User can buy electronics listed in the website and sell also their products both new and old. 
                    <br />
                    <p>
                        Each of the above tabs will explain with screenshots the features and functionality of each page. A total of 9 individual pages  and 
                        a Master page makes up the whole site. All the 9 indivudual pages inherit the master page which contains the header and footer structures.
                    </p>
                    <br />
                    This site is developed using ASP.NET & Jquery as a part of the course work CS5200 <br />
                                                            - Kishore
                </p>
            </div>
        
            <div id="tab2">
                <h3> Home Page </h3>
                <div>
                    The Homepage of the website has a Welcome message block, advertisement banners and slideshows of current offers. It also has two blocks displaying the 
                    Best selling products and the New arrivals.

                    <br />
                     <div class="snap-desc"> Top half of Homepage </div>
                    <br />
                    <a target="_blank" href="IMGs/snapshot/home-1.png" ><img class="snap-img" src="IMGs/snapshot/home-1.png" /> </a>
                    <br />
                    <br />
                    <div class="snap-desc"> Bottom half of Homepage  </div>
                    <a target="_blank" href="IMGs/snapshot/home-2.png" > <img class="snap-img" src="IMGs/snapshot/home-2.png" /></a>
                    <br />
                </div>
            </div>
            <div id="tab3">
                <h3> Search Page </h3>
                <div>
                    The search page allows the users to search for products based on keywords or lists all the products in a particular category. This page also implements pagination when the search result yields
                    more than 9 items.
                    <br />
                    The user can sort based on product category or price or the title of the product by clicking the respective headers.
                    <br />
                     <div class="snap-desc"> Below is the page with search based on category </div>
                    <br />
                    <a target="_blank" href="IMGs/snapshot/search-cat.png" ><img class="snap-img" src="IMGs/snapshot/search-cat.png" /> </a>
                    <br />
                    <br />
                    <div class="snap-desc"> A search based on keyword "sam" </div>
                    <a target="_blank" href="IMGs/snapshot/search-query.png" > <img class="snap-img" src="IMGs/snapshot/search-query.png" /></a>
                    <br />
                    
                    <div class="snap-desc">  Invalid search query containing special characters.</div>
                    <a target="_blank" href="IMGs/snapshot/search-invalid.png" > <img class="snap-img" src="IMGs/snapshot/search-invalid.png" /></a>
                </div>
            </div>
            <br />

            <div id="tab4">
                <h3> Product Page </h3>
                <div>
                    The product page is for displaying a product and all its associated information to the user. The page displays to the user the product image, title , description, 
                    the specifications, user reviews, total rating of the product and the seller id of the product is all listed. 
                    
                    To a logged in user this page provides additional functionalities such as what was the user's rating for the current product, ability to like or Unlike the product,
                    give the product a rating or a review or both and the ability to edit or delete his previous review for the current product. 
                    
                    <br />
                    <br />
                    <div class="snap-desc"> The product page with no reviews and no user loged in. </div>
                    <br />
                    <a target="_blank" href="IMGs/snapshot/prod-new.png" > <img class="snap-img" src="IMGs/snapshot/prod-new.png" /></a>
                    <br />
                    <div class="snap-desc"> Information box asking the user loggin when trying to Like or rate the product  </div>
                    <br />
                     <a target="_blank" href="IMGs/snapshot/prod-nologin-like.png" > <img class="snap-img" src="IMGs/snapshot/prod-nologin-like.png" /></a>
                    <br />
                    <div class="snap-desc"> Information box displaying added to cart message </div>
                    <br />
                     <a target="_blank" href="IMGs/snapshot/prod-to-cart.png" > <img class="snap-img" src="IMGs/snapshot/prod-to-cart.png" /></a>
                    <br />
                    <div class="snap-desc">  Page displaying logged in user's comments and rating </div>
                    <br />
                     <a target="_blank" href="IMGs/snapshot/prod-usr-rated-cmted.png" > <img class="snap-img" src="IMGs/snapshot/prod-usr-rated-cmted.png" /></a>
                    <br />
                    <div class="snap-desc">  Product that has been liked by User and currently editing his comments </div>
                    <br />
                     <a target="_blank" href="IMGs/snapshot/prod-liked.png" > <img class="snap-img" src="IMGs/snapshot/prod-liked.png" /></a>
                    <br />
                    <div class="snap-desc">  User editing his comments and pagination for reviews </div>
                    <br />
                    <a target="_blank" href="IMGs/snapshot/prod-edit-cmt.png"> <img class="snap-img" src="IMGs/snapshot/prod-edit-cmt.png" /></a>
                    <br />
                </div>
            </div>

            <div id="tab5">
                <h3> Profile Page </h3>
                <div>
                    The profile page is accessible only by logged in users. It shows basic information of the user and the list products the user is selling, has reviewed and liked. This page also provides a follow and an unfollow
                    buttton for other users to follow and stop following a particular user. This page also allows the current logged in user to update his email address.
                    <br />
                     <div class="snap-desc"> Logged in User's Profile </div>
                    <br />
                    <a target="_blank" href="IMGs/snapshot/profile-logedinusr.png" ><img class="snap-img" src="IMGs/snapshot/profile-logedinusr.png" /> </a>
                    <br />
                    <br />
                    <div class="snap-desc"> Random User profile </div>
                    <a target="_blank" href="IMGs/snapshot/profile-others-follow.png" > <img class="snap-img" src="IMGs/snapshot/profile-others-follow.png" /></a>
                    <br />
                    
                    <div class="snap-desc"> Page of a user currently being followed </div>
                    <a target="_blank" href="IMGs/snapshot/profile-others.png" > <img class="snap-img" src="IMGs/snapshot/profile-others.png" /></a>
                </div>
            </div>

            <div id="tab6">
                <h3> Sell Page </h3>
                <div>
                    The sell page allows user to enlist items in the website for others to see and buy. The image of the product cannot be directly uploaded, rather the user will upload it 
                    else where and give the url of the image which will downloaded and saved in the server after the porduct submission is done. More specifications input fields can be dynamically 
                    generated by clicking the add more fields button. 
                    <br />
                     <div class="snap-desc"> Snapshot of the sell page </div>
                    <br />
                    <a target="_blank" href="IMGs/snapshot/sell-normal.png" ><img class="snap-img" src="IMGs/snapshot/sell-normal.png" /> </a>
                    <br />
                    <br />
                    <div class="snap-desc"> Displaying validation Fails </div>
                    <a target="_blank" href="IMGs/snapshot/sell-validation.png" > <img class="snap-img" src="IMGs/snapshot/sell-validation.png" /></a>
                    <br />
                    
                    <div class="snap-desc"> Dynamically add fields (the ones with no place holders) </div>
                    <a target="_blank" href="IMGs/snapshot/sell-more-fields.png" > <img class="snap-img" src="IMGs/snapshot/sell-more-fields.png" /></a>
                </div>
            </div>
            <div id="tab7">
                <h3> Cart Page </h3>
                <div>
                    The cart page displays the list of all the items added to cart, their title and descriptions, availability, a total cost, radio buttons to choose shipping methods and 
                    a submit order button for users to checkout.
                    <br />
                     <div class="snap-desc"> Snapshot of cart page</div>
                    <br />
                    <a target="_blank" href="IMGs/snapshot/cart-normal.png" ><img class="snap-img" src="IMGs/snapshot/cart-normal.png" /> </a>
                    <br />
                    <br />
                    <div class="snap-desc"> An empty cart </div>
                    <a target="_blank" href="IMGs/snapshot/cart-empty.png" > <img class="snap-img" src="IMGs/snapshot/cart-empty.png" /></a>
                    <br />
                    
                    <div class="snap-desc"> Cart with out of stock items </div>
                    <a target="_blank" href="IMGs/snapshot/cart-invalid.png" > <img class="snap-img" src="IMGs/snapshot/cart-invalid.png" /></a>
                </div>
            </div>
            <div id="tab8">
                <h3> Login Page </h3>
                <div>
                    The login page let users sign-in to the website so that they will be able to review and rate products, sell products of thier own, view profiles of other users, follow or unfollow them.
                    <br />
                     <div class="snap-desc"> Snapshot of the login page</div>
                    <br />
                    <a target="_blank" href="IMGs/snapshot/login-plain.png" ><img class="snap-img" src="IMGs/snapshot/login-plain.png" /> </a>
                    <br />
                    <br />
                    <div class="snap-desc"> Incorrect login credentitals </div>
                    <a target="_blank" href="IMGs/snapshot/login-fail.png" > <img class="snap-img" src="IMGs/snapshot/login-fail.png" /></a>
                    <br />
                    
                    <div class="snap-desc"> Redirection to login page, When user tried to access Members only restricted features </div>
                    <a target="_blank" href="IMGs/snapshot/login-needto.png" > <img class="snap-img" src="IMGs/snapshot/login-needto.png" /></a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
