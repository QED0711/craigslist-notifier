const getListings = () => {
    $(".searches").html("")
    let user = $(".current_user")
    $.get(`/users/${user.data("id")}/currentsearches.json`, function(data){
        let template = Handlebars.compile(document.getElementById("card").innerHTML)
        let results = template(data)
        
        $(".searches").html(results)
        $(".search-info").click(getListings)
    })
}

const clearNewSearchForm = () => {
    $("input[type=submit]").removeAttr('disabled')
    $("#search_url")[0].value = ""
    $("#search_description")[0].value = ""
}

