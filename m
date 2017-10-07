Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38730 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753214AbdJGW3v (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 7 Oct 2017 18:29:51 -0400
Subject: Re: [RFC v4 2/8] platform/x86: intel_pmc_ipc: Use spin_lock to
 protect GCR updates
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kuppuswamy Sathyanarayanan
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
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <cover.1507340643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <c2932168ae25c83f2b2ee6a570274cd0670ba543.1507340643.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAHp75VdFybPNxXU5URVHBBWROV6h1eX+u_R-r5Kue08kBUmGHQ@mail.gmail.com>
From: "Kuppuswamy, Sathyanarayanan" <sathyaosid@gmail.com>
Message-ID: <98547c75-c7a8-cdb8-a0e0-50d115df286a@gmail.com>
Date: Sat, 7 Oct 2017 15:29:49 -0700
MIME-Version: 1.0
In-Reply-To: <CAHp75VdFybPNxXU5URVHBBWROV6h1eX+u_R-r5Kue08kBUmGHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,


On 10/7/2017 9:13 AM, Andy Shevchenko wrote:
> On Sat, Oct 7, 2017 at 5:33 AM,
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Currently, update_no_reboot_bit() function implemented in this driver
>> uses mutex_lock() to protect its register updates. But this function is
>> called with in atomic context in iTCO_wdt_start() and iTCO_wdt_stop()
>> functions in iTCO_wdt.c driver, which in turn causes "sleeping into
>> atomic context" issue. This patch fixes this issue by replacing the
>> mutex_lock() with spin_lock() to protect the GCR read/write/update APIs.
>>
>> Fixes: 9d855d4 ("platform/x86: intel_pmc_ipc: Fix iTCO_wdt GCS memory
>> mapping failure")
> I think it need to be a one line.
Fixed it in v5 version. But it crosses 80 char limit. I am not sure 
whether its alright.
>
> Does it apply on top of v4.14-rc3 ?
Yes. Just checked it now.  It applies cleanly on top of v4.14-rc3. But 
v5 patch set is re-based on top of your review branch.
So it has dependency on a patch ( "platform/x86: intel_pmc_ipc: Use 
devm_* calls in driver probe function") in your review branch.
> Btw, this patch should be first in the series.
Fixed it in v5 version.
>
>

