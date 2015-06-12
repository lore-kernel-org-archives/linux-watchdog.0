Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from lb1-smtp-cloud2.xs4all.net ([194.109.24.21]:49937 "EHLO
	lb1-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750931AbbFLJf0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 12 Jun 2015 05:35:26 -0400
Message-ID: <1434101718.2271.166.camel@x220>
Subject: Re: [PATCH 1/4] x86: Add basic support for the Congatec CGEB BIOS
 interface
From: Paul Bolle <pebolle@tiscali.nl>
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-kernel@vger.kernel.org, sameo@linux.intel.com,
	lee.jones@linaro.org, wsa@the-dreams.de, jdelvare@suse.de,
	linux-i2c@vger.kernel.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org, jingoohan1@gmail.com,
	Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 12 Jun 2015 11:35:18 +0200
In-Reply-To: <1434055734-3602-2-git-send-email-christian.gmeiner@gmail.com>
References: <1434055734-3602-1-git-send-email-christian.gmeiner@gmail.com>
	 <1434055734-3602-2-git-send-email-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

A few nits.

On Thu, 2015-06-11 at 22:48 +0200, Christian Gmeiner wrote:
> --- /dev/null
> +++ b/drivers/mfd/congatec-cgeb.c

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

> +/*
> + * cgeb_invoke - invoke CGEB BIOS call.

s/cgeb_invoke/cgeb_call/

> + *
> + * @board:     board context data
> + * @p:         CGEB parameters for this call
> + * @fct:       CGEB function code
> + * @return:    0 on success or negative error code on failure.
> + *
> + * Call the CGEB BIOS code with the given parameters.
> + */
> +unsigned int cgeb_call(struct cgeb_board_data *board,
> +		 struct cgeb_function_parameters *p, cgeb_function_t fct)
> +{
> +	[...]
> +}

> +static int __init cgeb_init(void)
> +{
> +	[...]
> +}
> +
> +static void cgeb_exit(void)
> +{
> +	[...]
> +}
> +
> +module_init(cgeb_init);
> +module_exit(cgeb_exit);

cgeb_exit is only used through module_exit(). So I guess it could be
marked __exit, right?

> +MODULE_LICENSE("GPL");

The comment at the top of this file states the license is GPL v2. The
MODULE_LICENSE() macro states, according to include/linux/module.h, that
the license is GPL v2 or later. So I think one of these two needs to
change.

I spotted the same license mismatch in 2/4, 3/4 and 4/4.

Thanks,


Paul Bolle

