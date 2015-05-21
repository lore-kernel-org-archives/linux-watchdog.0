Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34638 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbbEUJEr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 May 2015 05:04:47 -0400
Message-ID: <555D9FA8.9060106@roeck-us.net>
Date: Thu, 21 May 2015 02:04:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
	linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
CC: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org, timur@codeaurora.org,
	ashwin.chaugule@linaro.org, arnd@arndb.de, vgandhi@codeaurora.org,
	wim@iguana.be, jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net,
	mark.rutland@arm.com
Subject: Re: [PATCH v2 5/7] Watchdog: introduce "pretimeout" into framework
References: <=fu.wei@linaro.org> <1432197156-16947-1-git-send-email-fu.wei@linaro.org> <1432197156-16947-6-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1432197156-16947-6-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/21/2015 01:32 AM, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> Also update Documentation/watchdog/watchdog-kernel-api.txt to
> introduce:
> (1)the new elements in the watchdog_device and watchdog_ops struct;
> (2)the new API "watchdog_init_timeouts".
>
> Reasons:
> (1)kernel already has two watchdog drivers are using "pretimeout":
> 	drivers/char/ipmi/ipmi_watchdog.c
> 	drivers/watchdog/kempld_wdt.c(but the definition is different)
> (2)some other dirvers are going to use this: ARM SBSA Generic Watchdog
>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---

[ ... ]

> +extern int watchdog_init_timeouts(struct watchdog_device *wdd,
> +                                  unsigned int pretimeout_parm,
> +                                  unsigned int timeout_parm,
> +                                  void (*update_limits)(struct watchdog_device *),
> +                                  struct device *dev);
>
> -The watchdog_init_timeout function allows you to initialize the timeout field
> -using the module timeout parameter or by retrieving the timeout-sec property from
> -the device tree (if the module timeout parameter is invalid). Best practice is
> -to set the default timeout value as timeout value in the watchdog_device and
> -then use this function to set the user "preferred" timeout value.
> +The watchdog_init_timeouts function allows you to initialize the pretimeout and
> +timeout fields using the module pretimeout and timeout parameter or by
> +retrieving the elements in the timeout-sec property(the first element is for
> +timeout, the second one is for pretimeout) from the device tree(if the module
> +pretimeout and timeout parameter are invalid).
> +Normally, the pretimeout value will affect the limitation of timeout, and it
> +is also hardware related. So you can write a function in your driver to update
> +the limitation of timeout, according to the pretimeout value. Then pass the
> +function pointer by the update_limits parameter. If you driver doesn't
> +need this adjustment, just pass NULL to the update_limits parameter.

You've lost me a bit with the update_limits function. watchdog_init_timeouts()
is called from the driver. Why should the function have to call back into the
driver to update the parameters which are passed from the driver ?
Seems to me the driver can do that calculation first, then call
watchdog_init_timeouts() with the result. Am I missing something ?

Thanks,
Guenter

