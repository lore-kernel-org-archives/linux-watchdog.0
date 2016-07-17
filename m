Return-path: <ezequiel@vanguardiasur.com.ar>
Date: Sun, 17 Jul 2016 19:13:02 -0300
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To: Guenter Roeck <linux@roeck-us.net>
Cc: dvhart@infradead.org, wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: Can't query Intel's iTCO watchdog reboot reason
Message-ID: <20160717221302.GA1111@laptop>
References: <CAAEAJfAEKvLCk2gjj6MR00t-Yg_-XEG1qb0ij6jse=FV3ez5bw@mail.gmail.com>
 <578A6C71.8080705@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <578A6C71.8080705@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

Thanks a lot for the quick reply.

On 16 Jul 10:18 AM, Guenter Roeck wrote:
> On 07/15/2016 04:21 PM, Ezequiel Garcia wrote:
> > Hi everyone,
> > 
> > A large portion of my intel-based products are suffering from
> > a nasty hardware freeze [1], and so I'm currently working this around
> > enabling the iTCO watchdog -- which in any case, it's a good idea
> > to have enabled.
> > 
> > So, it would be interesting to find out on each boot if the machine was
> > rebooted due to a watchdog timeout, but so far I'm not having any luck.
> > 
> > As per Intel's appnote [2] the BIOS should update the WDDT ACPI table,
> > so I added something like this to the iTCO driver:
> > 
> >         status = acpi_get_table(ACPI_SIG_WDDT, 1,
> >                                 (struct acpi_table_header **) &buf);
> >         if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
> >                 pr_err(FW_BUG "failed to get WDDT ACPI table\n");
> >                 return;
> >         }
> > 
> > But it doesn't find the table. Strangely, reading TCO1_STS
> > and TCO2_STS always gives 0x0.
> > 
> 
> That sounds like either the BIOS resets those bits, or the reboots
> are not caused by the watchdog. Are you sure that you see reboots
> that are caused by the watchdog ?
> 

Yes, I'm testing my patch forcing watchdog reboots. At least on my i5
development machine, I haven't found any way of querying the reboot
reason. I'm not even sure this is supposed to work.

I'll see if I can test on other intel machines with TCO watchdogs.

FWIW, here's my (ugly) hack:

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 0acc6c5f729d..0374f90b5050 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -421,12 +421,31 @@ static void iTCO_wdt_cleanup(void)
 	iTCO_wdt_private.gcs_pmc = NULL;
 }
 
+static void iTCO_check_table(void)
+{
+	struct acpi_table_wddt *buf;
+	acpi_status status;
+	u16 wdt_status;
+
+	status = acpi_get_table(ACPI_SIG_WDDT, 1,
+				(struct acpi_table_header **) &buf);
+	if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
+		pr_err(FW_BUG "failed to get WDDT ACPI table\n");
+		return;
+	}
+
+	wdt_status = buf->status;
+	pr_err("ACPI watchdog status: 0x%x\n", wdt_status);
+}
+
 static int iTCO_wdt_probe(struct platform_device *dev)
 {
 	int ret = -ENODEV;
 	unsigned long val32;
 	struct itco_wdt_platform_data *pdata = dev_get_platdata(&dev->dev);
 
+	iTCO_check_table();
+
 	if (!pdata)
 		goto out;
 
@@ -510,6 +529,9 @@ static int iTCO_wdt_probe(struct platform_device *dev)
 	pr_info("Found a %s TCO device (Version=%d, TCOBASE=0x%04llx)\n",
 		pdata->name, pdata->version, (u64)TCOBASE);
 
+	pr_info("TCO1 status 0x%x\n", inw(TCO1_STS));
+	pr_info("TCO2 status 0x%x\n", inw(TCO2_STS));
+
 	/* Clear out the (probably old) status */
 	switch (iTCO_wdt_private.iTCO_version) {
 	case 4:

Thanks,
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
