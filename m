Return-path: <Ray.Huang@amd.com>
Date: Mon, 23 Nov 2015 11:35:51 +0800
From: Huang Rui <ray.huang@amd.com>
To: Denis Turischev <denis.turischev@compulab.co.il>
CC: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, Vincent Wan <vincent.wan@amd.com>, Tony Li
	<tony.li@amd.com>
Subject: Re: [PATCH] sp5100_tco: Add AMD Mullins platform support
Message-ID: <20151123033549.GA2666@hr-amur2>
References: <564D9CB0.1090209@compulab.co.il>
 <20151120023322.GB21619@hr-amur2>
 <565182B0.9070604@compulab.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <565182B0.9070604@compulab.co.il>
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, Nov 22, 2015 at 10:54:08AM +0200, Denis Turischev wrote:
> Hi Rui,
> 
> On 11/20/2015 04:33 AM, Huang Rui wrote:
> > Hi Denis,
> > 
> > On Thu, Nov 19, 2015 at 05:56:00PM +0800, Denis Turischev wrote:
> >> AMD Mullins watchdog is fully compatible to the previous Hudson chipset,
> >> reuse the existent sp5100_tco driver.
> >>
> > 
> > Thank you to add this support!
> > Actually, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS is only the SMBus device id
> > on AMD mullins but also on many other AMD platforms. Could you please
> > share some test method to me, that I am glad to do some quick tests. :)
> 
> My device is Compulabs's fitlet. It's a fanless mini PC, also known as mintbox mini.
> http://fit-pc.com/wiki/index.php/Fit-PC_Product_Line:_fitlet
> Processor's datasheet:
> http://support.amd.com/TechDocs/52740_16h_Models_30h-3Fh_BKDG.pdf
> 
> The dmesg output:
> sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
> sp5100_tco: PCI Revision ID: 0x42
> sp5100_tco: Using 0xfeb00000 for watchdog MMIO address
> sp5100_tco: Last reboot was not triggered by watchdog.
> sp5100_tco: initialized (0xffffc90000702000). heartbeat=60 sec (nowayout=0)
> 

I verified it in my side. Thank you. :)
And found AMD new Carrizo platform also supported sp5100_tco watchdog.
I will send a patch to add support to KernCZ(Carrizo) chipset later.

Tested-by: Huang Rui <ray.huang@amd.com>
