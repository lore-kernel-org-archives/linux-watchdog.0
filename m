Return-path: <maarten@treewalker.org>
From: Maarten ter Huurne <maarten@treewalker.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Ralf Baechle <ralf@linux-mips.org>, Wim Van Sebroeck <wim@iguana.be>, Paul Burton <paul.burton@imgtec.com>, Paul Cercueil <paul@crapouillou.net>, linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 3/3] MIPS: jz4740: Move reset code to the watchdog driver
Date: Sun, 11 Jan 2015 02:43 +0100
Message-ID: <1766434.QjfqQROysC@hyperion>
In-Reply-To: <54B1CF4B.3070503@roeck-us.net>
References: <1420914550-18335-1-git-send-email-lars@metafoo.de> <1420914550-18335-3-git-send-email-lars@metafoo.de> <54B1CF4B.3070503@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

On Saturday 10 January 2015 17:18:03 Guenter Roeck wrote:
> On 01/10/2015 10:29 AM, Lars-Peter Clausen wrote:
> > @@ -186,9 +208,20 @@ static int jz4740_wdt_probe(struct platform_device
> > *pdev)> 
> >   	if (ret < 0)
> >   		goto err_disable_clk;
> > 
> > +	drvdata->restart_handler.notifier_call = jz4740_wdt_restart;
> > +	drvdata->restart_handler.priority = 128;
> > +	ret = register_restart_handler(&drvdata->restart_handler);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "cannot register restart handler, %d\n",
> > +			ret);
> > +		goto err_unregister_watchdog;
> 
> Are you sure you want to abort in this case ?
> After all, the watchdog would still work.

That raises a similar question: what about the opposite case, where the 
watchdog registration fails? If the resource acquisition part of the probe 
fails, neither the watchdog nor the restart functionality is going to work, 
but if the call to watchdog_register_device() fails, the restart handler 
would still work.

Bye,
		Maarten
