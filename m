Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40508 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbeLQUIl (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Dec 2018 15:08:41 -0500
Date: Mon, 17 Dec 2018 12:08:39 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH] watchdog: add documentation for PM usage
Message-ID: <20181217200839.GB29585@roeck-us.net>
References: <20181217193314.3487-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217193314.3487-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Dec 17, 2018 at 08:33:14PM +0100, Wolfram Sang wrote:
> Add the first rule we recently agreed on.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/watchdog/watchdog-pm.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/watchdog/watchdog-pm.txt
> 
> diff --git a/Documentation/watchdog/watchdog-pm.txt b/Documentation/watchdog/watchdog-pm.txt
> new file mode 100644
> index 000000000000..7a4dd46e0d24
> --- /dev/null
> +++ b/Documentation/watchdog/watchdog-pm.txt
> @@ -0,0 +1,19 @@
> +The Linux WatchDog Timer Power Management Guide
> +===============================================
> +Last reviewed: 17-Dec-2018
> +
> +Wolfram Sang <wsa+renesas@sang-engineering.com>
> +
> +Introduction
> +------------
> +This document states rules about watchdog devices and their power management
> +handling to ensure a uniform behaviour for Linux systems.
> +
> +
> +Ping on resume
> +--------------
> +On resume, a watchdog timer shall be reset to its selected value to give
> +userspace enough time to resume. [1] [2]
> +
> +[1] https://patchwork.kernel.org/patch/10252209/
> +[2] https://patchwork.kernel.org/patch/10711625/
> -- 
> 2.19.1
> 
