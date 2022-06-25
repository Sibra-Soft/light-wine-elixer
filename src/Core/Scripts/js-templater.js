class JsTemplater {
    async Render(requestPath, selector) {
        return new Promise(async (resolve, reject) => {
            const request = await elixer.request.get(requestPath);

            if (request.status == 200) {
                const items = JSON.parse(request.data);

                const template = $(selector);
                const compiledTemplate = Template7.compile(template.html());
                const html = compiledTemplate(items);

                if (template.data("replace")) {
                    $(selector).replaceWith(html);
                } else {
                    $(selector).nextAll().remove();
                    $(selector).after(html);
                }

                resolve();
            } else {
                reject();
            }
        });
    }

    async RenderFromObject(object, selector) {
        const items = object;

        const template = $(selector);
        const compiledTemplate = Template7.compile(template.html());
        const html = compiledTemplate(items);

        if (template.data("replace")) {
            $(selector).replaceWith(html);
        } else {
            $(selector).nextAll().remove();
            $(selector).after(html);
        }
    }
}