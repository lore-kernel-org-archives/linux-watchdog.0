Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:41617 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753562AbdG2LHj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 29 Jul 2017 07:07:39 -0400
Date: Sat, 29 Jul 2017 13:07:37 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Moritz Fischer <mdf@kernel.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, a.zummo@towertech.it, wim@iguana.be,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Moritz Fischer <moritz.fischer@ettus.com>
Subject: Re: [PATCH 2/2] mfd: ds1374: Add Dallas/Maxim DS1374 Multi Function
 Device
Message-ID: <20170729110737.dl2nly5xvurmb7eo@piout.net>
References: <1499975665-14581-1-git-send-email-mdf@kernel.org>
 <1499975665-14581-2-git-send-email-mdf@kernel.org>
 <20170717075117.btnhbmgpofwn7zdk@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717075117.btnhbmgpofwn7zdk@dell>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 17/07/2017 at 08:51:17 +0100, Lee Jones wrote:
> > +static int ds1374_probe(struct i2c_client *client,
> > +			const struct i2c_device_id *id)
> > +{
> > +	struct ds1374 *ds1374;
> > +	u32 mode;
> > +	int err;
> > +
> > +	ds1374 = devm_kzalloc(&client->dev, sizeof(struct ds1374), GFP_KERNEL);
> > +	if (!ds1374)
> > +		return -ENOMEM;
> > +
> > +	ds1374->regmap = devm_regmap_init_i2c(client, &ds1374_regmap_config);
> > +	if (IS_ERR(ds1374->regmap))
> > +		return PTR_ERR(ds1374->regmap);
> > +
> > +	if (IS_ENABLED(CONFIG_OF) && client->dev.of_node) {
> > +		err = of_property_read_u32(client->dev.of_node,
> > +					   "dallas,mode", &mode);
> > +		if (err < 0) {
> > +			dev_err(&client->dev, "missing dallas,mode property\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		ds1374->remapped_reset
> > +			= of_property_read_bool(client->dev.of_node,
> > +						"dallas,remap-reset");
> > +
> > +		ds1374->mode = (enum ds1374_mode)mode;
> > +	} else if (IS_ENABLED(CONFIG_RTC_DRV_DS1374_WDT)) {
> > +		ds1374->mode = DS1374_MODE_RTC_WDT;
> > +	} else {
> > +		ds1374->mode = DS1374_MODE_RTC_ALM;
> > +	}
> 
> This is non-standard.  So if OF is enabled, you're taking the 'mode'
> from platform data (DT) and if it's not, you're relying on Kconfig.
> May I suggest that you pick platform data OR Kconfig, but not mix the
> two.
> 

I've explicitly asked for that. CONFIG_RTC_DRV_DS1374_WDT has been in
the kernel since 2014. Requiring the use of dallas,mode now would break
the functionality for people not updating their DT.

However, my suggestion was that if OF is enabled and dallas,mode is not
present, then rely on CONFIG_RTC_DRV_DS1374_WDT to set the mode.

I personally don't care too much about breaking the DT ABI but this one
can be a bit tricky to discover and I still think it can be avoided.
At least, we should silently ignore CONFIG_RTC_DRV_DS1374_WDT.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
