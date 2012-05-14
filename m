Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:41463 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756700Ab2ENOBn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 May 2012 10:01:43 -0400
Date: Mon, 14 May 2012 16:01:38 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: hdegoede@redhat.com, linux-watchdog@vger.kernel.org,
	Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 1/2 V3] watchdog: Add multiple device support
Message-ID: <20120514140138.GN3074@spo001.leaseweb.com>
References: <1337002196-32569-1-git-send-email-tomas.winkler@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1337002196-32569-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Tomas,

>  	ret = watchdog_dev_register(wdd);
>  	if (ret) {
> -		pr_err("error registering /dev/watchdog (err=%d)\n", ret);
> -		return ret;
> +		ida_simple_remove(&watchdog_ida, id);
> +		if (!(id == 0 || ret == -EBUSY))
> +			return ret;
> +
> +		/* Retry in case a legacy watchdog module exists */

Nope, this should stay
if (!(id == 0 && ret == -EBUSY))

because we will only retry, if we have the possibility that another legacy watchdog is allready there:
i.e. when the id == 0 and when we have a -EBUSY as a return code.A

Kind regards,
Wim.

