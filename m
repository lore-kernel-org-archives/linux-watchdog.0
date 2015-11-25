Return-path: <Ray.Huang@amd.com>
Date: Wed, 25 Nov 2015 09:59:18 +0800
From: Huang Rui <ray.huang@amd.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Denis Turischev
	<denis.turischev@compulab.co.il>, Borislav Petkov <bp@alien8.de>, Vincent Wan
	<vincent.wan@amd.com>, Tony Li <tony.li@amd.com>
Subject: Re: [PATCH 1/2] sp5100_tco: fix the device check for SB800 and later
 chipsets
Message-ID: <20151125015916.GA2904@hr-amur2>
References: <1448273256-1793-1-git-send-email-ray.huang@amd.com>
 <56546CEB.3080907@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <56546CEB.3080907@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Nov 24, 2015 at 05:58:03AM -0800, Guenter Roeck wrote:
> On 11/23/2015 02:07 AM, Huang Rui wrote:
> >For SB800 and later chipsets, the register definitions are the same
> >with SB800. And for SB700 and older chipsets, the definitions should
> >be same with SP5100/SB7x0.
> >
> >Signed-off-by: Huang Rui <ray.huang@amd.com>
> >Cc: Denis Turischev <denis.turischev@compulab.co.il>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Would it make sense to rework this driver as pci driver ?
> 

I agree with you. Actually, I thought about this stuff. But sp5100
watchdog is not a pci device in AMD chipset. In another word, it
doesn't export a pci header to OS. At current, we use SMBus pci device
id and vendor id to detect watchdog on the AMD chipset (Because AMD
use SMBus device id and revsion to identify different chipset
version). At the same time, SMbus has its own driver piix4_smbus.
Looks like we don't have a pci header to enumerate the watchdog.

Thanks,
Rui
