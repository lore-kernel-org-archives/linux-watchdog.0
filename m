Return-Path: <jdelvare@suse.de>
Date: Fri, 14 Mar 2014 20:22:41 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Zwane Mwaikambo <zwanem@gmail.com>, Wim
 Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: Fix SC1200 dependencies
Message-ID: <20140314202241.29339991@endymion.delvare>
In-Reply-To: <20140314180403.GE3868@roeck-us.net>
References: <20140314160728.5abc3f4b@endymion.delvare>
	<20140314180403.GE3868@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

Thanks a lot for this review and all the other ones.

On Fri, 14 Mar 2014 11:04:03 -0700, Guenter Roeck wrote:
> On Fri, Mar 14, 2014 at 04:07:28PM +0100, Jean Delvare wrote:
> > The SC1200 is a SoC based on the Geode GX1 32-bit x86 processor, so
> > its drivers are only needed on this architecture.
>
> The driver is named SC1200, but isn't really SC1200 specific but 
> supports the PC87307/PC97307. Not really sure if it is good idea
> to remove support for it from 64 bit images. Can we say for sure
> that there are no 64 bit systems using this chip ?

Grmpf. The driver name is definitely confusing but I'm afraid you're
right. Even more confusing is the existence of an SCx200_WDT driver,
which is supposed to drive the same watchdog but as a PCI device? And
that one does depend on SCx200 which in turn depends on X86_32. I don't
quite get the point of having two drivers for the same device, but I'm
probably missing something.

Anyway, let's just forget about this patch then. Sorry for the noise.

-- 
Jean Delvare
SUSE L3 Support
