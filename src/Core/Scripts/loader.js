class Loader {
    constructor() {
        this.modules = [];
    }

    async Require(module, filename) {
        if (!this.modules.includes(module)) {
            $.getScript(`/src/Modules/${module}/Scripts/${filename}.js`);
            console.log("module file", module, filename);

            this.modules.push(module);
        } else {
            window[module + "Module"].init();
        }
    }
}