Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10494 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890AbaERDU4 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 17 May 2014 23:20:56 -0400
Date: Sat, 17 May 2014 20:20:52 -0700
From: David Cohen <david.a.cohen@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [hwmon:watchdog-next 18/34]
 arch/x86/platform/intel-mid/device_libs/platform_wdt.c:37:2: error: implicit
 declaration of function 'mp_find_ioapic'
Message-ID: <20140518032052.GA545@psi-dev26.jf.intel.com>
References: <5374a77f.J4+vnB3mNfBZ172K%fengguang.wu@intel.com>
 <20140515171947.GA18562@roeck-us.net>
 <20140515174221.GA3237@psi-dev26.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140515174221.GA3237@psi-dev26.jf.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, May 15, 2014 at 10:42:21AM -0700, David Cohen wrote:
> On Thu, May 15, 2014 at 10:19:47AM -0700, Guenter Roeck wrote:
> > Hi David,
> 
> Hi Guenter,
> 
> > 
> > can you look into this ? This is from your patch 'x86: intel-mid: add watchdog
> > platform code for Merrifield'.
> 
> Thanks for the info.
> 
> > 
> > Maybe the code should depend on X86_IO_APIC,
> > or include asm/io_apic.h explicitly (which might be appropriate anyway).
> 
> I'll send a fix.

Do you prefer an incremental patch fixing this issue or a replacement
for the first one?

Br, David
