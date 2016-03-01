Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34067 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbcCAW7H (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 1 Mar 2016 17:59:07 -0500
Received: by mail-vk0-f49.google.com with SMTP id e185so184137666vkb.1
        for <linux-watchdog@vger.kernel.org>; Tue, 01 Mar 2016 14:59:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1456693943-6876-7-git-send-email-linux@roeck-us.net>
References: <1456693943-6876-1-git-send-email-linux@roeck-us.net>
	<1456693943-6876-7-git-send-email-linux@roeck-us.net>
Date: Tue, 1 Mar 2016 14:59:06 -0800
Message-ID: <CAD=FV=U=FC7jA5=0nP+=wWOxiiDLsCop0+8=o=+j7FvPa2ZvgA@mail.gmail.com>
Subject: Re: [PATCH v8 06/10] watchdog: dw_wdt: Convert to use watchdog infrastructure
From: Doug Anderson <dianders@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Guenter,

On Sun, Feb 28, 2016 at 1:12 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> Convert driver to use watchdog infrastructure. This includes
> infrastructure support to handle watchdog keepalive if the watchdog
> is running while the watchdog device is closed.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
> ---
> v8: max_hw_timeout_ms -> max_hw_heartbeat_ms
>     Rebased to v4.5-rc5
> v7: Set max_hw_timeout_ms
>     Rebased to v4.5-rc1
> v6: Added patch
> ---
>  drivers/watchdog/Kconfig  |   1 +
>  drivers/watchdog/dw_wdt.c | 323 +++++++++++++++++-----------------------------
>  2 files changed, 117 insertions(+), 207 deletions(-)

I re-ran the same set of tests I ran against v7.  They all still pass.

Tested-by: Douglas Anderson <dianders@chromium.org>
