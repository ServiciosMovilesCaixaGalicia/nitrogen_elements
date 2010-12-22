-module (element_telbox5).
-include_lib ("nitrogen_elements.hrl").
-compile(export_all).

reflect() -> record_info(fields, textbox).

render_element(Record) -> 
    ID = Record#telbox5.id,
    Anchor = Record#telbox5.anchor,
    case Record#telbox5.next of
        undefined -> ignore;
        Next -> 
            Next1 = wf_render_actions:normalize_path(Next),
            wf:wire(Anchor, #event { type=enterkey, actions=wf:f("Nitrogen.$go_next('~s');", [Next1]) })
    end,

   
    case Record#telbox5.postback of
        undefined -> ignore;
        Postback -> wf:wire(Anchor, #event { type=enterkey, postback=Postback, validation_group=ID, delegate=Record#telbox5.delegate })
    end,

    Value = wf:html_encode(Record#telbox5.text, Record#telbox5.html_encode),
    wf_tags:emit_tag(input, [
			     {type, tel}, 
			     {class, [textbox, Record#telbox5.class]},
			     {style, Record#telbox5.style},
			     {value, Value},
			     {autocomplete, Record#telbox5.autocomplete},
			     {placeholder, Record#telbox5.placeholder}
			     
    ]).
