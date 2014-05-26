Return-Path: <wimvs@spo001.leaseweb.com>
Date: Mon, 26 May 2014 23:18:20 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: David Cohen <david.a.cohen@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Subject: Re: [hwmon:watchdog-next 18/34] arch/x86/platform/intel-mid/device_libs/platform_wdt.c:37:2: error: implicit declaration of function 'mp_find_ioapic'
Message-ID: <20140526211820.GB23751@spo001.leaseweb.com>
References: <5374a77f.J4+vnB3mNfBZ172K%fengguang.wu@intel.com> <20140515171947.GA18562@roeck-us.net> <20140515174221.GA3237@psi-dev26.jf.intel.com> <20140518032052.GA545@psi-dev26.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140518032052.GA545@psi-dev26.jf.intel.com>
Sender: <wimvs@spo001.leaseweb.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi David,

> On Thu, May 15, 2014 at 10:42:21AM -0700, David Cohen wrote:
> > On Thu, May 15, 2014 at 10:19:47AM -0700, Guenter Roeck wrote:
> > > Hi David,
> > 
> > Hi Guenter,
> > 
> > > 
> > > can you look into this ? This is from your patch 'x86: intel-mid: add watchdog
> > > platform code for Merrifield'.
> > 
> > Thanks for the info.
> > 
> > > 
> > > Maybe the code should depend on X86_IO_APIC,
> > > or include asm/io_apic.h explicitly (which might be appropriate anyway).
> > 
> > I'll send a fix.
> 
> Do you prefer an incremental patch fixing this issue or a replacement
> for the first one?

Do you allready have a fix?

Thanks in advance,
Wim.
