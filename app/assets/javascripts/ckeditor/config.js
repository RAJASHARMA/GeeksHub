CKEDITOR.editorConfig = function( config ) {
        // config.toolbar = [
        //     { name: 'basic', items: [ 'Bold', 'Italic', 'Underline' ] },
        //     { name: 'font', items: [ 'Font' ] },
        //     { name: 'paragraph', items: [ 'NumberedList', 'BulletedList', 'Blockquote' ] },
        //     { name: 'links', items: [ 'Link', 'Unlink' ] },
        //     { name: 'insert', items: [ 'Image', 'Table', 'HorizontalRule' ] },
        //     { name: 'last', items: [ 'Maximize' ] },
        //     { name: 'codeSnippet', items: ['CodeSnippet']}
        // ];

        config.extraPlugins = 'codesnippet';
        config.format_tags = 'p;h1;h2;h3;pre';
        config.entities = false;
        config.removeDialogTabs = 'image:advanced;link:advanced;table:advanced';
        config.disableNativeSpellChecker = false;

    };