// const getListings = () => {
//     $(".searches").html("")
//     let user = $(".current_user")
//     $.get(`/users/${user.data("id")}/currentsearches.json`, function(data){
//         let template = Handlebars.compile(document.getElementById("card").innerHTML)
//         let results = template(data)
        
//         $(".searches").html(results)
//         $(".search-info").click(getListings)
//     })
// }

const getAllSearches = () => {
    $(".searches").html("")
    let user = $(".current_user")
    $.get(`/users/${user.data("id")}/currentsearches.json`, function(data){
        console.log(data)
        let template = Handlebars.compile(document.getElementById("card").innerHTML)
        let results = template(data)
        
        resetSearches(results);
        toggleActive();
    })
}

const clearNewSearchForm = () => {
    $("input[type=submit]").removeAttr('disabled')
    $("#search_url")[0].value = ""
    $("#search_description")[0].value = ""
}

const resetSearches = (results) => {
    $(".searches").html(results)
}

const addRecentSearches = () => {
    let user = $(".current_user")
    $.get(`/users/${user.data("id")}/currentsearches.json`, function(data){
        let template = Handlebars.compile(document.getElementById("card").innerHTML)
        data = [data[data.length-1]] 
        let results = template(data)       
        
        $(".searches").append(results)
        toggleActive();
    }) 
}

// POST Requests

const createNewSearch = () => {
    $(".new_search").submit(function(e){
        e.preventDefault();
        let values = $(this).serialize();
        let posting = $.post('/searches', values);
        posting.done(function(data){
            addRecentSearches();
            clearNewSearchForm();
        })
    })
}

const toggleActive = () => {
    $(".toggle_form").submit(function(e){
        e.preventDefault();
        values = $(this).serialize()
        let posting = $.post('/toggle_active', values)
        posting.done(function(data){
            getAllSearches();
        })
    })    
}
