Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:34596 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751330AbaBQVIe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 17 Feb 2014 16:08:34 -0500
Date: Mon, 17 Feb 2014 16:08:22 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v7 11/18] watchdog: orion: Add per-compatible watchdog
 start implementation
Message-ID: <20140217210822.GC7862@titan.lakedaemon.net>
References: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1392073237-2554-12-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392073237-2554-12-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Feb 10, 2014 at 08:00:30PM -0300, Ezequiel Garcia wrote:
> To handle differences between SoCs this commit adds per-compatible
> string start() function for the watchdog kick-off. This is preparation
> work and makes no functionality changes to the current driver.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Tested-by: Willy Tarreau <w@1wt.eu>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/watchdog/orion_wdt.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index b48fd08..3925297 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -50,6 +50,7 @@ struct orion_watchdog_data {
>  	int rstout_enable_bit;


>  	int (*clock_init)(struct platform_device *,
>  			  struct orion_watchdog *);

this...

> +	int (*start)(struct watchdog_device *);
>  };
>  
>  struct orion_watchdog {
...
> @@ -193,6 +202,7 @@ static const struct orion_watchdog_data orion_data = {
>  	.wdt_enable_bit = BIT(4),
>  	.wdt_counter_offset = 0x24,


>  	.clock_init = orion_wdt_clock_init,

and this...

> +	.start = orion_start,
>  };

cause a failure to apply the patch.  I hand-jammed it (attached), please
let me know what is going on here (missed dep?)

thx,

Jason.

-----------8<-----------------
commit 14181fe244605b53829ec87f9f6af85d5ec2f8ce
Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Date:   Mon Feb 10 20:00:30 2014 -0300

    watchdog: orion: Add per-compatible watchdog start implementation
    
    To handle differences between SoCs this commit adds per-compatible
    string start() function for the watchdog kick-off. This is preparation
    work and makes no functionality changes to the current driver.
    
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
    Tested-by: Willy Tarreau <w@1wt.eu>
    Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
    Acked-by: Wim Van Sebroeck <wim@iguana.be>
    Signed-off-by: Jason Cooper <jason@lakedaemon.net>

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index b220e34285d1..573859cff72f 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -46,6 +46,7 @@ struct orion_watchdog_data {
 	int wdt_counter_offset;
 	int wdt_enable_bit;
 	int rstout_enable_bit;
+	int (*start)(struct watchdog_device *);
 };
 
 struct orion_watchdog {
@@ -66,7 +67,7 @@ static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
-static int orion_wdt_start(struct watchdog_device *wdt_dev)
+static int orion_start(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
 
@@ -85,6 +86,14 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static int orion_wdt_start(struct watchdog_device *wdt_dev)
+{
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
+
+	/* There are some per-SoC quirks to handle */
+	return dev->data->start(wdt_dev);
+}
+
 static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
@@ -172,6 +181,7 @@ static const struct orion_watchdog_data orion_data = {
 	.rstout_enable_bit = BIT(1),
 	.wdt_enable_bit = BIT(4),
 	.wdt_counter_offset = 0x24,
+	.start = orion_start,
 };
 
 static const struct of_device_id orion_wdt_of_match_table[] = {
