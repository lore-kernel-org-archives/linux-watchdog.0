Return-path: <timur@codeaurora.org>
Message-ID: <5543D8B2.9070001@codeaurora.org>
Date: Fri, 01 May 2015 14:49:06 -0500
From: Timur Tabi <timur@codeaurora.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-watchdog@vger.kernel.org,
 Ashwin Chaugule <ashwin.chaugule@linaro.org>,
 Vipul Gandhi <vgandhi@codeaurora.org>, Fu Wei <fu.wei@linaro.org>,
 Al Stone <al.stone@linaro.org>,
 Wim Van Sebroeck <wim@iguana.be>, Hanjun Guo <hanjun.guo@linaro.org>,
 linaro-acpi@lists.linaro.org
Subject: Re: [PATCH] watchdog: introduce the ARM64 SBSA watchdog driver
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org> <5542F33D.2020206@roeck-us.net> <5543A6E9.1090203@codeaurora.org> <20150501174953.GB7712@roeck-us.net> <5543C921.9050800@codeaurora.org> <20150501192656.GA4928@roeck-us.net>
In-Reply-To: <20150501192656.GA4928@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 05/01/2015 02:26 PM, Guenter Roeck wrote:

> I can understand why that mandates that the driver has to be built into the
> kernel, at least if you and/or the arm64 maintainers don't want to export
> those functions. However, I still don't understand why you would need
> arm_sbsa_wdt_pdev declared twice.
>
> What am I missing here ?

Sorry, I didn't completely read your email.  I thought you were asking 
why it couldn't be compiled as a module.

The local version of arm_sbsa_wdt_pdev should be deleted.  In fact, I 
could have sworn I fixed that bug already, but apparently not.

>> If you're telling me that the code is wrong and it will generate false
>> positives, then I can fix it.  But if you're telling me that you don't
>> understand why I'm doing some error checking on the ACPI tables that I'm
>> parsing, well, I don't understand what could be wrong with that.
>>
> I understand the checking. I don't understand why you think you need an error
> message instead of just returning ENODEV if the tables are not there.

So I've modified the code to not display a message if the tables are 
merely absent.  It will still print an error if the table is invalid.

>> I don't understand what you mean when you say something is wrong with
>> acpi_gtdt_header and/or with acpi_gtdt_watchdog.  These structures look
>> perfectly fine to me, and they work.  My driver successfully loads and
>> parses the ACPI tables on a real ARM64 server system.
>>
> The length field is either 8 bit long or 16 bit. Your code assumes both.

Ah, now I see it.  I will have to look into that and get back to you.

> Question here is if enabling ACPI support disables devcietree, and if enabling
> devicetree disables ACPI. If both can be enabled, and if an image can be built
> which supports both, this would result in stray and unexpected error messages
> if the image is loaded on a system supporting devicetree.

Enabling ACPI does not disable DT, because the EFI stub creates a "mini 
DT" that is still used by the kernel.  I forgot what's in it, but I 
think the DT contains a pointer to the ACPI tables.  However, no actual 
device information is in that DT.

> If both ACPI and OF can be enabled, and if you want the error messages,
> I would expect to see an additional dependency on !OF.

Well, arm_sbsa_wdt_parse_gtdt() will only be called if the watchdog 
subtable in the GTDT exists.

> Question though is if the driver can (and will) be built into an image which
> can run on other systems. There is no SBSA dependency, after all, only an
> ACPI dependency. If there is no "silent" means for the driver to fail
> instantiation, and if the driver is always loaded if present in an image,
> I would expect that it must only be built into an image if that image is
> built specifically to _only_ run on SBSA systems.

Yes, you're right.  I've modified the driver so that it exits quietly if 
there is no GTDT or watchdog subtable.
> So ACPI based watchdog support and ACPI_SIG_GTDT / ACPI_GTDT_TYPE_WATCHDOG
> is mandatory for arm64 servers which support ACPI ?

Probably not.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
