Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:56281 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030274AbbEOOF2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 May 2015 10:05:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: fu.wei@linaro.org
Cc: Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org, timur@codeaurora.org,
	ashwin.chaugule@linaro.org, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net
Subject: Re: [PATCH 4/6] Watchdog: introdouce "pretimeout" into framework
Date: Fri, 15 May 2015 16:04:41 +0200
Message-ID: <2464980.1PKdnqcc3c@wuerfel>
In-Reply-To: <1431689090-3125-1-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org> <1431689090-3125-1-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Friday 15 May 2015 19:24:48 fu.wei@linaro.org wrote:
> +static void watchdog_check_min_max_pretimeout(struct watchdog_device *wdd)
> +{
> +       /*
> +        * Check that we have valid min and max pretimeout values, if
> +        * not reset them both to 0 (=not used or unknown)
> +        */
> +       if (wdd->min_pretimeout > wdd->max_pretimeout) {
> +               pr_info("Invalid min and max pretimeout, resetting to 0!\n");
> +               wdd->min_pretimeout = 0;
> +               wdd->max_pretimeout = 0;
> +       }
> +}

I would probably just fold this function into the existing
watchdog_check_min_max_timeout() and check both normal and pre-timeout
there.

> +/**
> + * watchdog_init_pretimeout() - initialize the pretimeout field
> + * @pretimeout_parm: pretimeout module parameter
> + * @dev: Device that stores the timeout-sec property
> + *
> + * Initialize the pretimeout field of the watchdog_device struct with either
> + * the pretimeout module parameter (if it is valid value) or the timeout-sec
> + * property (only if it is a valid value and the timeout_parm is out of bounds).
> + * If none of them are valid then we keep the old value (which should normally
> + * be the default pretimeout value.
> + *
> + * A zero is returned on success and -EINVAL for failure.
> + */
> +int watchdog_init_pretimeout(struct watchdog_device *wdd,
> +                            unsigned int pretimeout_parm, struct device *dev)
> +{
> +       int ret = 0;
> +       u32 timeouts[2];
> +
> +       watchdog_check_min_max_pretimeout(wdd);
> +
> +       /* try to get the timeout module parameter first */
> +       if (!watchdog_pretimeout_invalid(wdd, pretimeout_parm) &&
> +           pretimeout_parm) {
> +               wdd->pretimeout = pretimeout_parm;
> +               return ret;
> +       }
> +       if (pretimeout_parm)
> +               ret = -EINVAL;
> +
> +       /* try to get the timeout_sec property */
> +       if (!dev || !dev->of_node)
> +               return ret;
> +       ret = of_property_read_u32_array(dev->of_node,
> +                                        "timeout-sec", timeouts, 2);
> +       if (!watchdog_pretimeout_invalid(wdd, timeouts[1]) && timeouts[1])
> +               wdd->pretimeout = timeouts[1];
> +       else
> +               ret = -EINVAL;
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(watchdog_init_pretimeout);

Same here: the function is very similar to the watchdog_init_timeout
function, and it reads the same property, so just do both here.

The easiest way for that is probably to use of_find_property()
and of_prop_next_u32() to read the two numbers.

	Arnd

