Return-path: <jonathan.yong@intel.com>
Message-ID: <573BF421.2020503@intel.com>
Date: Wed, 18 May 2016 12:48:33 +0800
From: "Yong, Jonathan" <jonathan.yong@intel.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
CC: qipeng.zha@intel.com
Subject: Re: [PATCH 2/2] x86: Fix Apollo Lake Watchdog address in PMC driver
References: <1463541972-19758-1-git-send-email-jonathan.yong@intel.com> <1463541972-19758-3-git-send-email-jonathan.yong@intel.com> <573BE985.1000306@roeck-us.net>
In-Reply-To: <573BE985.1000306@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 05/18/2016 12:03, Guenter Roeck wrote:
> On 05/17/2016 08:26 PM, Yong, Jonathan wrote:
>> The TCO I/O base is 40h rather than the usual 30h, and the
>> re_reboot bit is at ACPIBASE+8.
>>
>
> Does this mean that the code never worked, or in other words that it
> was never tested, or are there now other chips which used the old
> definitions which no longer work after this patch has been applied ?

To my knowledge, it has never worked since 30h is claimed by ACPI GPE0_BLK.

With this patch, watchdog ioctl is working properly with 
WDIOC_SETTIMEOUT, WDIOC_GETTIMEOUT and WDIOC_GETTIMELEFT as expected.
