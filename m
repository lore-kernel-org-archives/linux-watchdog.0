Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38797 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753172AbdJHSie (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 8 Oct 2017 14:38:34 -0400
MIME-Version: 1.0
In-Reply-To: <e70046c8d49173840f8ee7218e8b2288301f8e67.1507414288.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1507414288.git.sathyanarayanan.kuppuswamy@linux.intel.com> <e70046c8d49173840f8ee7218e8b2288301f8e67.1507414288.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 8 Oct 2017 21:38:33 +0300
Message-ID: <CAHp75VdaTvaOgNJE1vHHDfT2V8MYyQFnpr0qdUmBVJ2743eQKA@mail.gmail.com>
Subject: Re: [RFC v5 1/8] platform/x86: intel_pmc_ipc: Use spin_lock to
 protect GCR updates
To: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        "x86@kernel.org" <x86@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Ingo Molnar <mingo@redhat.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy@infradead.org>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>,
        Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kupuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Oct 8, 2017 at 1:19 AM,
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Currently, update_no_reboot_bit() function implemented in this driver
> uses mutex_lock() to protect its register updates. But this function is
> called with in atomic context in iTCO_wdt_start() and iTCO_wdt_stop()
> functions in iTCO_wdt.c driver, which in turn causes "sleeping into
> atomic context" issue. This patch fixes this issue by replacing the
> mutex_lock() with spin_lock() to protect the GCR read/write/update APIs.
>
> Fixes: 9d855d4 ("platform/x86: intel_pmc_ipc: Fix iTCO_wdt GCS memory mapping failure")
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kupuswamy@linux.intel.com>

>  * Rebased this patch on top of Andy's review branch.

Oh, what I asked you is to use vanilla kernel as a base.
Please, be sure (you assured me, though it's not true) that it's
applied against vanilla (or our fixes branch) and send just this one
patch separately.

No need to resend v5 right now.

-- 
With Best Regards,
Andy Shevchenko
