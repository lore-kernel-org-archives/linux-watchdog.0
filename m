Return-path: <alexey.kv@gmail.com>
Date: Sun, 17 Jul 2016 10:14:53 +0300
From: Alexey Kunitskiy <alexey.kv@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 1/1] watchdog: add support for MCP78S chipset in
 nv_tco
Message-ID: <20160717101453.4e3e8d2a@hades.home>
In-Reply-To: <20160716171540.GA29247@roeck-us.net>
References: <20160715115334.680ab21a@hades.home>
	<20160716171540.GA29247@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On Sat, 16 Jul 2016 10:15:40 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On Fri, Jul 15, 2016 at 11:53:34AM +0300, Alexey Kunitskiy wrote:
> > Add support for MCP78S chipset in nv_tco watchdog driver
> > Patch tested successfully on 4.1.27 kernel and ASUS M4N78-AM V2
> > motherboard
> > 
> > Signed-off-by: Aleksey Kunitskiy <alexey.kv@gmail.com>
> > 
> 
> The patch must be based on an old kernel; the driver was enhanced
> about a year ago to add support for a different chip. That change is
> not included in your patch, causing it to fail to apply.
> 
> Also, your patch does not follow the normal patch format, and thus
> fails to apply when using "git am", which complains that the
> to-be-patched file does not exist.
> 
> Please make sure that the patch applies cleeanly to the latest
> upstream kernel.

I've just followed guide in kernel doc to generate patch using 'diff -up'. Please find a new one atop of mainline kernel:

diff --git a/drivers/watchdog/nv_tco.c b/drivers/watchdog/nv_tco.c
--- a/drivers/watchdog/nv_tco.c
+++ b/drivers/watchdog/nv_tco.c
@@ -294,6 +294,8 @@
 	  PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SMBUS,
 	  PCI_ANY_ID, PCI_ANY_ID, },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP78S_SMBUS,
+	  PCI_ANY_ID, PCI_ANY_ID, },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP79_SMBUS,
 	  PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },			/* End of list */


Signed-off-by: Aleksey Kunitskiy <alexey.kv@gmail.com>

> 
> Thanks,
> Guenter
> 
> > 
> > -----------------
> > Regards,
> > Aleksey Kunitskiy
> > ---
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-watchdog" in the body of a message to
> > majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> > 
> > --- drivers/watchdog/nv_tco.c.orig	2016-07-14
> > 22:28:15.721583870 +0300 +++ drivers/watchdog/nv_tco.c
> > 2016-07-14 22:28:48.838310400 +0300 @@ -294,6 +294,8 @@ static
> > const struct pci_device_id tco_pc PCI_ANY_ID, PCI_ANY_ID, },
> >  	{ PCI_VENDOR_ID_NVIDIA,
> > PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SMBUS, PCI_ANY_ID, PCI_ANY_ID, },
> > +	{ PCI_VENDOR_ID_NVIDIA,
> > PCI_DEVICE_ID_NVIDIA_NFORCE_MCP78S_SMBUS,
> > +	  PCI_ANY_ID, PCI_ANY_ID, },
> >  	{ 0, },			/* End of list */
> >  };
> >  MODULE_DEVICE_TABLE(pci, tco_pci_tbl);




-----------------
Regards,
Aleksey Kunitskiy
