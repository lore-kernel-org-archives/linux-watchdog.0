Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38379 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbdJDMhV (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 4 Oct 2017 08:37:21 -0400
MIME-Version: 1.0
In-Reply-To: <5ba5b3d9-b55a-5834-04e5-b4b9a356dca7@linux.intel.com>
References: <cover.1504588701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5286489131571f149c6b75a8367ceb93cfe6e6be.1504588701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAHp75VdGEf_e6mopQmFG5+Dv3X1f5TwV8cHn2CjA39USqN1JBw@mail.gmail.com> <5ba5b3d9-b55a-5834-04e5-b4b9a356dca7@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Oct 2017 15:37:20 +0300
Message-ID: <CAHp75VeUUbc2AMcuy2X-EduTWMqJSqTkU6nLW=FF8Qu-+OPy2A@mail.gmail.com>
Subject: Re: [RFC v3 3/7] platform/x86: intel_pmc_ipc: Use regmap calls for
 GCR updates
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

On Wed, Oct 4, 2017 at 4:16 AM, sathyanarayanan kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> On 10/01/2017 07:48 AM, Andy Shevchenko wrote:
>> On Tue, Sep 5, 2017 at 8:37 AM,
>> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:

>> Since it sounds as candidate for stable,
>
> Yes.
>>
>> can we have split it to just
>> as less as possible intrusive fix + moving to regmap as a separate
>> change?
>
> If we have to split it into two patches then,
>
> Patch #1 will fix the "sleep in atomic context issue" by replacing
> mutex_lock() with spin_lock()
> in GCR read/write APIs to protect the GCR memory updates.
> Patch #2 will remove GCR read/write/update APIs and replace it with regmap
> APIs. But along with this
> change we will also remove the spin_lock() added in previous patch because
> regmap calls are already
> protected by its own locking mechanism.
>
> Since Patch #2 will clean up what we do in Patch #1, Do we need to split it
> into two patches?

Yes, please do...

>> It should include Fixes: tag as well I suppose.
>
> Agree. I will add Fixes tag in next version.

...because this one will go alone to stable releases.

Be also sure patch #1 will be applied on current vanilla (w/o PDx86
queue involvement).

-- 
With Best Regards,
Andy Shevchenko
