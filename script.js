// Initialize Clipboard.js
var clipboard = new ClipboardJS('.copy-btn');

// Show feedback on copy success
clipboard.on('success', function(e) {
    e.trigger.textContent = 'Copied!';
    setTimeout(function() {
        e.trigger.textContent = 'Copy';
    }, 2000);
    e.clearSelection();
});
