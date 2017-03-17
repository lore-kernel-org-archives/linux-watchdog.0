Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8251 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751286AbdCQRln (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 17 Mar 2017 13:41:43 -0400
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v2 3/4] watchdog: iTCO_wdt: Fix PMC GCR memory mapping
 failure
References: <b89221c652d06c3c07fdf2ec32fd4fc8930c64df.1489710235.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <2c41b3b6344f9cb455ac57e1e41aa229adb2867d.1489710235.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170317114313.GE24582@rajaneesh-OptiPlex-9010>
 <0a68f91f-e396-90aa-8337-cad3aa28a0f7@roeck-us.net>
 <CAHp75VdyW-kH2nzk63_A=XD62ftrMbSfbec9nBiKbexpP+9zkg@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        David Box <david.e.box@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <4e054912-1e6c-b92a-05c5-75610e621c64@linux.intel.com>
Date: Fri, 17 Mar 2017 10:37:59 -0700
MIME-Version: 1.0
In-Reply-To: <CAHp75VdyW-kH2nzk63_A=XD62ftrMbSfbec9nBiKbexpP+9zkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 03/17/2017 07:25 AM, Andy Shevchenko wrote:
> On Fri, Mar 17, 2017 at 3:40 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 03/17/2017 04:43 AM, Rajneesh Bhardwaj wrote:
>>> On Thu, Mar 16, 2017 at 05:41:35PM -0700, Kuppuswamy Sathyanarayanan
>>> wrote:
>>>> Currently, iTCO watchdog driver uses memory map to access
>>>> PMC_CFG GCR register. But the entire GCR address space is
>>>> already mapped in intel_scu_ipc driver. So remapping the
>> I don't think I (or the watchdog mailing list) was copied on the original
>> patch.
>> Major immediate concern is that this introduces a dependency on external
>> code.
>> The pmc_ipc driver's Kconfig entry states "This is not needed for PC-type
>> machines". I don't know where the function is introduced, but I hope this
>> change
>> does not require the pmc_ipc code to be present on such machines for the
>> watchdog
>> to work. It would be bad if it does. If it doesn't, it appears that the
>> function
>> should not be declared in asm/intel_pmc_ipc.h.
> Agree.
>
> I already asked once [1] to fix up the mess we have in PDx86 regarding SCU IPC.
> (PMC IPC how it's called is actually just a [main] part of SCU in newer SoCs).
>
> Rajneesh, Kuppuswamy,
> please pay attention on the below.
>
> We have two libraries doing almost the same (basics) one for old
> platforms, one for new.
>
> My vision what should be done before we go further is:
> 1. Split out common part from intel_scu_ipc and intel_pmc_ipc to some library.
I think we should create MFD driver for PMC and remove the redundant 
resource and platform device creation codes.
Yes, there is common code in IPC implementation between scu_ipc and 
pmc_ipc code. This needs be modularized.

I can work on it and send a RFC patch for this cleanup. But it could 
take more time for merging this cleanup patch.
So I think, in the mean time, we should merge this watchdog fix first to 
remove iTCO watchdog device probe issue.
> 2. Move headers to linux/platform_data/x86 for sharing with drivers
> that are supporting non-Intel / not-newest-Intel hardware.
> 3. Fix the mess inside the intel_pmc_ipc code (like use devm_()
> helpers where it makes sense, no use of global variables, etc)
Agreed.
>
> On top of that
> 4. Fix up Whiskey Cove PMIC code (See Hans' message [2] for the details)
>
> [1] Oops, it happened on internal mailing list Jan 27. And mentioned
> publicly after in a review on some patch here.
> [2] http://lkml.iu.edu/hypermail/linux/kernel/1702.3/01408.html
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer

