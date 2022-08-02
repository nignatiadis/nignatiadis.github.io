using YAML

bibliography = YAML.load_file("data/bibliography.yaml")

icon_dict = Dict(
    "arXiv" => ("ai ai-arxiv ai-lg", "arXiv"),
    "openaccess" => ("ai ai-open-access ai-lg", "Journal paper"),
    "closedaccess" => ("ai ai-closed-access ai-lg", "Journal paper"),
    "conference" => ("ai ai-open-access ai-lg", "Conference paper"),
    "julia_package" => ("icon-julia-dots", "Julia package"),
    "reproduction_code" => ("las la-code la-lg", "Reproduction code"),
    "bioRxiv" => ("ai ai-biorxiv ai-lg", "bioRxiv"),
    "r_package" => ("lab la-r-project la-lg", "R package"),
    "poster" => ("las la-chalkboard la-lg", "Poster")
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
