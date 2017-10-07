Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33509 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbdJGQNS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 7 Oct 2017 12:13:18 -0400
MIME-Version: 1.0
In-Reply-To: <c2932168ae25c83f2b2ee6a570274cd0670ba543.1507340643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1507340643.git.sathyanarayanan.kuppuswamy@linux.intel.com> <c2932168ae25c83f2b2ee6a570274cd0670ba543.1507340643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 7 Oct 2017 19:13:16 +0300
Message-ID: <CAHp75VdFybPNxXU5URVHBBWROV6h1eX+u_R-r5Kue08kBUmGHQ@mail.gmail.com>
Subject: Re: [RFC v4 2/8] platform/x86: intel_pmc_ipc: Use spin_lock to
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
        Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Oct 7, 2017 at 5:33 AM,
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

> Fixes: 9d855d4 ("platform/x86: intel_pmc_ipc: Fix iTCO_wdt GCS memory
> mapping failure")

I think it need to be a one line.

Does it apply on top of v4.14-rc3 ?
Btw, this patch should be first in the series.


-- 
With Best Regards,
Andy Shevchenko
