/**
 * Share Buttons functionality
 * Handles copy link and native share API
 */

(function() {
    'use strict';

    // Toast notification function
    function showToast(message, type = 'success') {
        const toast = document.getElementById('share-toast');
        if (!toast) return;

        const messageEl = toast.querySelector('.share-toast__message');
        if (messageEl) {
            messageEl.textContent = message;
        }

        toast.classList.add('show');
        if (type === 'error') {
            toast.classList.add('error');
        } else {
            toast.classList.remove('error');
        }

        // Hide after 3 seconds
        setTimeout(() => {
            toast.classList.remove('show');
        }, 3000);
    }

    // Initialize copy link buttons
    function initCopyButtons() {
        const copyButtons = document.querySelectorAll('[data-copy-url]');
        
        copyButtons.forEach(button => {
            button.addEventListener('click', async function() {
                const url = this.dataset.copyUrl;
                
                try {
                    await navigator.clipboard.writeText(url);
                    showToast('คัดลอกลิงก์แล้ว!');
                } catch (err) {
                    console.error('Failed to copy:', err);
                    showToast('ไม่สามารถคัดลอกได้', 'error');
                }
            });
        });
    }

    // Initialize native share buttons
    function initNativeShareButtons() {
        const shareButtons = document.querySelectorAll('[data-share-url]');
        
        shareButtons.forEach(button => {
            button.addEventListener('click', async function() {
                const title = this.dataset.shareTitle || document.title;
                const url = this.dataset.shareUrl || window.location.href;
                const text = this.dataset.shareText || '';

                // Check if Web Share API is supported
                if (navigator.share) {
                    try {
                        await navigator.share({
                            title: title,
                            text: text,
                            url: url
                        });
                    } catch (err) {
                        // User cancelled or share failed
                        if (err.name !== 'AbortError') {
                            console.error('Share failed:', err);
                        }
                    }
                } else {
                    // Fallback: try to copy link
                    try {
                        await navigator.clipboard.writeText(url);
                        showToast('คัดลอกลิงก์แล้ว!');
                    } catch (err) {
                        showToast('ไม่รองรับการแชร์บนอุปกรณ์นี้', 'error');
                    }
                }
            });
        });
    }

    // Initialize when DOM is ready
    function init() {
        initCopyButtons();
        initNativeShareButtons();
    }

    // Run initialization
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
