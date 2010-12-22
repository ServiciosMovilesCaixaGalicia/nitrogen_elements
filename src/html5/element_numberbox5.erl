-module (element_numberbox5).
-include_lib ("nitrogen_elements.hrl").
-compile(export_all).

reflect() -> record_info(fields, textbox).

render_element(Record) -> 
    ID = Record#numberbox5.id,
    Anchor = Record#numberbox5.anchor,
    case Record#numberbox5.next of
        undefined -> ignore;
        Next -> 
            Next1 = wf_render_actions:normalize_path(Next),
            wf:wire(Anchor, #event { type=enterkey, actions=wf:f("Nitrogen.$go_next('~s');", [Next1]) })
    end,

   
    case Record#numberbox5.postback of
        undefined -> ignore;
        Postback -> wf:wire(Anchor, #event { type=enterkey, postback=Postback, validation_group=ID, delegate=Record#numberbox5.delegate })
    end,

    Value = wf:html_encode(Record#numberbox5.text, Record#numberbox5.html_encode),
    wf_tags:emit_tag(input, [
			     {type, number}, 
			     {class, [textbox, Record#numberbox5.class]},
			     {style, Record#numberbox5.style},
			     {value, Value},
			     {autocomplete, Record#numberbox5.autocomplete},
			     {placeholder, Record#numberbox5.placeholder}
			     
    ]).
