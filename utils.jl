using YAML

bibliography = YAML.load_file("data/bibliography.yaml")
talks =  YAML.load_file("data/talks.yaml")
talks_expanded = collect(talks)
talk_names = first.(talks_expanded)
talk_dates = map(x-> Date("$(x["year"])-$(x["month"])", "y-U"), last.(talks_expanded))
_order = sortperm(talk_dates; rev=true)
sorted_talks = talk_names[_order]

icon_dict = Dict(
    "arXiv" => ("ai ai-arxiv ai-lg", "arXiv"),
    "book" => ("las la-book la-lg", "Book chapter"),
    "openaccess" => ("ai ai-open-access ai-lg", "Journal paper"),
    "closedaccess" => ("ai ai-closed-access ai-lg", "Journal paper"),
    "conference" => ("ai ai-open-access ai-lg", "Conference paper"),
    "julia_package" => ("icon-julia-dots", "Julia package"),
    "reproduction_code" => ("las la-code la-lg", "Reproduction code"),
    "bioRxiv" => ("ai ai-biorxiv ai-lg", "bioRxiv"),
    "r_package" => ("lab la-r-project la-lg", "R package"),
    "poster" => ("las la-chalkboard la-lg", "Poster"),
    "video" => ("lab la-youtube la-lg", "Video"),
    "slides" => ("las la-file-pdf la-lg", "Pdf slides"),
    "link" => ("las la-external-link-alt la-lg", "Link")
)




function tooltip_code(url, class)
    dict_entry = icon_dict[class]
    class_text = dict_entry[1]
    tooltip_text = dict_entry[2]
    """
    <span class="tooltip">
    <a href=$(url)><i class="$(class_text)"></i></a>
    <span class="tooltiptext">$(tooltip_text)</span>
    </span>
    """
end


function bibprint(yamlkey)
    entry = bibliography[yamlkey]
    names = join(["""<span class="person">$name</span>""" for name ∈ entry["author"] ], ", ")
    year = """<span class="year">$(entry["year"])</span>"""
    title = """<span class="title">$(entry["title"]).</span>"""
    journal = """<span class="journal">$(entry["journal"]).</span>"""
    html_string = """
    <li>
    $(names)
    $(year)<br>
    $(title)<br>
    $(journal)<br>
    """
    if haskey(entry, "note")
        html_string = """
        $(html_string)
        <i> $(entry["note"]) </i> <br>
        """
    end

    bibkey_order = ["openaccess";
                    "closedaccess";
                    "conference";
                    "book";
                    "arXiv";
                    "bioRxiv";
                    "poster";
                    "reproduction_code";
                    "julia_package";
                    "r_package"]
    for key in bibkey_order
        if haskey(entry, key)
            html_string = """
            $(html_string)
            $(tooltip_code(entry[key], key))
            """
        end
    end
    html_string = """
    $(html_string)
    </li>
    """;
    html_string
end

function hfun_bibliographyprint(yamlkeys)
    keys = locvar(yamlkeys[1])
    html_string = """<ol>"""
    for key in keys
        html_string = """
        $(html_string)
        $(bibprint(key))
        """
    end
    """
    $(html_string)
    </ol>
    """
end



function talkprint(yamlkey)
    entry = talks[yamlkey]

    title = """<span class="title">$(entry["title"]).</span>"""
    event = "$(entry["event"])"
    date_location = "$(entry["month"]) $(entry["year"]), $(entry["location"])"

    html_string = """
    <li>
    $(title)<br>
    $(event)<br>
    $(date_location)<br>
    """

    bibkey_order = ["link";
                    "video";
                    "slides"]
    for key in bibkey_order
        if haskey(entry, key)
            html_string = """
            $(html_string)
            $(tooltip_code(entry[key], key))
            """
        end
    end
    html_string = """
    $(html_string)
    </li>
    <br>
    """;
    html_string
end

function hfun_alltalksprint()
    html_string = """<ul>"""
    for key in sorted_talks
        html_string = """
        $(html_string)
        $(talkprint(key))
        """
    end
    """
    $(html_string)
    </ul>
    """
end
