Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay008.isp.belgacom.be ([195.238.6.174]:19501 "EHLO
	mailrelay008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752802Ab1AZVT3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 26 Jan 2011 16:19:29 -0500
Date: Wed, 26 Jan 2011 22:19:24 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [RESEND PATCH] Intel SCU Watchdog Timer Driver for Moorestown
	and Medfield platforms.
Message-ID: <20110126211924.GB3790@infomag.iguana.be>
References: <20110125141322.8904.29179.stgit@bob.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110125141322.8904.29179.stgit@bob.linux.org.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alan,

> +static ssize_t intel_scu_read(struct file *file,
> +			     char __user *user_data,
> +			     size_t len,
> +			     loff_t *user_ppos)
> +{
> +	int result;
> +	u8 buf = 0;
> +
> +	/* we wait for the next interrupt; if more than one */
> +	/* interrupt has occurred since the last read, we */
> +	/* dont care. The data is not critical. We will do */
> +	/* a copy to user each time we get and interrupt */
> +	/* It is up to the Watchdog daemon to be ready to */
> +	/* do the read (which signifies that the driver is */
> +	/* awaiting a keep alive and that a limited time */
> +	/* is available for the keep alive before the system */
> +	/* is rebooted by the timer */
> +	if (wait_event_interruptible(read_wq, warning_flag != 0))
> +		return -ERESTARTSYS;
> +
> +	warning_flag = 0;
> +
> +	/* Please note that the content of the data is irrelevent */
> +	/* All that matters is that the read is available to the user */
> +	result = copy_to_user(user_data, (void *)&buf, 1);
> +
> +	if (result != 0)
> +		return -EFAULT;
> +	else
> +		return 1;
> +
> +}

Since we don't use the read operation for /dev/watchdog up till now:
could you explain what the read function is supposed to do?

Thanks in advance,
Wim.

