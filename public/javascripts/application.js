var WEditor = {
  editor: null,
  toolbar: null,
  input: null,
  setup: function(textarea) {
    WEditor.input = $(textarea);
    WEditor.editor = WysiHat.Editor.attach(WEditor.input);

    WEditor.editor.html(WEditor.input.val());

    var form = WEditor.input.closest('form');
    if(form) {
      form.submit(function() {
        WEditor.input.val(WEditor.editor.html());  
      });
    }
    
    WEditor.toolbar = new WysiHat.Toolbar(WEditor.editor);
    WEditor.toolbar.initialize(WEditor.editor);

    WEditor.toolbar.addButton({name: 'bold', label: "Negrita"});
    WEditor.toolbar.addButton({name: 'underline', label: "Subrayado"});
    WEditor.toolbar.addButton({
      name: 'em', 
      label: "Enfasis", 
      handler: function(editor) { 
        editor.italicSelection();
      },
      query: function(editor) { 
        return editor.italicSelected();
      }
    });
    WEditor.toolbar.addButton({name: 'insertUnorderedList', label: "Listado"});
  }
};
