Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34773 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdCQSiY (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 17 Mar 2017 14:38:24 -0400
MIME-Version: 1.0
In-Reply-To: <4e054912-1e6c-b92a-05c5-75610e621c64@linux.intel.com>
References: <b89221c652d06c3c07fdf2ec32fd4fc8930c64df.1489710235.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <2c41b3b6344f9cb455ac57e1e41aa229adb2867d.1489710235.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170317114313.GE24582@rajaneesh-OptiPlex-9010> <0a68f91f-e396-90aa-8337-cad3aa28a0f7@roeck-us.net>
 <CAHp75VdyW-kH2nzk63_A=XD62ftrMbSfbec9nBiKbexpP+9zkg@mail.gmail.com> <4e054912-1e6c-b92a-05c5-75610e621c64@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 17 Mar 2017 20:38:21 +0200
Message-ID: <CAHp75VcQLCO2k_YC_-wAweH+JAhsZT5eJpwDNsRRHLM8BtXQEw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] watchdog: iTCO_wdt: Fix PMC GCR memory mapping failure
To: Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        David Box <david.e.box@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Mar 17, 2017 at 7:37 PM, sathyanarayanan kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> On 03/17/2017 07:25 AM, Andy Shevchenko wrote:
>> On Fri, Mar 17, 2017 at 3:40 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>> On 03/17/2017 04:43 AM, Rajneesh Bhardwaj wrote:
>>>> On Thu, Mar 16, 2017 at 05:41:35PM -0700, Kuppuswamy Sathyanarayanan
>>>> wrote:

>> I already asked once [1] to fix up the mess we have in PDx86 regarding SCU
>> IPC.
>> (PMC IPC how it's called is actually just a [main] part of SCU in newer
>> SoCs).
>>
>> Rajneesh, Kuppuswamy,
>> please pay attention on the below.
>>
>> We have two libraries doing almost the same (basics) one for old
>> platforms, one for new.
>>
>> My vision what should be done before we go further is:
>> 1. Split out common part from intel_scu_ipc and intel_pmc_ipc to some
>> library.
>
> I think we should create MFD driver for PMC and remove the redundant
> resource and platform device creation codes.
> Yes, there is common code in IPC implementation between scu_ipc and pmc_ipc
> code. This needs be modularized.
>
> I can work on it and send a RFC patch for this cleanup. But it could take
> more time for merging this cleanup patch.
> So I think, in the mean time, we should merge this watchdog fix first to
> remove iTCO watchdog device probe issue.

I have heard already such excuses. Let's consider this as a "Last
Chinese Warning".

So, we consider reviewing applying *already floating around* patches
in exchange to looking forward for clean up next.
Do we have a deal?

Before you are going to implement anything in the code, please, share
a document (architectural point of view) how you would see things
should be done.
Also consider to address PMC (Atom drivers) and P-Unit drivers which
are related to SCU / IPC to have some structure.

>> 2. Move headers to linux/platform_data/x86 for sharing with drivers
>> that are supporting non-Intel / not-newest-Intel hardware.
>> 3. Fix the mess inside the intel_pmc_ipc code (like use devm_()
>> helpers where it makes sense, no use of global variables, etc)
>
> Agreed.
>>
>>
>> On top of that
>> 4. Fix up Whiskey Cove PMIC code (See Hans' message [2] for the details)
>>
>> [1] Oops, it happened on internal mailing list Jan 27. And mentioned
>> publicly after in a review on some patch here.
>> [2] http://lkml.iu.edu/hypermail/linux/kernel/1702.3/01408.html

-- 
With Best Regards,
Andy Shevchenko
