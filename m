Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.208]:43043 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753040AbdAKJHS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 11 Jan 2017 04:07:18 -0500
Subject: Re: [PATCH 56/62] watchdog: tangox_wdt: Convert to use device managed
 functions
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Mans Rullgard" <mans@mansr.com>,
        Thibaud Cornic <thibaud_cornic@sigmadesigns.com>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-5-git-send-email-linux@roeck-us.net>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Message-ID: <bd56e90c-5cb8-02d8-3518-c8f5483a6df4@sigmadesigns.com>
Date: Wed, 11 Jan 2017 10:07:09 +0100
MIME-Version: 1.0
In-Reply-To: <1484100561-17638-5-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Language: 
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/01/2017 03:09, Guenter Roeck wrote:

> Use device managed functions to simplify error handling, reduce
> source code size, improve readability, and reduce the likelyhood of bugs.
> 
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts used
> to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Use devm_add_action_or_reset() for calls to clk_disable_unprepare
> - Replace 'goto l; ... l: return e;' with 'return e;'
> - Replace 'val = e; return val;' with 'return e;'
> - Replace 'if (e) { return expr; }' with 'if (e) return expr;'
> - Use devm_watchdog_register_driver() to register watchdog device
> 
> Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/tangox_wdt.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
> index d5fcce062920..7688e1b35867 100644
> --- a/drivers/watchdog/tangox_wdt.c
> +++ b/drivers/watchdog/tangox_wdt.c
> @@ -134,12 +134,15 @@ static int tangox_wdt_probe(struct platform_device *pdev)
>  	err = clk_prepare_enable(dev->clk);
>  	if (err)
>  		return err;
> +	err = devm_add_action_or_reset(&pdev->dev,
> +				       (void(*)(void *))clk_disable_unprepare,
> +				       dev->clk);
> +	if (err)
> +		return err;

Hello Guenter,

I would rather avoid the function pointer cast.
How about defining an auxiliary function for the cleanup action?

clk_disable_unprepare() is static inline, so gcc will have to
define an auxiliary function either way. What do you think?

Regards.


diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
index 202c4b9cc921..1a4f6d245a83 100644
--- a/drivers/watchdog/tangox_wdt.c
+++ b/drivers/watchdog/tangox_wdt.c
@@ -114,6 +114,11 @@ static int tangox_wdt_restart(struct notifier_block *nb, unsigned long action,
        return NOTIFY_DONE;
 }
 
+static void cleanup(void *clk)
+{
+       clk_disable_unprepare(clk);
+}
+
 static int tangox_wdt_probe(struct platform_device *pdev)
 {
        struct tangox_wdt_device *dev;
@@ -138,6 +143,10 @@ static int tangox_wdt_probe(struct platform_device *pdev)
        if (err)
                return err;
 
+       err = devm_add_action_or_reset(&pdev->dev, cleanup, dev->clk);
+       if (err)
+               return err;
+
        dev->clk_rate = clk_get_rate(dev->clk);
        if (!dev->clk_rate) {
                err = -EINVAL;

