Return-path: <dvhart@infradead.org>
Date: Tue, 24 May 2016 13:13:16 -0700
From: Darren Hart <dvhart@infradead.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Yong, Jonathan" <jonathan.yong@intel.com>,
	linux-watchdog@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	qipeng.zha@intel.com
Subject: Re: [PATCH 2/2] x86: Fix Apollo Lake Watchdog address in PMC driver
Message-ID: <20160524201316.GA5857@f23x64.localdomain>
References: <1463541972-19758-1-git-send-email-jonathan.yong@intel.com>
 <1463541972-19758-3-git-send-email-jonathan.yong@intel.com>
 <573BE985.1000306@roeck-us.net>
 <573BF421.2020503@intel.com>
 <573C7E0C.7050304@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <573C7E0C.7050304@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, May 18, 2016 at 07:37:00AM -0700, Guenter Roeck wrote:
> On 05/17/2016 09:48 PM, Yong, Jonathan wrote:
> >On 05/18/2016 12:03, Guenter Roeck wrote:
> >>On 05/17/2016 08:26 PM, Yong, Jonathan wrote:
> >>>The TCO I/O base is 40h rather than the usual 30h, and the
> >>>re_reboot bit is at ACPIBASE+8.
> >>>
> >>
> >>Does this mean that the code never worked, or in other words that it
> >>was never tested, or are there now other chips which used the old
> >>definitions which no longer work after this patch has been applied ?
> >
> >To my knowledge, it has never worked since 30h is claimed by ACPI GPE0_BLK.
> >
> Hmm.. Darren will have to take that one. I am not in a position to
> determine if the new patch is correct or not, and/or if it causes some
> other platform/architecture to fail. I'll Ack the other patch, and
> would suggest for Darren to take it as well to keep the two patches together.

I actually have the same exact question :-)

The history of this driver is for Apollo Lake, so the question is if there exist
v3 and v5 APL products, or if we only need to concern ourselves with v5 in the
upstream driver.

Especially given the "I don't know if this is the right way" in the cover
letter, I will need an Acked-by at the very least from Qipeng.

Jonathan, please remember to Cc ALL the maintainers and all the lists listed by
get_maintainers when sending patches:

$ scripts/get_maintainer.pl -f drivers/platform/x86/intel_pmc_ipc.c
Zha Qipeng <qipeng.zha@intel.com> (maintainer:INTEL PMC/P-Unit IPC DRIVER)
Darren Hart <dvhart@infradead.org> (maintainer:X86 PLATFORM DRIVERS)
platform-driver-x86@vger.kernel.org (open list:INTEL PMC/P-Unit IPC DRIVER)
linux-kernel@vger.kernel.org (open list)

In particular, ALL patches MUST cc  LKML.

> 
> Guenter
> 
> >With this patch, watchdog ioctl is working properly with WDIOC_SETTIMEOUT, WDIOC_GETTIMEOUT and WDIOC_GETTIMELEFT as expected.
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe platform-driver-x86" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Darren Hart
Intel Open Source Technology Center
