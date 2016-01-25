Return-path: <gnomes@lxorguk.ukuu.org.uk>
Date: Mon, 25 Jan 2016 19:28:10 +0000
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: wim@iguana.be, linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: Add watchdog timer support for the
 WinSystems EBC-C384
Message-ID: <20160125192810.2487661b@lxorguk.ukuu.org.uk>
In-Reply-To: <20160125190942.GA6824@sophia>
References: <20160125190942.GA6824@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

> +static int ebc_c384_wdt_set_timeout(struct watchdog_device *wdev, unsigned t)
> +{
> +	/* resolution is in minutes for timeouts greater than 255 seconds */
> +	if (t > 255) {
> +		/* truncate second resolution to minute resolution */
> +		t /= 60;
> +		wdev->timeout = t * 60;
> +
> +		/* set watchdog timer for minutes */
> +		outb(0x00, CFG_ADDR);

If ask for 299 seconds surely I should get 300 not 240 ?
(Whether to round off or round up is an interesting question for the
middle range - does it go off early or late - I'd have said late but...)

> +static int __init ebc_c384_wdt_init(void)
> +{
> +	int err;
> +
> +	if (!dmi_match(DMI_BOARD_NAME, "EBC-C384 SBC"))
> +		return -ENODEV;
> +

Is there no ACPI entry for it ?

Alan
