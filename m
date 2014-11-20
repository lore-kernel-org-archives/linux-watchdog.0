Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:63935 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757531AbaKTSJD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 20 Nov 2014 13:09:03 -0500
Received: by mail-vc0-f170.google.com with SMTP id hy4so1065916vcb.29
        for <linux-watchdog@vger.kernel.org>; Thu, 20 Nov 2014 10:09:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1416488526-22079-2-git-send-email-jude.abraham@imgtec.com>
References: <1416488526-22079-1-git-send-email-jude.abraham@imgtec.com>
	<1416488526-22079-2-git-send-email-jude.abraham@imgtec.com>
Date: Thu, 20 Nov 2014 10:09:02 -0800
Message-ID: <CAL1qeaGWK+ok1d48i_wrnLdfALjFCRiPZiwwiYUeBSdNdDkHEw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] watchdog: ImgTec PDC Watchdog Timer Driver
From: Andrew Bresticker <abrestic@chromium.org>
To: Jude Abraham <jude.abraham@imgtec.com>
Cc: "wim@iguana.be" <wim@iguana.be>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	James Hartley <james.hartley@imgtec.com>,
	James Hogan <james.hogan@imgtec.com>,
	Naidu Tellapati <naidu.tellapati@imgtec.com>,
	Arul Ramasamy <arul.ramasamy@imgtec.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Jude, Naidu,

On Thu, Nov 20, 2014 at 5:02 AM,  <jude.abraham@imgtec.com> wrote:
> From: Jude Abraham <Jude.Abraham@imgtec.com>
>
> This commit adds support for ImgTec PowerDown Controller Watchdog Timer.
>
> Signed-off-by: Jude Abraham <Jude.Abraham@imgtec.com>
> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>

Two small comments you may want to fix if you need to re-spin the series though:

> +static struct watchdog_info pdc_wdt_info = {
> +       .options                = WDIOF_SETTIMEOUT |
> +                                 WDIOF_KEEPALIVEPING |
> +                                 WDIOF_MAGICCLOSE,
> +       .identity = "IMG PDC Watchdog",
> +};

Inconsistent spacing.

> +       ret = watchdog_init_timeout(&pdc_wdt->wdt_dev, timeout, &pdev->dev);
> +       if (ret < 0)
> +               pdc_wdt->wdt_dev.timeout = pdc_wdt->wdt_dev.max_timeout;

Maybe print an error here?
